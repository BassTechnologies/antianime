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
if ActiveWindow contains anime,�����,hentai, ������
{
	Run, FBI.mp4, , Max UseErrorLevel
	if ErrorLevel = ERROR
		MsgBox Error, Open FBI.mp4
	PID := DllCall("GetCurrentProcessId")
	WinSet, disable,, %ActiveWindow% ;������ ����, � ������� ���� ������� ���� �� ���� contains - ����������������.
	WinSet, AlwaysOnTop, on, ahk_pid %PID% ; .mp4 ���� �� ���� ���� ����.
	sleep 500
	WinGet, OutputVar, Pid, %ActiveWindow% ; �������� PID ���� �� ������
	Process, close, %OutputVar% ;��������� ���
	if timeout != 0
		settimer, repeat, %timeout%
	else
		goto repeat
	timeout := timeout * 100 ;����� �� ������ ������������� Edit ��� ����������, ������� ��������� ������ REPEAT. ������ ���� ����� �� timeout � * �� 100.
	if timeout != 0					;���� ���������� ������� REPEAT 100�� - ����� 10000�� ������ REPEAT ����� ���������� ��������� ������� STOP
		settimer, stop, %timeout%
}
return

repeat:
Process, close, %OutputVar% ;�� ��� ������ ������� ���� �� ������.
if offscreen = 1
	SendMessage, 0x112, 0xF170, 2,, Program Manager ;���� "OffScreen = 1" - ��������� �������
if offsystem = 1
	Shutdown, 13 ; ���� "OffSystem = 1" - ��������� ��
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
