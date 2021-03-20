##########################
##########################
###   function block   ###
##########################
##########################


function set-staticip {
    ### Set Static IP and DNS
   
    New-NetIPAddress -IPAddress $ipaddress -DefaultGateway $gateway -PrefixLength $subnet -InterfaceIndex (Get-NetAdapter).InterfaceIndex    
    Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).InterfaceIndex -ServerAddresses 1.1.1.1, 8.8.8.8
}


function set-hostname {
    ### Set hostname

    (Get-WmiObject Win32_ComputerSystem).Rename($hostname)
    if (Test-PendingReboot) { Invoke-Reboot }
}


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
    
    Invoke-Reboot
}


function authorize-dhcp {
    ### Authorize DHCP server in AD
    
    Add-DhcpServerInDC -DnsName dc1.bk.4diac.com -IPAddress 172.16.0.11


    ### Reboot
    
    Invoke-Reboot
}



####################################
####################################
###   bug user for information   ###
####################################
####################################


### user credentials for persistant reboots

$cred = Get-Credential $env:COMPUTERNAME'\administrator' 


### hostname

Write-Host -ForegroundColor Green 'Provide a hostname for the machine'
$hostname = Read-Host


### static IP address

Write-Host -ForegroundColor Green 'Provide a static IP address (172.16.0.100)'
$ipaddress = Read-Host
Write-Host -ForegroundColor Green 'Provide a default gateway (172.16.0.1)'
$gateway = Read-Host
Write-Host -ForegroundColor Green 'Provide a subnet CIDR (8, 16, 24)'
$subnet = Read-Host


### update OS

Enable-MicrosoftUpdate
Install-WindowsUpdate -AcceptEula

### run fucntions
set-staticip
set-hostname
configure-adds
authorize-dhcp

### cleanup misc files
del C:\eula*.txt
del C:\install.*
del C:\vcredist.*
del C:\vc_red.*


### final reboot
Invoke-Reboot