; Copy Pasta Interfacer
;
; 	This script provides a method of copy pasting material to other programs
; 	that either have copy-paste disabled, or there are limits to how many
; 	characters can be entered per input.
; 	Simply enter the text into the input window, enter the number of
; 	characters per input, and press the designated hotkey (TODO: PUT HOTKEY HERE)
; 	and the input will be "pasted" to whichever window is selected.

; TODO: Add history list

#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>

$winWidth 		= 800
$winHeight 		= (5/9) * $winWidth
$inputWidth 	= (6/9) * $winWidth
$inputHeight 	= (16/18) * $winHeight
$currentFKey	= 1
$hotkey 		= "{F" & $currentFKey &"}"


$mainWin 		= GUICreate("Copy Pasta Interfacer", $winWidth, $winHeight)
$inputBox		= GUICtrlCreateEdit("", 1, 1, $inputWidth, $inputHeight)
$hotkeyBut		= GUICtrlCreateButton("Change Hotkey : " & $hotkey & @CRLF & @CRLF & "{F1} - {F11}", 1, 1, 150,75, $BS_MULTILINE)

GUICtrlSetPos($inputBox, 25, 25)
GUICtrlSetPos($hotKeyBut, $inputWidth + 85, $inputHeight - 80)

GUISetState(@SW_SHOW, $mainWin)

HotKeySet($hotkey, "WriteInputToCursor")


While(1)
   sleep(10)
   $guiMsg = GUIGetMsg()
   If $guiMsg = $GUI_EVENT_CLOSE Then
	  ExitProgram()
   ElseIf $guiMsg = $hotkeyBut Then
	  ChangeHotkey()
   EndIf
WEnd



; Write the input to be copy pasted to wherever the user has selected.
Func WriteInputToCursor()
   Local $inputVal = GUICtrlRead($inputBox)
   Local $inputAsCommands = ParseTextToCommands($inputVal)

   For $x = 1 To (UBound($inputAsCommands) - 1)
	  Send($inputAsCommands[$x])
	  GetWinClose()
   Next


EndFunc

Func ParseTextToCommands($input)
   Local $inputToArray[StringLen($input)] = StringSplit($input, "")
   Local $inputAsCommands[UBound($inputToArray)]

   For $x = 0 To (UBound($inputToArray)- 1)
	  If Asc($inputToArray[$x]) == 32 Then
		 $inputAsCommands[$x] = "{SPACE}"
	  ElseIf Not (Asc($inputToArray[$x]) == 10) Then
		 $inputAsCommands[$x] = "{" & $inputToArray[$x] & "}"
	  EndIf

   Next

   Return $inputAsCommands
EndFunc

Func IsAlphaNumeric($val)

   $valToAscii = Asc($val)

   Return(($valToAscii >= 65 And $valToAscii <= 90) Or ($valToAscii >= 97 And $valToAscii <= 122) Or ($valToAscii >= 48 And $valToAscii <= 57))

EndFunc

Func ChangeHotkey()

   HotKeySet($hotkey)

   If $currentFKey < 11 Then
	  $currentFKey = $currentFkey + 1
   Else
	  $currentFKey = 1
   EndIf

   $hotkey 		= "{F" & $currentFKey &"}"
   HotKeySet($hotkey, "WriteInputToCursor")
   GuiCtrlSetData($hotkeyBut, "Change Hotkey : " & $hotkey & @CRLF & @CRLF & "{F1} - {F11}")

EndFunc

; Used to determine if 'x' has been pressed during text copy.
Func GetWinClose()
   If GUIGetMsg() = $GUI_EVENT_CLOSE Then
	  ExitProgram()
   EndIf
EndFunc

Func ExitProgram()
   GuiDelete($mainWin)
   Exit 0
EndFunc