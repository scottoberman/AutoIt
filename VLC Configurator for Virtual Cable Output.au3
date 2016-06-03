; VLC Configurator for Virtual Cable Output
;
;	Changes the output module to output to the virtual cable
;	driver which will allow sounds in vlc to be output much like
;	the microphone. The output can also be changed to the default
;	(which is usually just the speakers).

$sleepDelay = 50


$choiceWin = GUICreate("VLC Mode", 250, 120)
GUICTRlCreateLabel("How would you like VLC to be configured?", 25, 25)
$skypeBut = GUICtrlCreateButton("Skype Output", 10, 45, 100, 50)
$speakBut = GUICtrlCreateButton("Speaker Output", 140, 45, 100, 50)
GUISetState(@SW_SHOW)

$msg = 0

While Not( $msg = $skypeBut Or $msg = $speakBut)
   $msg = GUIGetMsg()
WEnd

GUISetState(@SW_HIDE, $choiceWin)

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
	  If $msg = $skypeBut Then
		 Send("{DOWN}")
	  ElseIf $msg = $speakBut Then
		 Send("{UP}")
	  EndIf
	  Sleep($sleepDelay)
   Next

   Send("{ENTER}")

   Winclose("VLC media player")

   If $msg = $skypeBut Then
	  Run("C:\Users\scott\Documents\GitHub\AutoIt\runvlc.bat", "", @SW_MAXIMIZE)
   EndIf

Else
   ; TODO Make error window that states that the vlc window has not opened
   ErrorWin("VLC Window not Opening")
EndIf

Exit


Func ErrorWin($errorMessage)

   GuiCreate("ERROR", 200, 150)

   $closeButton = GUICtrlCreateButton("Close", 65, 80, 65, 40)
   $errorWindow = GUICtrlCreateLabel($errorMessage, 50, 50, 150, 100)
   $msg = 0

   GUISetState(@SW_SHOW)
   While Not ($msg = $closeButton)
	  $msg = GUIGetMsg()
   WEnd

EndFunc