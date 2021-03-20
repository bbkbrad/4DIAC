### Set Hostname
Write-Host -ForegroundColor Yellow 'Please enter a hostname for the domain controller.' `n
$hostname = Read-Host
(Get-WmiObject Win32_ComputerSystem).Rename($hostname)

### Set Static IP
New-NetIPAddress -IPAddress 172.16.0.11 -DefaultGateway 172.16.0.1 -PrefixLength 16 -InterfaceIndex (Get-NetAdapter).InterfaceIndex

### Reboot
Invoke-Reboot