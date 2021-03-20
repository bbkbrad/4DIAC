### Install AD DS Role
Install-WindowsFeature –Name AD-Domain-Services -IncludeManagementTools

### Install AD DS Configuration
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
Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2

### Reboot
Invoke-Reboot