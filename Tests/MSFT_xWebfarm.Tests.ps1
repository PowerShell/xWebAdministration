﻿$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) "..\DSCResources\MSFT_xWebfarm\MSFT_xWebfarm.psm1"
Import-Module "$sut" -Force

$global:fakeapphost1 = ""

function ResetAppHost
{
    $global:fakeapphost1 = [xml]'<?xml version="1.0" encoding="UTF-8"?>
    <configuration>
        <webFarms>
            <webFarm name="SOMEENABLEDFARM" enabled="true">           
            </webFarm>
            <webFarm name="SOMEDISABLEDFARM" enabled="false">            
            </webFarm>
            <webFarm name="SOMEFARMWITHOUTBALANCING" enabled="false">  
                <server address="fqdn1" enabled="true">                
                </server>
                <server address="fqdn2" enabled="true">                
                </server>          
            </webFarm>
            <webFarm name="SOMEFARMWITHWeightedRoundRobin" enabled="false"> 
                <server address="fqdn1" enabled="true">                
                </server>
                <server address="fqdn2" enabled="true">                
                </server>
                <server address="fqdn3" enabled="true">
                    <applicationRequestRouting weight="150" />
                </server>     
                <applicationRequestRouting>
                    <loadBalancing algorithm="WeightedRoundRobin" />
                </applicationRequestRouting>      
            </webFarm>
            <webFarm name="SOMEFARMWITHRequestHash" enabled="false"> 
                 <applicationRequestRouting>
                    <loadBalancing algorithm="RequestHash"/>
                </applicationRequestRouting> 
            </webFarm>
            <webFarm name="SOMEFARMWITHRequestHashQueryString" enabled="false">   
                <server address="fqdn1" enabled="true">                
                </server>
                <server address="fqdn2" enabled="true">
                    <!-- Must be ignored because it is not in roud robin -->
                    <applicationRequestRouting weight="150" />            
                </server>           
                 <applicationRequestRouting>
                    <loadBalancing algorithm="RequestHash" hashServerVariable="QUERY_STRING" queryStringNames="q1,q2" />
                </applicationRequestRouting>
            </webFarm>
            <webFarm name="SOMEFARMWITHRequestHashServerVariable" enabled="false">   
                <server address="fqdn1" enabled="true">                
                </server>
                <server address="fqdn2" enabled="true">
                    <!-- Must be ignored because it is not in roud robin -->
                    <applicationRequestRouting weight="150" />               
                </server>          
                 <applicationRequestRouting>
                    <loadBalancing algorithm="RequestHash" hashServerVariable="x1,x2" />
                </applicationRequestRouting> 
            </webFarm>        
        </webFarms>
    </configuration>'
}

