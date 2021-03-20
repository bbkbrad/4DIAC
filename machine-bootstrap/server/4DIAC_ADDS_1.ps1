### Set Hostname
Write-Host -ForegroundColor Yellow 'Please enter a hostname for the domain controller.' `n
$hostname = Read-Host
(Get-WmiObject Win32_ComputerSystem).Rename($hostname)

### Set Static IP
Write-Host -ForegroundColor Yellow 'Please enter IP address, Gateway, and Subnet CIDR' `n
$ipaddress = Read-Host
Write-Host -ForegroundColor Yellow 'Please enter a hostname for the domain controller.' `n
$gateway = Read-Host
Write-Host -ForegroundColor Yellow 'Please enter a hostname for the domain controller.' `n
$subnetmask = Read-Host
New-NetIPAddress –IPAddress $ipaddress -DefaultGateway $gateway -PrefixLength $subnetmask -InterfaceIndex (Get-NetAdapter).InterfaceIndex

### Reboot
Invoke-Reboot