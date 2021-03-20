######################################
#### make sure we're not bothered ####
######################################

Disable-UAC

######################
#### dependencies ####
######################

## NOTE none right now

#################################
####  install applications   ####
#################################
cinst adobereader
cinst autodesk-fusion360 --ignorechecksum
cinst googlechrome
cinst cura-new
cinst discord
cinst geforce-experience
# NEED TO FIND LOGITECH G HUB
cinst google-drive-file-stream
cinst hwinfo
cinst icue
cinst imgburn
cinst msiafterburner --ignorechecksum
cinst notepadplusplus
cinst office365business
cinst putty
cinst spotify
cinst steam
cinst vlc
#cinst voicemeeter
cinst vscode
cinst winrar
cinst winscp

#################################
####   get windows updates   ####
#################################
Enable-MicrosoftUpdate
Install-WindowsUpdate -AcceptEula

#################
#### cleanup ####
#################

del C:\eula*.txt
del C:\install.*
del C:\vcredist.*
del C:\vc_red.*

###############################
#### windows configuration ####
###############################
Disable-GameBarTips
Disable-BingSearch
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar -DisableOpenFileExplorerToQuickAccess -DisableShowRecentFilesInQuickAccess -DisableShowFrequentFoldersInQuickAccess -EnableShowRibbon
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" -Name Settings -Value ([byte[]](0x30,0x00,0x00,0x00,0xfe,0xff,0xff,0xff,0x02,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0xba,0x00,0x00,0x00,0x28,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x07,0x00,0x00,0x28,0x00,0x00,0x00,0x60,0x00,0x00,0x00,0x01,0x00,0x00,0x00));
Set-TimeZone -Id "Central Standard Time" - PassThru
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sCountry -Value "United States";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sLongDate -Value "dddd, MMMM d, yyyy";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortDate -Value "M/d/yyyy";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortTime -Value "HH:mm";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sTimeFormat -Value "HH:mm:ss";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sYearMonth -Value "MMMM yyyy";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name iFirstDayOfWeek -Value 6;