Describe "MSFT_xWebfarm.Get-TargetResource" {
    #Ensure
    It "must return absent if the webfarm does not exists" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMTHATDOESNOTEXISTS"

        $webFarm.Ensure | Should Be "Absent"
    }
    It "must return present if webfarm exists" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm
        $webFarm = Get-TargetResource -Name "SOMEENABLEDFARM"
        $webFarm.Ensure | Should Be "Present"
    }        

    #Enabled
    It "must return Enabled null if webfarm does not exists" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMTHATDOESNOTEXISTS"

        $webFarm.Enabled | Should Be $null
    }
    It "must return Enabled True if webfarm is enabled" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEENABLEDFARM"

        $webFarm.Enabled | Should Be $true
    }
    It "must return Enabled False if webfarm is disabled" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEDISABLEDFARM"

        $webFarm.Enabled | Should Be $false
    }

    #Algorithm
    It "must return Algorithm null if webfarm does not exists" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMTHATDOESNOTEXISTS"

        $webFarm.Algorithm | Should Be $null
    }

    It "must return Algorithm WeightedRoundRobin if no algorithm is specified" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHOUTBALANCING"

        $webFarm.Algorithm | Should Be "WeightedRoundRobin"        
    } 
    It "must return QueryString null if no algorithm is specified" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHOUTBALANCING"

        $webFarm.QueryString | Should Be $null
    }
    It "must return ServerVariable null if no algorithm is specified" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHOUTBALANCING"

        $webFarm.ServerVariable | Should Be $null
    }

    #Algorithm.WeightedRoundRobin
    It "must return Algorithm WeightedRoundRobin if the specified algorithm is [WeightedRoundRobin]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin"

        $webFarm.Algorithm | Should Be "WeightedRoundRobin"        
    }   
    It "must return QueryString null if the specified algorithm is [WeightedRoundRobin]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin"

        $webFarm.QueryString | Should Be $null
    }  
    It "must return ServerVariable null if the specified algorithm is [WeightedRoundRobin]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin"

        $webFarm.ServerVariable | Should Be $null
    }

    #Algorithm.RequestHash
    It "must return Algorithm RequestHash if the specified algorithm is [RequestHash]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHRequestHash"

        $webFarm.Algorithm | Should Be "RequestHash"        
    }
    It "must return QueryString null if the specified algorithm is [RequestHash]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHRequestHash"

        $webFarm.QueryString | Should Be $null
    }
    It "must return ServerVariable null if the specified algorithm is [RequestHash]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHRequestHash"

        $webFarm.ServerVariable | Should Be $null
    }

    #Algorithm.QueryString
    It "must return Algorithm QueryString if the specified algorithm is [QueryString]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHRequestHashQueryString"

        $webFarm.Algorithm | Should Be "QueryString"        
    }
    It "must return QueryString q1 and q2 if the specified algorithm is [QueryString] with q1 and q2" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHRequestHashQueryString"

        $webFarm.QueryString.Length | Should Be 2
        $webFarm.QueryString[0] | Should Be "q1"
        $webFarm.QueryString[1] | Should Be "q2"
    }
    It "must return ServerVariable null if the specified algorithm is [QueryString]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHRequestHashQueryString"

        $webFarm.ServerVariable | Should Be $null
    }
        
    #Algorithm.ServerVariable
    It "must return Algorithm ServerVariable if the specified algorithm is [ServerVariable]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHRequestHashServerVariable"

        $webFarm.Algorithm | Should Be "ServerVariable"        
    }
    It "must return ServerVariable x1 and x2 if the specified algorithm is [ServerVariable] with x1 and x2" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHRequestHashServerVariable"

        $webFarm.ServerVariable.Length | Should Be 2
        $webFarm.ServerVariable[0] | Should Be "x1"
        $webFarm.ServerVariable[1] | Should Be "x2"
    }
    It "must return QueryString null if the specified algorithm is [ServerVariable]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $webFarm = Get-TargetResource -Name "SOMEFARMWITHRequestHashServerVariable"

        $webFarm.QueryString | Should Be $null
    }
}

