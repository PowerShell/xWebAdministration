﻿# Load the Helper Module
Import-Module -Name "$PSScriptRoot\..\Helper.psm1"

# Localized messages
data LocalizedData
{
    # culture="en-US"
    ConvertFrom-StringData -StringData @'
        ErrorftpSiteDiscoveryFailure                    = Failure to get the requested ftpSite "{0}" information from the target machine.
        ErrorftpSiteCreationFailure                     = Failure to successfully create the ftpSite "{0}". Error: "{1}".
        ErrorftpSiteRemovalFailure                      = Failure to successfully remove the ftpSite "{0}". Error: "{1}".
        ErrorftpSiteStateFailure                        = Failure to successfully set the state of the website "{0}". Error: "{1}".
        ErrorServerCertHashFailure                      = No such cert with the hash of "{0}" exists under store "{1}".
        VerboseGetTargetAbsent                          = No ftpSite exists with this name.
        VerboseGetTargetPresent                         = A single ftpSite exists with this name.
        VerboseSetTargetftpSiteCreated                  = Successfully created ftpSite "{0}".
        VerboseSetTargetftpSiteRemoved                  = Successfully removed ftpSite "{0}".
        VerboseSetTargetAuthenticationInfoUpdated       = Successfully updated AuthenticationInfo on ftpSite "{0}".
        VerboseSetTargetAuthorizationInfoUpdated        = Successfully updated AuthorizationInfo on ftpSite "{0}".
        VerboseSetTargetUpdateAllowLocalDetailedErrors  = Successfully updated AllowLocalDetailedErrors on ftpSite "{0}".
        VerboseSetTargetUpdateBannerMessage             = Successfully updated Banner message on ftpSite "{0}".
        VerboseSetTargetUpdatedApplicationPool          = Successfully updated ApplicationPool on ftpSite "{0}".
        VerboseSetTargetUpdatedBindingInfo              = Successfully updated BindingInfo on ftpSite "{0}".
        VerboseSetTargetUpdateDirectoryBrowseFlags      = Successfully updated DirectoryBrowseFlags on ftpSite "{0}".
        VerboseSetTargetUpdateEndingDataChannelPort     = Successfully updated ending data channel port on ftpSite "{0}".
        VerboseSetTargetUpdateExitMessage               = Successfully updated Exit message on ftpSite "{0}".
        VerboseSetTargetUpdateExpandVariablesInMessages = Successfully updated ExpandVariablesInMessages on ftpSite "{0}".
        VerboseSetTargetUpdateExternalIPaddress         = Successfully updated external firewall IP address on ftpSite "{0}".
        VerboseSetTargetUpdateGreetingMessage           = Successfully updated Greeting message on ftpSite "{0}".
        VerboseSetTargetUpdateLogFlags                  = Successfully updated LogFlags on ftpSite "{0}".
        VerboseSetTargetUpdateLoglocalTimeRollover      = Successfully updated LoglocalTimeRollover on ftpSite "{0}".
        VerboseSetTargetUpdateLogPath                   = Successfully updated LogPath on ftpSite "{0}".
        VerboseSetTargetUpdateLogPeriod                 = Successfully updated LogPeriod on ftpSite "{0}".
        VerboseSetTargetUpdateLogTruncateSize           = Successfully updated TruncateSize on ftpSite "{0}".
        VerboseSetTargetUpdateMaxClientsMessage         = Successfully updated MaxClients message on ftpSite "{0}".
        VerboseSetTargetUpdatedPhysicalPath             = Successfully updated PhysicalPath on ftpSite "{0}".
        VerboseSetTargetUpdatePhysicalPathCredential    = Successfully updated PhysicalPathCredential on ftpSite "{0}".
        VerboseSetTargetUpdatedState                    = Successfully updated State on ftpSite "{0}".
        VerboseSetTargetUpdateSslInfo                   = Successfully updated SslInfo on ftpSite "{0}".
        VerboseSetTargetUpdateStartingDataChannelPort   = Successfully updated starting data channel port on ftpSite "{0}".
        VerboseSetTargetUpdateSuppressDefaultBanner     = Successfully updated SuppressDefaultBanner on ftpSite "{0}".
        VerboseSetTargetUpdateUserIsolation             = Successfully updated UserIsolation on ftpSite "{0}".
        VerboseTestTargetFalseAllowLocalDetailedErrors  = AllowLocalDetailedErrors for ftpSite "{0}" does not match the desired state.
        VerboseTestTargetFalseApplicationPool           = Application Pool for ftpSite "{0}" does not match the desired state.
        VerboseTestTargetFalseAuthenticationInfo        = AuthenticationInfo for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseAuthorizationInfo         = AuthorizationInfo for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseBannerMessage             = BannerMessage for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseBindingInfo               = BindingInfo for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseDirectoryBrowseFlags      = DirectoryBrowseFlags for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseEndingDataChannelPort     = Ending data channel port for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseEnsure                    = The Ensure state for ftpSite "{0}" does not match the desired state.
        VerboseTestTargetFalseExitMessage               = ExitMessage for ftpSite "{0}" does not match the desired state.
        VerboseTestTargetFalseExpandVariablesInMessages = ExpandVariablesInMessages for ftpSite "{0}" does not match the desired state.
        VerboseTestTargetFalseExternalIPaddress         = The external firewall IP address for ftpSite "{0}" does not match the desired state.
        VerboseTestTargetFalseGreetingMessage           = GreetingMessage for ftpSite "{0}" does not match the desired state.
        VerboseTestTargetFalseLogFlags                  = LogFlags for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseLoglocalTimeRollover      = LoglocalTimeRollover for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseLogPath                   = LogPath for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseLogPeriod                 = LogPeriod for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseLogTruncateSize           = LogTruncateSize for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseMaxClientsMessage         = MaxClientsMessage for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseSslInfo                   = SslInfo for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseStartingDataChannelPort   = Starting data channel port for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalseState                     = The state of ftpSite "{0}" does not match the desired state.
        VerboseTestTargetFalseSuppressDefaultBanner     = SuppressDefaultBanner for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetFalsePhysicalPath              = Physical Path of ftpSite "{0}" does not match the desired state.
        VerboseTestTargetFalsePhysicalPathCredential    = PhysicalPathCredential of ftpSite "{0}" does not match the desired state.
        VerboseTestTargetFalseUserIsolation             = UserIsolation for ftpSite "{0}" is not in the desired state.
        VerboseTestTargetTrueResult                     = The target resource is already in the desired state. No action is required.
        VerboseTestTargetFalseResult                    = The target resource is not in the desired state.
        VerboseStartWebsite                             = Successfully started ftpSite "{0}".
        VerboseStopWebsite                              = Successfully stopped ftpSite "{0}".
        WarningLogPeriod                                = LogTruncateSize is specified as an input so LogPeriod input will be ignored and set to "MaxSize" on Website "{0}".
'@
}

