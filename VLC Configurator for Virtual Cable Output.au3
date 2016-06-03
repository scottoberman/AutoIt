; VLC Configurator for Virtual Cable Output
;
;	Changes the output module to output to the virtual cable
;	driver which will allow sounds in vlc to be output much like
;	the microphone.

$sleepDelay = 300

   Run("C:\Users\scott\Documents\GitHub\AutoIt\runvlc.bat", "", @SW_MAXIMIZE)

   If WinWait("VLC media player", "", 10) Then

	  WinActivate("VLC media player")

	  Send("{ALT}")
	  Sleep($sleepDelay)
	  Send("o")
	  Sleep($sleepDelay)
	  Send("{UP}")
	  Sleep($sleepDelay)
	  Send("{ENTER}")
	  Sleep($sleepDelay)
	  Send("{TAB}");
	  Sleep($sleepDelay)
	  Send("{TAB}")
	  Sleep($sleepDelay)
	  Send("{TAB}")
	  Sleep($sleepDelay)
	  Send("{TAB}")
	  Sleep($sleepDelay)
	  Send("{RIGHT}")
	  Sleep($sleepDelay)

	  For $x = 0 To 4 Step 1
		 Send("{LSHIFT down}{TAB}")
		 Sleep($sleepDelay)
		 Send("{LSHIFT up}")
	  Next

	  For $x = 0 To 2 Step 1
		 Send("{DOWN}")
		 Sleep($sleepDelay)
	  Next

	  Send("{ENTER}")

   Else
	  ; TODO Make error window that states that the vlc window has not opened
	  $errorWin = GuiCreate("VLC Window Not Opening", 500, 500)
	  GUICtrlCreateLabel("The VLC Window is not opening and cannot be modified")
	  GUICtrlSetData(
	  GUISetState(@SW_SHOW)
	  Gu
   EndIf