Describe "MSFT_xWebfarm.Test-TargetResource"{
    #Ensure
    It "is true  when Request[Ensure=Absent ] and Resource[Ensure=Absent ]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMTHATDOESNOTEXISTS" -Ensure Absent

        $result | Should Be $true
    }
    It "is true  when Request[Ensure=Present] and Resource[Ensure=Present]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEENABLEDFARM" -Ensure Present

        $result | Should Be $true
    }
    It "is false when Request[Ensure=Absent ] and Resource[Ensure=Present]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEENABLEDFARM" -Ensure Absent

        $result | Should Be $false
    }
    It "is false when Request[Ensure=Present] and Resource[Ensure=Absent ]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMTHATDOESNOTEXISTS" -Ensure Present

        $result | Should Be $false
    }   
    
    #Enabled
    It "is true  when Request[Enabled=false] and Resource[Enabled=false]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEDISABLEDFARM" -Ensure Present -Enabled $false

        $result | Should Be $true
    }
    It "is true  when Request[Enabled=true ] and Resource[Enabled=true ]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEENABLEDFARM" -Ensure Present -Enabled $true

        $result | Should Be $true
    }
    It "is false when Request[Enabled=true ] and Resource[Enabled=false]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEDISABLEDFARM" -Ensure Present -Enabled $true

        $result | Should Be $false
    }
    It "is false when Request[Enabled=false] and Resource[Enabled=true ]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEENABLEDFARM" -Ensure Present -Enabled $false

        $result | Should Be $false
    }

    #Algorithm
    It "is true when Request[Algorithm=null] and Resource[Algorithm=null]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHOUTBALANCING" -Ensure Present -Enabled $false

        $result | Should Be $true
    }
    It "is true when Request[Algorithm=null] and Resource[Algorithm=WeightedRoundRobin]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin" -Ensure Present -Enabled $false

        $result | Should Be $true
    }
    It "is false when Request[Algorithm=null] and Resource[Algorithm=QueryString]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashQueryString" -Ensure Present -Enabled $false

        $result | Should Be $false
    }
    It "is false when Request[Algorithm=null] and Resource[Algorithm=RequestHash]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHash" -Ensure Present -Enabled $false

        $result | Should Be $false
    }
    It "is false when Request[Algorithm=null] and Resource[Algorithm=ServerVariable]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashServerVariable" -Ensure Present -Enabled $false

        $result | Should Be $false
    }

    #Algorithm.WeightedRoundRobin
    It "is true when Request[Algorithm=WeightedRoundRobin] and Resource[Algorithm=null]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHOUTBALANCING" -Ensure Present -Enabled $false -Algorithm WeightedRoundRobin

        $result | Should Be $true
    }
    It "is true when Request[Algorithm=WeightedRoundRobin] and Resource[Algorithm=WeightedRoundRobin]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin" -Ensure Present -Enabled $false -Algorithm WeightedRoundRobin

        $result | Should Be $true
    }
    It "is false when Request[Algorithm=WeightedRoundRobin] and Resource[Algorithm=QueryString]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashQueryString" -Ensure Present -Enabled $false -Algorithm WeightedRoundRobin

        $result | Should Be $false
    }
    It "is false when Request[Algorithm=WeightedRoundRobin] and Resource[Algorithm=RequestHash]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHash" -Ensure Present -Enabled $false -Algorithm WeightedRoundRobin

        $result | Should Be $false
    }
    It "is false when Request[Algorithm=WeightedRoundRobin] and Resource[Algorithm=ServerVariable]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashServerVariable" -Ensure Present -Enabled $false -Algorithm WeightedRoundRobin

        $result | Should Be $false
    }

    #Algorithm.QueryString
    It "is false when Request[Algorithm=QueryString] and Resource[Algorithm=null]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHOUTBALANCING" -Ensure Present -Enabled $false -Algorithm QueryString

        $result | Should Be $false
    }
    It "is false when Request[Algorithm=QueryString] and Resource[Algorithm=WeightedRoundRobin]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin" -Ensure Present -Enabled $false -Algorithm QueryString

        $result | Should Be $false
    }
    It "is true  when Request[Algorithm=QueryString,QueryString=null] and Resource[Algorithm=QueryString,QueryString=q1,q2]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashQueryString" -Ensure Present -Enabled $false -Algorithm QueryString

        $result | Should Be $true
    }
    It "is true  when Request[Algorithm=QueryString,QueryString=q1,q2] and Resource[Algorithm=QueryString,QueryString=q1,q2]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashQueryString" -Ensure Present -Enabled $false -Algorithm QueryString -QueryString "q1,q2"

        $result | Should Be $true
    }
    It "is false  when Request[Algorithm=QueryString,QueryString=x1] and Resource[Algorithm=QueryString,QueryString=q1,q2]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashQueryString" -Ensure Present -Enabled $false -Algorithm QueryString -QueryString "x1"

        $result | Should Be $false
    }
    It "is false when Request[Algorithm=QueryString] and Resource[Algorithm=RequestHash]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHash" -Ensure Present -Enabled $false -Algorithm QueryString

        $result | Should Be $false
    }
    It "is false when Request[Algorithm=QueryString] and Resource[Algorithm=ServerVariable]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashServerVariable" -Ensure Present -Enabled $false -Algorithm QueryString

        $result | Should Be $false
    }

    #Algorithm.RequestHash
    It "is false when Request[Algorithm=RequestHash] and Resource[Algorithm=null]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHOUTBALANCING" -Ensure Present -Enabled $false -Algorithm RequestHash

        $result | Should Be $false
    }
    It "is false when Request[Algorithm=RequestHash] and Resource[Algorithm=WeightedRoundRobin]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin" -Ensure Present -Enabled $false -Algorithm RequestHash

        $result | Should Be $false
    }
    It "is false  when Request[Algorithm=RequestHash] and Resource[Algorithm=QueryString]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashQueryString" -Ensure Present -Enabled $false -Algorithm RequestHash

        $result | Should Be $false
    }
    It "is true when Request[Algorithm=RequestHash] and Resource[Algorithm=RequestHash]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHash" -Ensure Present -Enabled $false -Algorithm RequestHash

        $result | Should Be $true
    }
    It "is false when Request[Algorithm=RequestHash] and Resource[Algorithm=ServerVariable]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashServerVariable" -Ensure Present -Enabled $false -Algorithm RequestHash

        $result | Should Be $false
    }

    #Algorithm.ServerVariable
    It "is false when Request[Algorithm=ServerVariable] and Resource[Algorithm=null]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHOUTBALANCING" -Ensure Present -Enabled $false -Algorithm ServerVariable

        $result | Should Be $false
    }
    It "is false when Request[Algorithm=ServerVariable] and Resource[Algorithm=WeightedRoundRobin]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin" -Ensure Present -Enabled $false -Algorithm ServerVariable

        $result | Should Be $false
    }
    It "is false when Request[Algorithm=ServerVariable] and Resource[Algorithm=QueryString]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashQueryString" -Ensure Present -Enabled $false -Algorithm ServerVariable

        $result | Should Be $false
    }
    It "is false when Request[Algorithm=ServerVariable] and Resource[Algorithm=RequestHash]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHash" -Ensure Present -Enabled $false -Algorithm ServerVariable

        $result | Should Be $false
    }
    It "is true  when Request[Algorithm=ServerVariable,ServerVariable=null] and Resource[Algorithm=ServerVariable,ServerVariable=x1,x2]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashServerVariable" -Ensure Present -Enabled $false -Algorithm ServerVariable

        $result | Should Be $true
    }
    It "is true  when Request[Algorithm=ServerVariable,ServerVariable=x1,x2] and Resource[Algorithm=ServerVariable,ServerVariable=x1,x2]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashServerVariable" -Ensure Present -Enabled $false -Algorithm ServerVariable -ServerVariable "x1,x2"

        $result | Should Be $true
    }
    It "is false  when Request[Algorithm=ServerVariable,ServerVariable=a] and Resource[Algorithm=ServerVariable,ServerVariable=x1,x2]" {
        ResetAppHost
        Mock GetApplicationHostConfig { return $fakeapphost1 } -ModuleName MSFT_xWebfarm

        $result = Test-TargetResource -Name "SOMEFARMWITHRequestHashServerVariable" -Ensure Present -Enabled $false -Algorithm ServerVariable -ServerVariable a

        $result | Should Be $false
    }
}

