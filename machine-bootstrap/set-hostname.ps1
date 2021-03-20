function set-hostname {
    (Get-WmiObject Win32_ComputerSystem).Rename($hostname)
    if (Test-PendingReboot) { Invoke-Reboot }
}


Write-Host -ForegroundColor Green 'Provide a hostname for the machine'
$hostname = Read-Host
set-hostname