<#
    .SYNOPSIS
        The Get-TargetResource cmdlet is used to fetch the status of the FTP Site on the
        target machine. It gives the ftpSite info of the requested role/feature on the
        target machine.

    .PARAMETER Name
        Specifies the name of the FTP Site.
#>
function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $Name
    )

    Assert-Module

    $ftpSite = Get-Website | Where-Object -FilterScript {$_.Name -eq $Name}
    $defaultFirewallSupport = Get-WebConfiguration -Filter '/system.ftpServer/firewallSupport'
    $physicalPathCredential = [System.Management.Automation.PSCredential]::Empty

    if ($ftpSite.Count -eq 0)
    {
        Write-Verbose -Message ($LocalizedData.VerboseGetTargetAbsent)
        $ensureResult = 'Absent'
    }
    elseif ($ftpSite.Count -eq 1)
    {
        $authenticationInfo = Get-AuthenticationInfo -Site $Name -IisType 'Ftp'
        $authorizationInfo = Get-AuthorizationInfo -Site $Name
        $sslInfo = Get-SslInfo -Site $Name
        $bindings = @(ConvertTo-CimBinding -InputObject $ftpSite.bindings.Collection)
        $logFlags = [array]$ftpSite.ftpServer.logFile.LogExtFileFlags.Split(',')
        $showFlags = [array]$ftpSite.ftpServer.directoryBrowse.showFlags.Split(',')

        if ($ftpSite.password -ne '')
        {
            $physicalPathCredential = New-Object System.Management.Automation.PSCredential ($ftpSite.userName, `
                                        (ConvertTo-SecureString -String $ftpSite.password -AsPlainText -Force))
        }

        Write-Verbose -Message ($LocalizedData.VerboseGetTargetPresent)
        $ensureResult = 'Present'
    }
    else # Multiple ftpSites with the same name exist. This is not supported and is an error
    {
        $errorMessage = $LocalizedData.ErrorftpSiteDiscoveryFailure -f $Name
        New-TerminatingError -ErrorId 'ftpSiteDiscoveryFailure' `
                             -ErrorMessage $errorMessage `
                             -ErrorCategory 'InvalidResult'
    }

    # Add all ftpSite properties to the hash table
    return @{
        Ensure                    = $ensureResult
        Name                      = $Name
        PhysicalPath              = $ftpSite.PhysicalPath
        PhysicalPathCredential    = $physicalPathCredential
        State                     = $ftpSite.State
        ApplicationPool           = $ftpSite.ApplicationPool
        AuthenticationInfo        = $authenticationInfo
        AuthorizationInfo         = $authorizationInfo
        SslInfo                   = $sslInfo
        BindingInfo               = $bindings
        FirewallIPAddress         = $ftpServer.firewallSupport.externalIp4Address
        StartingDataChannelPort   = $defaultFirewallSupport.lowDataChannelPort
        EndingDataChannelPort     = $defaultFirewallSupport.highDataChannelPort
        GreetingMessage           = $ftpSite.ftpServer.messages.greetingMessage
        ExitMessage               = $ftpSite.ftpServer.messages.exitMessage
        BannerMessage             = $ftpSite.ftpServer.messages.bannerMessage
        MaxClientsMessage         = $ftpSite.ftpServer.messages.maxClientsMessage
        SuppressDefaultBanner     = $ftpSite.ftpServer.messages.suppressDefaultBanner
        AllowLocalDetailedErrors  = $ftpSite.ftpServer.messages.allowLocalDetailedErrors
        ExpandVariablesInMessages = $ftpSite.ftpServer.messages.expandVariables
        LogPath                   = $ftpSite.ftpServer.logFile.directory
        LogFlags                  = $logFlags
        LogPeriod                 = $ftpSite.ftpServer.logFile.period
        LogtruncateSize           = $ftpSite.ftpServer.logFile.truncateSize
        LoglocalTimeRollover      = $ftpSite.ftpServer.logFile.localTimeRollover
        DirectoryBrowseFlags      = $showFlags
        UserIsolation             = $ftpSite.ftpServer.userIsolation.mode
    }
}

<#
    .SYNOPSIS
        The Set-TargetResource cmdlet is used to create, delete or configure a ftpSite on the
        target machine.
#>
function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [ValidateSet('Present', 'Absent')]
        [String] $Ensure = 'Present',

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $Name,

        [ValidateNotNullOrEmpty()]
        [String] $PhysicalPath,

        [System.Management.Automation.CredentialAttribute()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $PhysicalPathCredential,

        [ValidateSet('Started', 'Stopped')]
        [String] $State = 'Started',

        # The application pool name must contain between 1 and 64 characters
        [ValidateLength(1, 64)]
        [String] $ApplicationPool,

        [Microsoft.Management.Infrastructure.CimInstance] $AuthenticationInfo,

        [Microsoft.Management.Infrastructure.CimInstance[]] $AuthorizationInfo,

        [Microsoft.Management.Infrastructure.CimInstance] $SslInfo,

        [Microsoft.Management.Infrastructure.CimInstance[]] $BindingInfo,

        [String] $FirewallIPAddress,

        [ValidateScript({$_ -eq 0 -or $_ -in 1025 .. 65535})]
        [uint16] $StartingDataChannelPort,

        [ValidateScript({$_ -eq 0 -or $_ -in 1025 .. 65535})]
        [uint16] $EndingDataChannelPort,

        [String] $GreetingMessage,

        [String] $ExitMessage,

        [String] $BannerMessage,

        [String] $MaxClientsMessage,

        [Boolean] $SuppressDefaultBanner,

        [Boolean] $AllowLocalDetailedErrors,

        [Boolean] $ExpandVariablesInMessages,

        [ValidateSet('Date','Time','ClientIP','UserName','ServerIP','Method','UriStem','UriQuery','HttpStatus','Win32Status','TimeTaken','ServerPort','UserAgent','Referer','HttpSubStatus')]
        [String[]] $LogFlags,

        [String] $LogPath,

        [ValidateSet('Hourly','Daily','Weekly','Monthly','MaxSize')]
        [String] $LogPeriod,

        [ValidateRange('1048576','4294967295')]
        [String] $LogTruncateSize,

        [Boolean] $LoglocalTimeRollover,

        [ValidateSet('StyleUnix','LongDate','DisplayAvailableBytes','DisplayVirtualDirectories')]
        [String[]] $DirectoryBrowseFlags,

        [ValidateSet('None','StartInUsersDirectory','IsolateAllDirectories','IsolateRootDirectoryOnly')]
        [String] $UserIsolation
    )

    Assert-Module

    $ftpSite = Get-Website | Where-Object -FilterScript {$_.Name -eq $Name}

    if ($Ensure -eq 'Present')
    {
        $iisType = 'Ftp'
        $defaultFirewallSupport = Get-WebConfiguration -Filter '/system.ftpServer/firewallSupport'

        if ($null -eq $AuthenticationInfo)
        {
            $AuthenticationInfo = Get-DefaultAuthenticationInfo -IisType $IisType
        }

        # Create ftpSite if it does not exist
        if ($null -eq $ftpSite)
        {
            if ([string]::IsNullOrEmpty($PhysicalPath))
            {
                throw 'The PhysicalPath Parameter must be provided for a ftpSite to be created!'
            }

            try
            {
                $PSBoundParameters.GetEnumerator() |
                Where-Object -FilterScript {
                    $_.Key -in (Get-Command -Name New-WebftpSite `
                                            -Module WebAdministration).Parameters.Keys
                } |
                ForEach-Object -Begin {
                    $NewftpSiteSplat = @{}
                } -Process {
                    $NewftpSiteSplat.Add($_.Key, $_.Value)
                }

                <#
                    If there are no other ftpSites, specify the Id Parameter for the new
                    ftpSite. Otherwise an error can occur on systems running
                    Windows Server 2008 R2.
                #>
                if (-not (Get-Website))
                {
                    $NewftpSiteSplat.Add('Id', 1)
                }

                # Set default port to FTP:21 else it will be HTTP:80
                if(-not(($PSBoundParameters.ContainsKey('BindingIfo'))))
                {
                    $NewftpSiteSplat.Add('Port', 21)
                }

                if ([bool]([System.Uri]$PhysicalPath).IsUnc)
                {
                    # If physical path is provided using Unc syntax run New-WebftpSite with -Force flag
                    $ftpSite = New-WebftpSite @NewftpSiteSplat -ErrorAction Stop -Force
                }
                else
                {
                    # If physical path is provided don't run New-WebftpSite with -Force flag to verify that the path exists
                    $ftpSite = New-WebftpSite @NewftpSiteSplat -ErrorAction Stop
                }

                Write-Verbose -Message ($LocalizedData.VerboseSetTargetftpSiteCreated `
                                        -f $Name)
            }
            catch
            {
                $errorMessage = $LocalizedData.ErrorftpSiteCreationFailure `
                                -f $Name, $_.Exception.Message
                New-TerminatingError -ErrorId 'ftpSiteCreationFailure' `
                                     -ErrorMessage $errorMessage `
                                     -ErrorCategory 'InvalidOperation'
            }
        }

        # Update Physical Path if required
        if ([string]::IsNullOrEmpty($PhysicalPath) -eq $false -and `
            $ftpSite.PhysicalPath -ne $PhysicalPath)
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name physicalPath `
                             -Value $PhysicalPath `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdatedPhysicalPath `
                                    -f $Name)
        }

        # Update physical path access credential if required
        if ($PSBoundParameters.ContainsKey('PhysicalPathCredential') -and `
            (-not (Test-AccessCredential -Site $Name -Credential $PhysicalPathCredential)))
        {
            Update-AccessCredential -Site $Name -Credential $PhysicalPathCredential
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdatePhysicalPathCredential `
                             -f $Name)
        }

        # Update Application Pool if required
        if ($PSBoundParameters.ContainsKey('ApplicationPool') -and `
            $ftpSite.ApplicationPool -ne $ApplicationPool)
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name applicationPool `
                             -Value $ApplicationPool `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdatedApplicationPool `
                                    -f $Name, $ApplicationPool)
        }

        <#
            Update Authentication if required;
            if not defined then pass in DefaultAuthenticationInfo
        #>
        if (-not (Test-AuthenticationInfo -Site $Name `
                                          -IisType $IisType `
                                          -AuthenticationInfo $AuthenticationInfo))
        {
            Set-AuthenticationInfo -Site $Name `
                                   -IisType $IisType `
                                   -AuthenticationInfo $AuthenticationInfo `
                                   -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetAuthenticationInfoUpdated `
                                    -f $Name)
        }

        # Update AuthorizationInfo if required
        if ($PSBoundParameters.ContainsKey('AuthorizationInfo') -and `
            (-not (Test-AuthorizationInfo -Site $Name `
                                          -AuthorizationInfo $AuthorizationInfo)))
        {
            Set-FTPAuthorization -AuthorizationInfo $AuthorizationInfo `
                                 -Site $Name `
                                 -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetAuthorizationInfoUpdated `
                                    -f $Name)
        }

        # Update Bindings if required
        if ($PSBoundParameters.ContainsKey('BindingInfo') -and `
            $null -ne $BindingInfo)
        {
            if (-not (Test-WebsiteBinding -Name $Name `
                                          -BindingInfo $BindingInfo))
            {
                Update-WebsiteBinding -Name $Name `
                                      -BindingInfo $BindingInfo `
                                      -ErrorAction Stop
                Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdatedBindingInfo `
                                        -f $Name)
            }
        }

        # Update SslInfo if required
        if ($PSBoundParameters.ContainsKey('SslInfo') -and `
            (-not (Confirm-UniqueSslInfo -Site $Name -SslInfo $SslInfo)))
        {
            Set-SslInfo -Site $Name -SslInfo $SslInfo -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateSslInfo `
                                    -f $name)
        }

        # Update external firewall IP address if required
        if ($PSBoundParameters.ContainsKey('FirewallIPAddress') -and `
            $FirewallIPAddress -ne $ftpSite.ftpServer.firewallSupport.externalIp4Address)
        {
            if ($FirewallIPAddress)
            {
                Test-IPAddress $FirewallIPAddress | Out-Null
            }
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpServer.firewallSupport.externalIp4Address `
                             -Value $FirewallIPAddress `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateExternalIPaddress -f $Name)
        }

        # Update starting data channel port number
        if ($PSBoundParameters.ContainsKey('StartingDataChannelPort') -and `
            $StartingDataChannelPort -ne $defaultFirewallSupport.lowDataChannelPort)
        {
            Set-WebConfigurationProperty `
                        -Filter '/system.ftpServer/firewallSupport' `
                        -Name lowDataChannelPort `
                        -Value $StartingDataChannelPort `
                        -Force `
                        -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateStartingDataChannelPort -f $Name)
        }

        # Update ending data channel port number
        if ($PSBoundParameters.ContainsKey('EndingDataChannelPort') -and `
            $EndingDataChannelPort -ne $defaultFirewallSupport.highDataChannelPort)
        {
            Set-WebConfigurationProperty `
                        -Filter '/system.ftpServer/firewallSupport' `
                        -Name highDataChannelPort `
                        -Value $EndingDataChannelPort `
                        -Force `
                        -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateEndingDataChannelPort -f $Name)
        }

        # Update greeting message
        if ($PSBoundParameters.ContainsKey('GreetingMessage') -and `
            $GreetingMessage -ne $ftpSite.ftpServer.messages.greetingMessage)
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpServer.messages.greetingMessage `
                             -Value $GreetingMessage `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateGreetingMessage -f $Name)
        }

        # Update exit message
        if ($PSBoundParameters.ContainsKey('ExitMessage') -and `
            $ExitMessage -ne $ftpSite.ftpServer.messages.exitMessage)
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpServer.messages.exitMessage `
                             -Value $ExitMessage `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateExitMessage -f $Name)
        }

        # Update banner message
        if ($PSBoundParameters.ContainsKey('BannerMessage') -and `
            $BannerMessage -ne $ftpSite.ftpServer.messages.bannerMessage)
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpServer.messages.bannerMessage `
                             -Value $BannerMessage `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateBannerMessage -f $Name)
        }

        # Update maximum client connections reached message
        if ($PSBoundParameters.ContainsKey('MaxClientsMessage') -and `
            $MaxClientsMessage -ne $ftpSite.ftpServer.messages.maxClientsMessage)
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpServer.messages.maxClientsMessage `
                             -Value $MaxClientsMessage `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateMaxClientsMessage -f $Name)
        }

        # Update default banner suppression
        if ($PSBoundParameters.ContainsKey('SuppressDefaultBanner') -and `
            $SuppressDefaultBanner -ne $ftpSite.ftpServer.messages.suppressDefaultBanner)
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpServer.messages.suppressDefaultBanner `
                             -Value $SuppressDefaultBanner `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateSuppressDefaultBanner -f $Name)
        }

        # Update allowance of detailed errors locally
        if ($PSBoundParameters.ContainsKey('AllowLocalDetailedErrors') -and `
            $AllowLocalDetailedErrors -ne $ftpSite.ftpServer.messages.allowLocalDetailedErrors)
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpServer.messages.allowLocalDetailedErrors `
                             -Value $AllowLocalDetailedErrors `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateAllowLocalDetailedErrors -f $Name)
        }

        # Update expansion of user variables in messages
        if ($PSBoundParameters.ContainsKey('ExpandVariablesInMessages') -and `
            $ExpandVariablesInMessages -ne $ftpSite.ftpServer.messages.expandVariables)
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpServer.messages.expandVariables `
                             -Value $ExpandVariablesInMessages `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateExpandVariablesInMessages -f $Name)
        }

        # Update LogFlags if required
        if ($PSBoundParameters.ContainsKey('LogFlags') -and `
            (-not (Compare-LogFlags -Name $Name `
                                    -LogFlags $LogFlags -FtpSite)))
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpServer.logFile.logExtFileFlags `
                             -Value ($LogFlags -join ',') `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateLogFlags `
                                -f $Name)
        }

        # Update LogPath if required
        if ($PSBoundParameters.ContainsKey('LogPath') -and `
            ($LogPath -ne $ftpSite.ftpServer.logFile.directory))
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpServer.logFile.directory `
                             -Value $LogPath `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateLogPath `
                            -f $Name)
        }

        # Update LogPeriod if needed
        if ($PSBoundParameters.ContainsKey('LogPeriod') -and `
            ($LogPeriod -ne $ftpSite.ftpServer.logFile.period))
        {
            if ($PSBoundParameters.ContainsKey('LogTruncateSize'))
            {
                Write-Verbose -Message ($LocalizedData.WarningLogPeriod -f $Name)
            }
            else
            {
                Set-ItemProperty -Path "IIS:\Sites\$Name" `
                                 -Name ftpServer.logFile.period `
                                 -Value $LogPeriod `
                                 -ErrorAction Stop
                Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateLogPeriod -f $name)
            }
        }

        # Update LogTruncateSize if needed
        if ($PSBoundParameters.ContainsKey('LogTruncateSize') -and `
            ($LogTruncateSize -ne $ftpSite.ftpServer.logFile.truncateSize))
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpserver.logFile.truncateSize `
                             -Value $LogTruncateSize `
                             -ErrorAction Stop
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpserver.logFile.period `
                             -Value 'MaxSize' `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateLogTruncateSize `
                                -f $Name)
        }

        # Update LoglocalTimeRollover if neeed
        if ($PSBoundParameters.ContainsKey('LoglocalTimeRollover') -and `
            ($LoglocalTimeRollover -ne `
                ([System.Convert]::ToBoolean($ftpSite.ftpServer.logFile.localTimeRollover))))
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpserver.logFile.localTimeRollover `
                             -Value $LoglocalTimeRollover
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateLoglocalTimeRollover `
                                -f $Name)
        }

        # Update DirectoryBrowse if required
        if ($PSBoundParameters.ContainsKey('DirectoryBrowseFlags') -and `
            (-not (Compare-DirectoryBrowseFlags -Site $Name `
                                                -DirectoryBrowseFlags $DirectoryBrowseFlags)))
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpserver.directoryBrowse.showFlags `
                             -Value ($DirectoryBrowseFlags -join ',') `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateDirectoryBrowseFlags `
                                -f $Name)
        }

        # Update UserIsolation if required
        if ($PSBoundParameters.ContainsKey('UserIsolation') -and `
            ($UserIsolation -ne $ftpSite.ftpServer.userIsolation.mode))
        {
            Set-ItemProperty -Path "IIS:\Sites\$Name" `
                             -Name ftpServer.userIsolation.mode `
                             -Value $UserIsolation `
                             -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdateUserIsolation `
                                -f $Name)
        }

        # Update State if required
        if ($PSBoundParameters.ContainsKey('State') -and `
            $ftpSite.State -ne $State)
        {
            if ($State -eq 'Started')
            {
                try
                {
                    Write-Verbose -Message ($LocalizedData.VerboseStartWebsite `
                                    -f $Name)
                    Start-Website -Name $Name -ErrorAction Stop
                }
                catch
                {
                    $errorMessage = $LocalizedData.ErrorftpSiteStateFailure `
                                    -f $Name, $_.Exception.Message
                    New-TerminatingError -ErrorId 'WebsiteStateFailure' `
                                         -ErrorMessage $errorMessage `
                                         -ErrorCategory 'InvalidOperation'
                }
            }
            else
            {
                try
                {
                    Write-Verbose -Message ($LocalizedData.VerboseStopWebsite `
                                    -f $Name)
                    Stop-Website -Name $Name -ErrorAction Stop
                }
                catch
                {
                    $errorMessage = $LocalizedData.ErrorftpSiteStateFailure `
                                    -f $Name, $_.Exception.Message
                    New-TerminatingError -ErrorId 'WebsiteStateFailure' `
                                         -ErrorMessage $errorMessage `
                                         -ErrorCategory 'InvalidOperation'
                }
            }

            Write-Verbose -Message ($LocalizedData.VerboseSetTargetUpdatedState `
                                    -f $Name)
        }
    }
    else # Remove ftpSite
    {
        try
        {
            Remove-Website -Name $Name -ErrorAction Stop
            Write-Verbose -Message ($LocalizedData.VerboseSetTargetftpSiteRemoved `
                                    -f $Name)
        }
        catch
        {
            $errorMessage = $LocalizedData.ErrorftpSiteRemovalFailure `
                            -f $Name, $_.Exception.Message
            New-TerminatingError -ErrorId 'ftpSiteRemovalFailure' `
                                 -ErrorMessage $errorMessage `
                                 -ErrorCategory 'InvalidOperation'
        }
    }
}

<#
    .SYNOPSIS
        The Test-TargetResource cmdlet is used to validate if the role or feature is in a state as
        expected in the instance document.
#>
function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([Boolean])]
    param
    (
        [ValidateSet('Present', 'Absent')]
        [String] $Ensure = 'Present',

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $Name,

        [ValidateNotNullOrEmpty()]
        [String] $PhysicalPath,

        [System.Management.Automation.CredentialAttribute()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $PhysicalPathCredential,

        [ValidateSet('Started', 'Stopped')]
        [String] $State = 'Started',

        # The application pool name must contain between 1 and 64 characters
        [ValidateLength(1, 64)]
        [String] $ApplicationPool,

        [Microsoft.Management.Infrastructure.CimInstance] $AuthenticationInfo,

        [Microsoft.Management.Infrastructure.CimInstance[]] $AuthorizationInfo,

        [Microsoft.Management.Infrastructure.CimInstance] $SslInfo,

        [Microsoft.Management.Infrastructure.CimInstance[]] $BindingInfo,

        [String] $FirewallIPAddress,

        [ValidateScript({$_ -eq 0 -or $_ -in 1025 .. 65535})]
        [uint16] $StartingDataChannelPort,

        [ValidateScript({$_ -eq 0 -or $_ -in 1025 .. 65535})]
        [uint16] $EndingDataChannelPort,

        [String] $GreetingMessage,

        [String] $ExitMessage,

        [String] $BannerMessage,

        [String] $MaxClientsMessage,

        [Boolean] $SuppressDefaultBanner,

        [Boolean] $AllowLocalDetailedErrors,

        [Boolean] $ExpandVariablesInMessages,

        [ValidateSet('Date','Time','ClientIP','UserName','ServerIP','Method','UriStem','UriQuery','HttpStatus','Win32Status','TimeTaken','ServerPort','UserAgent','Referer','HttpSubStatus')]
        [String[]] $LogFlags,

        [String] $LogPath,

        [ValidateSet('Hourly','Daily','Weekly','Monthly','MaxSize')]
        [String] $LogPeriod,

        [ValidateRange('1048576','4294967295')]
        [String] $LogTruncateSize,

        [Boolean] $LoglocalTimeRollover,

        [ValidateSet('StyleUnix','LongDate','DisplayAvailableBytes','DisplayVirtualDirectories')]
        [String[]] $DirectoryBrowseFlags,

        [ValidateSet('None','StartInUsersDirectory','IsolateAllDirectories','IsolateRootDirectoryOnly')]
        [String] $UserIsolation
    )

    Assert-Module

    $InDesiredState = $true

    $ftpSite = Get-Website | Where-Object -FilterScript {$_.Name -eq $Name}

    # Check Ensure
    if (($Ensure -eq 'Present' -and $null -eq $ftpSite) -or `
        ($Ensure -eq 'Absent' -and $null -ne $ftpSite))
    {
        $InDesiredState = $false
        Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseEnsure `
                                -f $Name)
    }

    # Only check properties if website exists
    if ($Ensure -eq 'Present' -and `
        $null -ne $ftpSite)
    {
        $iisType = 'Ftp'
        $defaultFirewallSupport = Get-WebConfiguration -Filter '/system.ftpServer/firewallSupport'

        if ($null -eq $AuthenticationInfo)
        {
            $AuthenticationInfo = Get-DefaultAuthenticationInfo -IisType $IisType
        }

        # Check Physical Path property
        if ([string]::IsNullOrEmpty($PhysicalPath) -eq $false -and `
            $ftpSite.PhysicalPath -ne $PhysicalPath)
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalsePhysicalPath -f $Name)
        }

        # Update physical path access credential if required
        if ($PSBoundParameters.ContainsKey('PhysicalPathCredential') -and `
            (-not (Test-AccessCredential -Site $Name -Credential $PhysicalPathCredential)))
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalsePhysicalPathCredential -f $Name)
        }

        # Check State
        if ($PSBoundParameters.ContainsKey('State') -and $ftpSite.State -ne $State)
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseState -f $Name)
        }

        # Check Application Pool property
        if ($PSBoundParameters.ContainsKey('ApplicationPool') -and `
            $ftpSite.ApplicationPool -ne $ApplicationPool)
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseApplicationPool -f $Name)
        }

        # Check AuthenticationInfo
        if (-not (Test-AuthenticationInfo -Site $Name `
                                           -IisType $IisType `
                                           -AuthenticationInfo $AuthenticationInfo))
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseAuthenticationInfo -f $Name)
        }

        # Check Authorization
        if ($PSBoundParameters.ContainsKey('AuthorizationInfo') -and `
            (-not (Test-AuthorizationInfo -Site $Name `
                                               -AuthorizationInfo $AuthorizationInfo)))
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseAuthorizationInfo -f $Name)
        }

        # Check Binding properties
        if ($PSBoundParameters.ContainsKey('BindingInfo') -and `
            $null -ne $BindingInfo)
        {
            if (-not (Test-WebsiteBinding -Name $Name -BindingInfo $BindingInfo))
            {
                $InDesiredState = $false
                Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseBindingInfo -f $Name)
            }
        }

        # Check SslInfo
        if ($PSBoundParameters.ContainsKey('SslInfo') -and `
            (-not (Confirm-UniqueSslInfo -Site $Name -SslInfo $SslInfo)))
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseSslInfo -f $Name)
        }

        # Check external firewall IP address
        if ($PSBoundParameters.ContainsKey('FirewallIPAddress') -and `
            $FirewallIPAddress -ne $ftpSite.ftpServer.firewallSupport.externalIp4Address)
        {
            if ($FirewallIPAddress)
            {
                Test-IPAddress $FirewallIPAddress | Out-Null
            }
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseExternalIPaddress -f $Name)
        }

        # Check starting data channel port number
        if ($PSBoundParameters.ContainsKey('StartingDataChannelPort') -and `
            $StartingDataChannelPort -ne $defaultFirewallSupport.lowDataChannelPort)
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseStartingDataChannelPort -f $Name)
        }

        # Check ending data channel port number
        if ($PSBoundParameters.ContainsKey('EndingDataChannelPort') -and `
            $EndingDataChannelPort -ne $defaultFirewallSupport.highDataChannelPort)
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseEndingDataChannelPort -f $Name)
        }

        # Check greeting message
        if ($PSBoundParameters.ContainsKey('GreetingMessage') -and `
            $GreetingMessage -ne $ftpSite.ftpServer.messages.greetingMessage)
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseGreetingMessage -f $Name)
        }

        # Check exit message
        if ($PSBoundParameters.ContainsKey('ExitMessage') -and `
            $ExitMessage -ne $ftpSite.ftpServer.messages.exitMessage)
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseExitMessage -f $Name)
        }

        # Check banner message
        if ($PSBoundParameters.ContainsKey('BannerMessage') -and `
            $BannerMessage -ne $ftpSite.ftpServer.messages.bannerMessage)
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseBannerMessage -f $Name)
        }

        # Check maximum client connections reached message
        if ($PSBoundParameters.ContainsKey('MaxClientsMessage') -and `
            $MaxClientsMessage -ne $ftpSite.ftpServer.messages.maxClientsMessage)
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseMaxClientsMessage -f $Name)
        }

        # Check default banner suppression
        if ($PSBoundParameters.ContainsKey('SuppressDefaultBanner') -and `
            $SuppressDefaultBanner -ne $ftpSite.ftpServer.messages.suppressDefaultBanner)
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseSuppressDefaultBanner -f $Name)
        }

        # Check allowance of detailed errors locally
        if ($PSBoundParameters.ContainsKey('AllowLocalDetailedErrors') -and `
            $AllowLocalDetailedErrors -ne $ftpSite.ftpServer.messages.allowLocalDetailedErrors)
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseAllowLocalDetailedErrors -f $Name)
        }

        # Check expansion of user variables in messages
        if ($PSBoundParameters.ContainsKey('ExpandVariablesInMessages') -and `
            $ExpandVariablesInMessages -ne $ftpSite.ftpServer.messages.expandVariables)
        {
            $InDesiredState = $false
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseExpandVariablesInMessages -f $Name)
        }

        # Check LogFlags
        if ($PSBoundParameters.ContainsKey('LogFlags') -and `
            (-not (Compare-LogFlags -Name $Name -LogFlags $LogFlags -FtpSite)))
        {
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseLogFlags -f $Name)
            return $false
        }

        # Check LogPath
        if ($PSBoundParameters.ContainsKey('LogPath') -and `
            ($LogPath -ne $ftpSite.ftpServer.logFile.directory))
        {
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseLogPath -f $Name)
            return $false
        }

        # Check LogPeriod
        if ($PSBoundParameters.ContainsKey('LogPeriod') -and `
            ($LogPeriod -ne $ftpSite.ftpServer.logFile.period))
        {
            if ($PSBoundParameters.ContainsKey('LogTruncateSize'))
            {
                Write-Verbose -Message ($LocalizedData.WarningLogPeriod -f $Name)
            }
            else
            {
                Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseLogPeriod -f $Name)
                return $false
            }
        }

        # Check LogTruncateSize
        if ($PSBoundParameters.ContainsKey('LogTruncateSize') -and `
            ($LogTruncateSize -ne $ftpSite.ftpServer.logFile.truncateSize))
        {
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseLogTruncateSize -f $Name)
            return $false
        }

        # Check LoglocalTimeRollover
        if ($PSBoundParameters.ContainsKey('LoglocalTimeRollover') -and `
            ($LoglocalTimeRollover -ne `
            ([System.Convert]::ToBoolean($ftpSite.ftpServer.logFile.localTimeRollover))))
        {
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseLoglocalTimeRollover -f $Name)
            return $false
        }

        # Check DirectoryBrowseFlags
        if ($PSBoundParameters.ContainsKey('DirectoryBrowseFlags') -and `
            (-not (Compare-DirectoryBrowseFlags -Site $Name `
                                                -DirectoryBrowseFlags $DirectoryBrowseFlags)))
        {
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseDirectoryBrowseFlags -f $Name)
            return $false
        }

        # Check UserIsolation
        if ($PSBoundParameters.ContainsKey('UserIsolation') -and `
            ($UserIsolation -ne $ftpSite.ftpServer.userIsolation.mode))
        {
            Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseUserIsolation -f $Name)
            return $false
        }
    }

    if ($InDesiredState -eq $true)
    {
        Write-Verbose -Message ($LocalizedData.VerboseTestTargetTrueResult)
    }
    else
    {
        Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseResult)
    }

    return $InDesiredState
}

