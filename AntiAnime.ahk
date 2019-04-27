Menu, tray, NoStandard
Menu, tray, add, @bass_devware, group
Menu, tray, add
Menu, tray, add, Off, OffScript
Menu, tray, add
Menu, tray, add, On, OnScript
Menu, tray, disable, On
Menu, tray, add
Menu, tray, add, Quit, GuiClose
Menu, tray, disable, Quit
Loop, read, config.ini
{
	Loop, parse, A_LoopReadLine, `n
	{
		if regexmatch(A_LoopReadLine, "AutoRun = (.)", AR)
			autorun := AR1
		if regexmatch(A_LoopReadLine, "OffSystem = (.)", osys)
			offsystem := osys1
		if regexmatch(A_LoopReadLine, "OffScreen = (.)", oscr)
			offscreen := oscr1
		if regexmatch(A_LoopReadLine, "TimeCld = (.*)", to)
			timeout := to1
	}
}
WinGetTitle, ActiveWindow, A
LastWindow := ActiveWindow
SetTimer, Label, 5000
return

Label:
WinGetTitle, ActiveWindow, A
if ActiveWindow != %LastWindow%
	goto recheck
LastWindow := ActiveWindow
return

recheck:
if ActiveWindow contains anime,àíèìå,hentai, õåíòàé
{
	Run, %A_Temp%\FBI.mp4, , Max UseErrorLevel
	if ErrorLevel = ERROR
		MsgBox Error, Open FBI.mp4
	PID := DllCall("GetCurrentProcessId")
	WinSet, disable,, %ActiveWindow% ;Äåëàåì îêíî, â êîòîðîì áûëî íàéäåíî îäíî èç ñëîâ contains - äåàêòèâèðîâàííûì.
	WinSet, AlwaysOnTop, on, ahk_pid %PID% ; .mp4 ôàéë ïî âåðõ âñåõ îêîí.
	sleep 500
	WinGet, OutputVar, Pid, %ActiveWindow% ; Ïîëó÷àåì PID îêíà ñî ñëîâîì
	Process, close, %OutputVar% ;Çàêðûâàåì åãî
	if timeout != 0
		settimer, repeat, %timeout%
	else
		goto repeat
	timeout := timeout * 100 ;Ðåøèë íå äåëàòü äîïîëíèòåëüíî Edit äëÿ ïðîìåæóòêà, êîòîðûé îñòàíîâèò òàéìåð REPEAT. Ïðîñòî áåð¸ì ÷èñëî èç timeout è * íà 100.
	if timeout != 0					;Åñëè ïðîìåæóòîê òàéìåðà REPEAT 100ìñ - ÷åðåç 10000ìñ òàéìåð REPEAT áóäåò îñòàíîâëåí áëàãîäàðÿ òàéìåðó STOP
		settimer, stop, %timeout%
}
return

repeat:
Process, close, %OutputVar% ;Íå äà¸ì çàíîâî îòêðûòü ôàéë ñî ñëîâîì.
if offscreen = 1
	SendMessage, 0x112, 0xF170, 2,, Program Manager ;Åñëè "OffScreen = 1" - âûêëþ÷àåì ìîíèòîð
if offsystem = 1
	Shutdown, 13 ; Åñëè "OffSystem = 1" - âûêëþ÷àåì ÏÊ
return

stop:
settimer, repeat, off
return

OffScript:
Menu, tray, disable, Off
Menu, tray, Enable, On
Menu, tray, Enable, Quit
Pause
return

OnScript:
Menu, tray, Enable, Off
Menu, tray, Disable, On
Menu, tray, Disable, Quit
Pause
return

^!END:: ;Ctrl+Alt+End
GuiClose:
ExitApp
return

group:
run, https://vk.com/bass_devware
return