Describe "MSFT_xWebfarm.Set-TargetResource"{
    It "must do nothing if Request[Ensure=Absent] and Resource[Ensure=Absent]" {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARMTHATDOESNOTEXISTS" -Ensure Absent

        $result = Get-TargetResource -Name "SOMEFARMTHATDOESNOTEXISTS"
        $result.Ensure | Should Be "Absent"        
    }
    It "must Create the webfarm if Request[Ensure=Present] and Resource[Ensure=Absent]" {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARM1" -Ensure Present

        $result = Get-TargetResource -Name "SOMEFARM1"
        $result.Ensure | Should Be "Present"        
    }    
    It "must delete the webfarm if Request[Ensure=Absent] and Resource[Ensure=Present]" {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARMTHATEXISTS" -Ensure Absent

        $result = Get-TargetResource -Name "SOMEFARMTHATEXISTS"
        $result.Ensure | Should Be "Absent"        
    }

    It "must Enable the webfarm if Request[Ensure=Present,Enabled=null] and Resource[Ensure=Absent]" {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARM1" -Ensure Present

        $result = Get-TargetResource -Name "SOMEFARM1"        
        $result.Enabled | Should Be $true
    }
    It "must Enable the webfarm if Request[Ensure=Present,Enabled=true] and Resource[Ensure=Absent]" {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARM1" -Ensure Present -Enabled $true

        $result = Get-TargetResource -Name "SOMEFARM1"        
        $result.Enabled | Should Be $true
    }
    It "must Disable the webfarm if Request[Ensure=Present,Enabled=false] and Resource[Ensure=Absent]" {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARM1" -Ensure Present -Enabled $false

        $result = Get-TargetResource -Name "SOMEFARM1"        
        $result.Enabled | Should Be $false
    }

    It "must configure webfarm if Request[Ensure=Present,Enabled=true] and Resource[Ensure=Present,Enabled=true]" {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARMTHATEXISTS" -Ensure Present -Enabled $true

        $result = Get-TargetResource -Name "SOMEFARMTHATEXISTS"
        $result.Ensure | Should Be "Present"
        $result.Enabled | Should Be $true
    }
    It "must configure webfarm if Request[Ensure=Present,Enabled=false] and Resource[Ensure=Present,Enabled=true]" {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARMTHATEXISTS" -Ensure Present -Enabled $false

        $result = Get-TargetResource -Name "SOMEFARMTHATEXISTS"
        $result.Ensure | Should Be "Present"
        $result.Enabled | Should Be $false
    }
    It "must configure webfarm if Request[Ensure=Present,Enabled=true] and Resource[Ensure=Present,Enabled=false]" {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEDISABLEDFARM" -Ensure Present -Enabled $true

        $result = Get-TargetResource -Name "SOMEDISABLEDFARM"
        $result.Ensure | Should Be "Present"
        $result.Enabled | Should Be $true
    }
    It "must configure webfarm if Request[Ensure=Present,Enabled=false] and Resource[Ensure=Present,Enabled=false]" {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEDISABLEDFARM" -Ensure Present -Enabled $false

        $result = Get-TargetResource -Name "SOMEDISABLEDFARM"
        $result.Ensure | Should Be "Present"
        $result.Enabled | Should Be $false
    }

    It "must configure webfarm Requested=[Ensure=Present,Algorithm=WeightedRoundRobin] Resource[Ensure=Present,Algofithm=<default>] " {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARMTHATEXISTS" -Ensure Present -Enabled $true -Algorithm "WeightedRoundRobin"

        $result = Get-TargetResource -Name "SOMEFARMTHATEXISTS"
        $result.Ensure | Should Be "Present"
        $result.Enabled | Should Be $true
        $result.Algorithm | Should Be "WeightedRoundRobin"
        $result.QueryString | Should Be $null
        $result.ServerVariable | Should Be $null
    }
    It "must configure webfarm Requested=[Ensure=Present,Algorithm=WeightedRoundRobin] Resource[Ensure=Present,Algorithm=WeightedRoundRobin] " {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin" -Ensure Present -Enabled $true -Algorithm "WeightedRoundRobin"

        $result = Get-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin"
        $result.Ensure | Should Be "Present"
        $result.Enabled | Should Be $true
        $result.Algorithm | Should Be "WeightedRoundRobin"
        $result.QueryString | Should Be $null
        $result.ServerVariable | Should Be $null
    }    
   
    It "must configure webfarm Requested=[Ensure=Present,Algorithm=QueryString] Resource[Ensure=Present,Algorithm=WeightedRoundRobin] " {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin" -Ensure Present -Enabled $true -Algorithm "QueryString" -QueryString "q1,q2"

        $result = Get-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin"
        $result.Ensure | Should Be "Present"
        $result.Enabled | Should Be $true
        $result.Algorithm | Should Be "QueryString"
        $result.QueryString | Should Not BeNullOrEmpty
        $result.QueryString.Length | Should Be 2
        $result.QueryString[0] | Should Be "q1"
        $result.QueryString[1] | Should Be "q2"
        $result.ServerVariable | Should Be $null
    }
    It "must configure webfarm Requested=[Ensure=Present,Algorithm=QueryString,QueryString=x1,x2] Resource[Ensure=Present,Algorithm=QueryString,QueryString=q1,q2] " {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARMWITHRequestHashQueryString" -Ensure Present -Enabled $true -Algorithm "QueryString" -QueryString "x1,x2"

        $result = Get-TargetResource -Name "SOMEFARMWITHRequestHashQueryString"
        $result.Ensure | Should Be "Present"
        $result.Enabled | Should Be $true
        $result.Algorithm | Should Be "QueryString"
        $result.QueryString | Should Not BeNullOrEmpty
        $result.QueryString.Length | Should Be 2
        $result.QueryString[0] | Should Be "x1"
        $result.QueryString[1] | Should Be "x2"
        $result.ServerVariable | Should Be $null
    }

    It "must configure webfarm Requested=[LoadBalancing.Algorithm=ServerVariable] Resource[Ensure=Present,Algorithm=WeightedRoundRobin] " {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin" -Ensure Present -Enabled $true -Algorithm "ServerVariable" -ServerVariable "x"

        $result = Get-TargetResource -Name "SOMEFARMWITHWeightedRoundRobin"
        $result.Ensure | Should Be "Present"
        $result.Enabled | Should Be $true
        $result.Algorithm | Should Be "ServerVariable"
        $result.ServerVariable | Should Be "x"
        $result.QueryString | Should BeNullOrEmpty    
    }  
    It "must configure webfarm Requested=[LoadBalancing.Algorithm=ServerVariable,ServerVariable=a] Resource[Ensure=Present,Algorithm=ServerVariable,ServerVariable=x] " {
        ResetAppHost
        Mock GetApplicationHostConfig {return $fakeapphost1} -ModuleName MSFT_xWebfarm
        Mock SetApplicationHostConfig {param([string]$path,[xml]$xml)} -ModuleName MSFT_xWebfarm
        
        Set-TargetResource -Name "SOMEFARMWITHRequestHashServerVariable" -Ensure Present -Enabled $true -Algorithm "ServerVariable" -ServerVariable "a"

        $result = Get-TargetResource -Name "SOMEFARMWITHRequestHashServerVariable"
        $result.Ensure | Should Be "Present"
        $result.Enabled | Should Be $true
        $result.Algorithm | Should Be "ServerVariable"
        $result.ServerVariable | Should Be "a"
        $result.QueryString | Should BeNullOrEmpty    
    }        
}