# region Helper Functions

<#
    .SYNOPSIS
        Helper function used to validate the DirectoryBrowse status.
        Returns False if the DirectoryBrowseflags do not match and true if they do.

    .PARAMETER DirectoryBrowseflags
        Specifies flags to check.

    .PARAMETER Site
        Specifies the name of the FTP Site.
#>
function Compare-DirectoryBrowseFlags
{
    [CmdletBinding()]
    [OutputType([Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('StyleUnix','LongDate','DisplayAvailableBytes','DisplayVirtualDirectories')]
        [String[]] $DirectoryBrowseflags,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $Site

    )

    $CurrentDirectoryBrowseflags = (Get-Website -Name $Site).ftpServer.directoryBrowse.showFlags `
                                    -split ',' | Sort-Object
    $ProposedDirectoryBrowseflags = $DirectoryBrowseflags `
                                    -split ',' | Sort-Object

    if (Compare-Object -ReferenceObject $CurrentDirectoryBrowseflags `
                       -DifferenceObject $ProposedDirectoryBrowseflags)
    {
        return $false
    }

    return $true
}

<#
    .SYNOPSIS
        Helper function used to validate that the Authorization is unique to current
        per CimInstance of MSFT_xFTPAuthorizationInformation.

    .PARAMETER CurrentAuthorizationCollection
        Specifies PSCustomObject of the current Authorization collection defined on the
        ftpsite.

    .PARAMETER Authorization
        Specifies the CIM of the single desired Authorization definition.

    .PARAMETER Property
        Key property to check against.

    .NOTES
        Compare-Object can be a bit weird so the approach to checking is done slightly
        different in this function.
#>
function Confirm-UniqueFTPAuthorization
{
    [CmdletBinding()]
    [OutputType([Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject[]] $CurrentAuthorizationCollection,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Management.Infrastructure.CimInstance] $Authorization,

        [Parameter(Mandatory = $true)]
        [ValidateSet('users','roles')]
        [String] $Property
    )

    $desiredObject = New-Object -TypeName PSObject -Property @{
        accessType  = $Authorization.accessType
        users       = $Authorization.users
        roles       = $Authorization.roles
        permissions = $Authorization.permissions
    }

    $existingFtpAuthorizationInfo = $CurrentAuthorizationCollection | `
        Where-Object -Property $Property -eq -Value $Authorization.$Property | `
        Select-Object accessType,users,roles,permissions

    $existingObject=$()
    $existingObject += foreach($existingAuthorization in $existingFtpAuthorizationInfo)
    {
        $currentObject = New-Object -TypeName PSObject `
                                    -Property @{
                                        accessType  = $existingAuthorization.accessType
                                        users       = $existingAuthorization.users
                                        roles       = $existingAuthorization.roles
                                        permissions = $existingAuthorization.permissions
                                    }

        $compare = Compare-Object `
                        -ReferenceObject $($existingAuthorization) `
                        -DifferenceObject $($desiredObject) `
                        -Property $Property,accessType,permissions

        $null -eq $compare
    }

    if (-not $existingObject -or $true -notin $existingObject)
    {
        return $false
    }

    return $true
}

<#
    .SYNOPSIS
        Helper function used to validate that the SslInfo needs to be changed

    .PARAMETER Site
        Specifies the name of the FTP Site.

    .PARAMETER SslInfo
        Specifies the CIM of the SslInfo.
#>
function Confirm-UniqueSslInfo
{
    [CmdletBinding()]
    [OutputType([Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [String] $Site,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Management.Infrastructure.CimInstance] $SslInfo
    )

    $Store = $SslInfo.CertificateStoreName
    $Hash  = $SslInfo.CertificateThumbprint

    if($null -ne $Hash -and -not(Test-Path -Path Cert:\LocalMachine\${Store}\${Hash}))
    {
        $errorMessage = $LocalizedData.ErrorServerCertHashFailure `
                        -f $SslInfo.CertificateThumbprint,$SslInfo.CertificateStoreName
        New-TerminatingError -ErrorId 'ErrorServerCertHashFailure' `
                                -ErrorMessage $errorMessage `
                                -ErrorCategory 'InvalidResult'
    }

    $Properties     = @()
    $proposedObject = New-Object -TypeName PSObject
    foreach ($value in ($SslInfo.CimInstanceProperties | Where-Object {$null -ne $_.Value}).Name)
    {
        $correctValue = switch($value)
        {
            CertificateThumbprint { 'serverCertHash' }
            CertificateStoreName  { 'serverCertStoreName' }
            RequireSsl128         { 'ssl128' }
            ControlChannelPolicy  { 'controlChannelPolicy' }
            DataChannelPolicy     { 'dataChannelPolicy' }
        }
        $proposedObject | Add-Member -Type NoteProperty -Name $correctValue -Value $SslInfo.$value
        $Properties += $correctValue
    }

    $currentSslInfo = ((Get-Website -Name $Site).ftpServer.security.ssl)
    $existingObject = $currentSslInfo | Select-Object $Properties

    $compare = Compare-Object -ReferenceObject $existingObject `
                              -DifferenceObject $proposedObject `
                              -Property $Properties

    if($null -ne $compare)
    {
        return $false
    }

    return $true
}

<#
    .SYNOPSIS
        Helper function used to get the AuthorizationInfo for use in Get-TargetResource

    .PARAMETER Site
        Specifies the name of the FTP Site.
#>
function Get-AuthorizationInfo
{
    [CmdletBinding()]
    [OutputType([Microsoft.Management.Infrastructure.CimInstance])]
    param
    (
        [Parameter(Mandatory = $true)]
        [String] $Site
    )

    $authCollections = (Get-WebConfiguration `
                            -Filter '/system.ftpServer/security/authorization' `
                            -Location $Site).Collection

    $authorizationInfo = @()
    foreach($authCollection in $authCollections)
    {
        $authorizationProperties = @{}
        foreach ($type in @('accessType', 'users', 'roles', 'permissions'))
        {
            $authorizationProperties[$type] = [String]$authCollection.${type}
        }

        $authorizationInfo += New-CimInstance `
                                -ClassName MSFT_xFTPAuthorizationInformation `
                                -ClientOnly -Property $authorizationProperties `
                                -Namespace 'root/microsoft/Windows/DesiredStateConfiguration'
    }

    return $authorizationInfo
}

<#
    .SYNOPSIS
        Helper function used to get the SslInfo for use in Get-TargetResource.

    .PARAMETER Site
        Specifies the name of the FTP Site.
#>
function Get-SslInfo
{
    [CmdletBinding()]
    [OutputType([Microsoft.Management.Infrastructure.CimInstance])]
    param
    (
        [Parameter(Mandatory = $true)]
        [String] $Site
    )

    $sslProperties = @{}
    foreach ($type in @('controlChannelPolicy', 'dataChannelPolicy', 'ssl128', 'serverCertHash', 'serverCertStoreName'))
    {
        $correctValue = switch($type)
        {
            serverCertHash       { 'CertificateThumbprint' }
            serverCertStoreName  { 'CertificateStoreName' }
            ssl128               { 'RequireSsl128' }
            controlChannelPolicy { 'ControlChannelPolicy' }
            dataChannelPolicy    { 'DataChannelPolicy' }
        }

        if ($type -eq 'ssl128')
        {
            $sslProperties[$correctValue] = [Boolean](Get-Item -Path IIS:\Sites\${Site}\).ftpServer.security.ssl.${type}
        }
        else
        {
            $sslProperties[$correctValue] = [String](Get-Item -Path IIS:\Sites\${Site}\).ftpServer.security.ssl.${type}
        }
    }

    return New-CimInstance -ClassName MSFT_xFTPSslInformation `
                           -ClientOnly -Property $sslProperties `
                           -Namespace 'root/microsoft/Windows/DesiredStateConfiguration'
}

<#
    .SYNOPSIS
        Helper function used to set the AuthorizationInfo.

    .PARAMETER Site
        Specifies the name of the FTP Site.

    .PARAMETER AuthorizationInfo
        Specifies the CIM of the AuthorizationInfo.
#>
function Set-FTPAuthorization
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [String] $Site,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Management.Infrastructure.CimInstance[]] $AuthorizationInfo
    )

    Clear-WebConfiguration `
        -Filter '/system.ftpServer/security/authorization' `
        -Location $Site `
        -PSPath 'IIS:\' `
        -Force `
        -ErrorAction Stop

    foreach ($authInfo in $AuthorizationInfo)
    {
        Add-WebConfiguration `
            -Filter '/system.ftpServer/security/authorization' `
            -Value @{
                    accessType  = $authInfo.accessType;
                    roles       = $authInfo.roles;
                    permissions = $authInfo.permissions;
                    users       = $authInfo.users
            } `
            -PSPath IIS:\ `
            -Location $Site
    }
}

<#
    .SYNOPSIS
        Helper function used to set the SslInfo.

    .PARAMETER Site
        Specifies the name of the FTP Site.

    .PARAMETER AuthorizationInfo
        Specifies the CIM of the SslInfo.
#>
function Set-SslInfo
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [String] $Site,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Management.Infrastructure.CimInstance] $SslInfo
    )

    foreach ($value in ($SslInfo.CimInstanceProperties | Where-Object {$null -ne $_.Value}).Name)
    {
        $correctValue = switch($value)
        {
            CertificateThumbprint { 'serverCertHash' }
            CertificateStoreName  { 'serverCertStoreName' }
            RequireSsl128         { 'ssl128' }
            ControlChannelPolicy  { 'controlChannelPolicy' }
            DataChannelPolicy     { 'dataChannelPolicy' }
        }

        Set-ItemProperty -Path "IIS:\Sites\$Site" `
                         -Name "ftpServer.security.ssl.$correctValue" `
                         -Value ($SslInfo.CimInstanceProperties | `
                             Where-Object {$_.Name -eq $value}).Value
    }
}

