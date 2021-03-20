###############################
####  install chocolatey   ####
###############################  
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


###############################
####  install boxstarter   ####
###############################
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force

Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/krath1bb/workstation-setup/main/choc-config.ps1
