####  install chocolatey
#Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


####  install boxstarter
#Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://boxstarter.org/bootstrapper.ps1')); Get-Boxstarter -Force


### script selection
Do {
    Write-Host -ForegroundColor Yellow 'Choose a profile:'
    Write-Host -ForegroundColor Green '   1. Base Workstation'
    Write-Host -ForegroundColor Green '   2. Brads Workstation'
    Write-Host -ForegroundColor Green '   3. Base Server'
    Write-Host -ForegroundColor Green '   4. Domain Controller'
    $selection = Read-Host
    If ($selection -eq "1")
        {
            Write-Host -ForegroundColor Yellow 'You selected:'
            Write-Host -ForegroundColor Green -NoNewLine '  Base Workstation' `n
        }
    Elseif ($selection -eq "2")
        {
            Write-Host -ForegroundColor Yellow 'You selected:'
            Write-Host -ForegroundColor Green -NoNewLine '  Brads Workstation' `n
            Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/bbkbrad/4DIAC/main/machine-bootstrap/workstation/choc-brad.ps1?token=AN6IDO7RFQOQAO6FWFWHZQTAKVP5O
        }
    Elseif ($selection -eq "3")
        {
            Write-Host -ForegroundColor Yellow 'You selected:'
            Write-Host -ForegroundColor Green -NoNewLine '  Base Server' `n
            Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/bbkbrad/4DIAC/main/machine-bootstrap/server/choc-server.ps1?token=AN6IDO3TUREGI2FNS4M2I5TAKVPGA
        }
    Elseif ($selection -eq "4")
        {
            Write-Host -ForegroundColor Yellow 'You selected:'
            Write-Host -ForegroundColor Green -NoNewLine '  Domain Controller' `n
            Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/bbkbrad/4DIAC/main/machine-bootstrap/server/choc-adds.ps1?token=AN6IDO5QNIIYEC74ZAWQWLLAKVV7G
        }
    Else{
        Write-Warning "Invalid Input"
        }
    }
    While ($success -eq 0)