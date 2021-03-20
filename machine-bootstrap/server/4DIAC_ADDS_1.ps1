### Set Hostname
# Rename-Computer -NewName "dc1" -Force.     ### Requires PS3.0
(Get-WmiObject Win32_ComputerSystem).Rename('dc1')

### Set Static IP
New-NetIPAddress –IPAddress 172.16.0.11 -DefaultGateway 172.16.0.1 -PrefixLength 16 -InterfaceIndex (Get-NetAdapter).InterfaceIndex

### Prompt user to reboot
Write-Host -NoNewline -ForegroundColor Yellow 'Restart computer now? [y/n] '
$input = Read-Host
switch($input){
          y{Restart-computer -Force -Confirm:$false}
          n{exit}
    default{write-warning "Invalid Input"}
}