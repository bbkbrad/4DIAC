##########################
##########################
###   function block   ###
##########################
##########################

function configure-adds {
    ### Install AD DS features
    Install-WindowsFeature –Name AD-Domain-Services -IncludeManagementTools


    ### AD DS Configuration
    Install-ADDSForest `
    -DomainName "bk.4diac.com" `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode "7" `
    -DomainNetbiosName "4DIAC" `
    -ForestMode "7" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$True `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true


    ### Install DHCP Role
    Install-WindowsFeature -Name 'DHCP' –IncludeManagementTools


    ### Configure DHCP Scope
    Add-DhcpServerV4Scope `
    -Name "LAN Scope" `
    -StartRange 172.16.0.1 `
    -EndRange 172.16.1.254 `
    -SubnetMask 255.255.0.0 `
    -State Active


    ### Configure DHCP Scope Exclusions
    Add-DhcpServerv4ExclusionRange `
    -ScopeID 172.16.0.0 `
    -StartRange 172.16.0.1 `
    -EndRange 172.16.0.254


    ### Configure DHCP Options
    Set-DhcpServerv4OptionValue -DnsDomain bk.4diac.com -DnsServer 172.16.0.11
    Set-DhcpServerV4OptionValue -DnsServer 172.16.0.11 -Router 172.16.0.1
    Set-DhcpServerv4OptionValue -ComputerName dc1.bk.4diac.com -ScopeID 172.16.0.0 -OptionID 6 -Value 172.16.0.11


    ### Configure DHCP Security Groups
    netsh dhcp add securitygroups


    ### Notify Server Manager that post-install is complete
    Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 -Name ConfigurationState -Value 2


    ### Reboot
    Restart-Computer
}


function authorize-dhcp {
    ### Authorize DHCP server in AD
    Add-DhcpServerInDC -DnsName dc1.bk.4diac.com -IPAddress 172.16.0.11


    ### Reboot
    Restart-Computer
}



####################################
####################################
###   bug user for information   ###
####################################
####################################


### user credentials for persistant reboots
$cred = Get-Credential $env:COMPUTERNAME'\administrator' 


### update OS
Enable-MicrosoftUpdate
Install-WindowsUpdate -AcceptEula


### configure static IP
Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/bbkbrad/4DIAC/main/machine-bootstrap/set-staticip.ps1 -Credential $cred


### hostname
Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/bbkbrad/4DIAC/main/machine-bootstrap/set-hostname.ps1 -Credential $cred


### run fucntions
configure-adds
authorize-dhcp


### cleanup misc files
del C:\eula*.txt
del C:\install.*
del C:\vcredist.*
del C:\vc_red.*


### final reboot
Restart-Computer