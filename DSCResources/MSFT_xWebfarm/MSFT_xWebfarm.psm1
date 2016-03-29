data LocalizedData
{   
}

$_xWebfarm_DefaultLoadBalancingAlgorithm = "WeightedRoundRobin"
$_xWebfarm_DefaultApplicationHostConfig = "%windir%\system32\inetsrv\config\applicationhost.config"

# The Get-TargetResource cmdlet is used to fetch the status of role or Website on the target machine.
# It gives the Website info of the requested role/feature on the target machine.  
function Get-TargetResource 
{
    [OutputType([System.Collections.Hashtable])]
    param 
    (   
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
                
        [string]$ConfigPath
    )        

    Write-Verbose "xWebfarm/Get-TargetResource"
    Write-Verbose "Name: $Name"    
    Write-Verbose "ConfigPath: $ConfigPath"
    
    $config = GetApplicationHostConfig $ConfigPath
    $webFarm = GetWebfarm $Name $config
    GetTargetResourceFromConfigElement $webFarm    
}

# The Set-TargetResource cmdlet is used to create, delete or configuure a website on the target machine. 
function Set-TargetResource 
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param 
    (       
        [ValidateSet("Present", "Absent")]
        [string]$Ensure = "Present",

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [bool]$Enabled = $true,

        [string]$Algorithm,
        [string]$QueryString,
        [string]$ServerVariable,

        [string]$ConfigPath
    )

    Write-Verbose "xWebfarm/Set-TargetResource"
    Write-Verbose "Ensure: $Ensure"
    Write-Verbose "Name: $Name"
    Write-Verbose "Enabled: $Enabled"
    Write-Verbose "Algorithm: $Algorithm"
    Write-Verbose "QueryString: $QueryString"
    Write-Verbose "ServerVariable: $ServerVariable"
    Write-Verbose "ConfigPath: $ConfigPath"
    
    Write-Verbose "Get current webfarm state"

    $config = GetApplicationHostConfig $ConfigPath
    $webFarm = GetWebfarm $Name $config
    $resource = GetTargetResourceFromConfigElement $webFarm

    Write-Verbose "Webfarm presence. From [$($resource.Ensure )] to [$Ensure]"

    if(($Ensure -eq "present") -and ($resource.Ensure -eq "absent")){
        $webFarmElement = $config.CreateElement("webFarm")
        $webFarmElement.SetAttribute("name", $Name)        
        $config.configuration.webFarms.AppendChild($webFarmElement)

        Write-Verbose "Webfarm created: Name = $Name"
        
        $resource = GetTargetResourceFromConfigElement $webFarmElement
        $webFarm = GetWebfarm $Name $config
    }elseif(($Ensure -eq "absent") -and ($resource.Ensure -eq "present")){
        $webFarmElement = $config.configuration.webFarms.webFarm | ? Name -eq $Name
        $config.configuration.webFarms.RemoveChild($webFarmElement)

        Write-Verbose "Webfarm deleted: Name = $Name"

        $resource = GetTargetResourceFromConfigElement $null
        $webFarm = $null
    }
    else {
    }
    
    if (($Ensure -eq "present") -and ($resource.Ensure -eq "present")){
        Write-Verbose "Webfarm configured: Enabled from [$($resource.Enabled)] to [$Enabled]"
        $webFarm.SetAttribute("enabled", $Enabled)
                
        if($Algorithm -eq $null){
            Write-Verbose "Webfarm configured: LoadBalancing from [$($resource.Algorithm)] to []"
            if($webFarm.applicationRequestRouting -ne $null){
                $webFarm.RemoveChild($webFarm.applicationRequestRouting)
            }
        }else{
            Write-Verbose "Webfarm configured: LoadBalancing from [$($resource.Algorithm)] to [$Algorithm]"

            $applicationRequestRoutingElement = $webFarm.applicationRequestRouting
            $loadBalancingElement = $webFarm.applicationRequestRouting.loadBalancing

            if($webFarm.applicationRequestRouting -eq $null){
                $applicationRequestRoutingElement = $config.CreateElement("applicationRequestRouting")
                $webFarm.AppendChild($applicationRequestRoutingElement)
            }

            if($webFarm.applicationRequestRouting.loadBalancing -eq $null){
                $loadBalancingElement = $config.CreateElement("loadBalancing")
                $loadBalancingElement.SetAttribute("algorithm", $_xWebfarm_DefaultLoadBalancingAlgorithm)
                $applicationRequestRoutingElement.AppendChild($loadBalancingElement)
            }

            if($Algorithm -eq "weightedroundrobin"){
                $loadBalancingElement.SetAttribute("algorithm", "WeightedRoundRobin")
                $loadBalancingElement.RemoveAttribute("hashServerVariable")
                $loadBalancingElement.RemoveAttribute("queryStringNames")
            }
            elseif($Algorithm -eq "querystring"){
                $loadBalancingElement.SetAttribute("algorithm", "RequestHash")
                $loadBalancingElement.SetAttribute("hashServerVariable", "query_string")
                $loadBalancingElement.SetAttribute("queryStringNames", [System.String]::Join(",", $QueryString))
            }
            elseif($Algorithm -eq "servervariable"){
                $loadBalancingElement.SetAttribute("algorithm", "RequestHash")
                $loadBalancingElement.SetAttribute("hashServerVariable", $ServerVariable)
                $loadBalancingElement.RemoveAttribute("queryStringNames")
            }
            elseif($Algorithm -eq "requesthash"){
                $loadBalancingElement.SetAttribute("algorithm", "RequestHash")
                $loadBalancingElement.RemoveAttribute("hashServerVariable")
                $loadBalancingElement.RemoveAttribute("queryStringNames")
            }
        }
    }

    if($config -ne $null){
        Write-Verbose "Finished configuration. Saving the config."
        SetApplicationHostConfig $ConfigPath $config
    }
}

