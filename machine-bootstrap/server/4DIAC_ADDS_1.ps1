### Set Hostname
#Write-Host -ForegroundColor Yellow 'Please enter a hostname for the domain controller.' `n
#$hostname = Read-Host
(Get-WmiObject Win32_ComputerSystem).Rename($hostname)

### Set Static IP and DNS
New-NetIPAddress -IPAddress 172.16.0.11 -DefaultGateway 172.16.0.1 -PrefixLength 16 -InterfaceIndex (Get-NetAdapter).InterfaceIndex
Set-DnsClientServerAddress -InterfaceIndex 10 -ServerAddresses 1.1.1.1, 8.8.8.8

### Reboot
Invoke-Reboot