function set-staticip {   
    New-NetIPAddress -IPAddress $ipaddress -DefaultGateway $gateway -PrefixLength $subnet -InterfaceIndex (Get-NetAdapter).InterfaceIndex    
    Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).InterfaceIndex -ServerAddresses 1.1.1.1, 8.8.8.8
}

Write-Host -ForegroundColor Green 'Provide a static IP address (172.16.0.100)'
$ipaddress = Read-Host
Write-Host -ForegroundColor Green 'Provide a default gateway (172.16.0.1)'
$gateway = Read-Host
Write-Host -ForegroundColor Green 'Provide a subnet CIDR (8, 16, 24)'
$subnet = Read-Host
set-staticip
