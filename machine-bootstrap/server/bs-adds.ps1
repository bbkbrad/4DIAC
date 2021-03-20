### get credentials for reboots
$cred=Get-Credential domain\username

### update OS
Enable-MicrosoftUpdate
Install-WindowsUpdate -AcceptEula

### boxstarter package url
$4DIAC_ADDS_1 = 'https://raw.githubusercontent.com/bbkbrad/4DIAC/main/machine-bootstrap/server/4DIAC_ADDS_1.ps1?token=AN6IDO5TZ2WSCATZ2C3NLPDAKVXN2'
$4DIAC_ADDS_2 = 'https://raw.githubusercontent.com/bbkbrad/4DIAC/main/machine-bootstrap/server/4DIAC_ADDS_2.ps1?token=AN6IDO2QVPWMSDWIJXCWARDAKVXPY'
$4DIAC_ADDS_3 = 'https://raw.githubusercontent.com/bbkbrad/4DIAC/main/machine-bootstrap/server/4DIAC_ADDS_3.ps1?token=AN6IDO2HJ77SDV22F7TGGI3AKVXQS'

### install boxstarter packages
Install-BoxstarterPackage -PackageName $4DIAC_ADDS_1,$4DIAC_ADDS_2,$4DIAC_ADDS_3 -Credential $cred

### cleanup misc files
del C:\eula*.txt
del C:\install.*
del C:\vcredist.*
del C:\vc_red.*