<#
    .SYNOPSIS
        Helper function used to validate that the AuthorizationInfo is unique.

    .PARAMETER Site
            Specifies the name of the FTP Site.

    .PARAMETER AuthorizationInfo
        Specifies the CIM of the AuthorizationInfo.
#>
function Test-AuthorizationInfo
{
    [CmdletBinding()]
    [OutputType([Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [String] $Site,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Management.Infrastructure.CimInstance[]] $AuthorizationInfo
    )

    $currentFtpAuthorizationInfo = (Get-WebConfiguration `
                                            -Filter '/system.ftpServer/security/authorization' `
                                            -Location $Site).Collection

    if ($currentFtpAuthorizationInfo.Count -ne $AuthorizationInfo.Count)
    {
        return $false
    }

    foreach ($Authorization in $AuthorizationInfo)
    {
        if ($Authorization.users)
        {
            if(-not(Confirm-UniqueFTPAuthorization -CurrentAuthorizationCollection $currentFtpAuthorizationInfo `
                                                   -Authorization $Authorization `
                                                   -Property users))
            {
                return $false
            }
        }

        if ($Authorization.roles)
        {
            if(-not(Confirm-UniqueFTPAuthorization -CurrentAuthorizationCollection $currentFtpAuthorizationInfo `
                                                   -Authorization $Authorization `
                                                   -Property roles))
            {
                return $false
            }
        }
    }

    return $true
}

#endregion

Export-ModuleMember -Function *-TargetResource