# The Test-TargetResource cmdlet is used to validate if the role or feature is in a state as expected in the instance document.
function Test-TargetResource 
{
    [OutputType([System.Boolean])]
    param 
    (     
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]  
        [ValidateSet("Present", "Absent")]
        [string]$Ensure = "Present",

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,       
                
        [bool]$Enabled = $true,

        [string]$Algorithm,
        [string]$QueryString,
        [string]$ServerVariable,

        [string]$ConfigPath
    )

    Write-Verbose "xWebfarm/Test-TargetResource"
    Write-Verbose "Name: $Name"
    Write-Verbose "ConfigPath: $ConfigPath"

    if([System.String]::IsNullOrEmpty($Algorithm)){
        $Algorithm = $_xWebfarm_DefaultLoadBalancingAlgorithm
    }
    
    $config = GetApplicationHostConfig $ConfigPath
    $webFarm = GetWebfarm $Name $config
    $resource = GetTargetResourceFromConfigElement $webFarm
    
    Write-Verbose "Testing Ensures: Requested [$Ensure] Resource [$($resource.Ensure)]"
    if($resource.Ensure -eq "absent"){
        if($Ensure -eq "absent"){            
            return $true
        }else{
            return $false
        }

    }elseif($resource.Ensure -eq "present"){
        if($Ensure -eq "absent"){
            return $false
        }

        Write-Verbose "Testing Enabled: Requested [$Enabled] Resource [$($resource.Enabled)]"

        if($resource.Enabled -ne $Enabled){
            return $false
        }

        if($Algorithm -ne $resource.Algorithm){
            return $false
        }

        if($Algorithm -eq "querystring"){
            if([System.String]::IsNullOrEmpty($QueryString) -eq $false){
                $queryStringList1 = [System.String]::Join(",", ($QueryString.Split(",") | sort))
                $queryStringList2 = [System.String]::Join(",", ($resource.QueryString | sort))
            
                return $queryStringList1 -eq $queryStringList2
            }
        }elseif($Algorithm -eq "servervariable"){
            if([System.String]::IsNullOrEmpty($ServerVariable) -eq $false){
                $serverVariableList1 = [System.String]::Join(",", ($ServerVariable.Split(",") | sort))
                $serverVariableList2 = [System.String]::Join(",", ($resource.ServerVariable | sort))
            
                return $serverVariableList1 -eq $serverVariableList2
            }
        }
    }    

    $true
}

function GetWebfarm{
    param 
    (       
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [xml]$Config
    )

    $found = $false        
    $farms = $Config.configuration.webFarms.webFarm | ? name -eq $Name
    $measure = $farms | measure-object
    
    if($measure.Count -gt 1){
        Write-Error "More than one webfarm found! The config must be corrupted"
    }elseif($measure.Count -eq 0){
        $null
    }else{
        $farms
    }
}

function GetTargetResourceFromConfigElement($webFarm){
    $resource = @{
        Ensure = "Absent"
    }

    if($webFarm -ne $null){
        $resource.Ensure = "Present"

        if([System.String]::IsNullOrEmpty($webFarm.enabled)){
            $resource.Enabled = $false
        }else{
            $resource.Enabled = [System.Boolean]::Parse($webFarm.enabled)
        }

        #dows this farm have the specific request routing element
        if($webFarm.applicationRequestRouting -ne $null){
            $resource.Algorithm = $webFarm.applicationRequestRouting.loadBalancing.algorithm
            
            if([System.String]::IsNullOrEmpty($resource.Algorithm)){
                $resource.Algorithm = $_xWebfarm_DefaultLoadBalancingAlgorithm
            }

            if($webFarm.applicationRequestRouting.loadBalancing -ne $null){
                if($webFarm.applicationRequestRouting.loadBalancing.hashServerVariable -ne $null){
                    if($webFarm.applicationRequestRouting.loadBalancing.hashServerVariable -eq "query_string"){
                        $resource.Algorithm = "QueryString"
                        $resource.QueryString = $webFarm.applicationRequestRouting.loadBalancing.queryStringNames.Split(",")                
                    }else{
                        $resource.Algorithm = "ServerVariable"
                        $resource.ServerVariable = $webFarm.applicationRequestRouting.loadBalancing.hashServerVariable.Split(",")
                    }
                }
            }
        }else{
            $resource.Algorithm = $_xWebfarm_DefaultLoadBalancingAlgorithm            
        }
    }

    $resource 
}

function GetApplicationHostConfig($ConfigPath){
    
    if([System.String]::IsNullOrEmpty($ConfigPath)){
        $ConfigPath = [System.Environment]::ExpandEnvironmentVariables($_xWebfarm_DefaultApplicationHostConfig)
    }

    Write-Verbose "GetApplicationHostConfig $ConfigPath"

    [xml](gc $ConfigPath)
}

function SetApplicationHostConfig{
    param([string]$ConfigPath, [xml]$xml)

    if([System.String]::IsNullOrEmpty($ConfigPath)){
        $ConfigPath = [System.Environment]::ExpandEnvironmentVariables($_xWebfarm_DefaultApplicationHostConfig)
    }

    Write-Verbose "SetApplicationHostConfig $ConfigPath"

    $xml.Save($ConfigPath)
}

#endregion