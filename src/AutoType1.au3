Local $oIE
Local $text

_Main()

Func _Main()
   _Init()
   _Run()
EndFunc

Func _Init()
   HotKeySet('{END}', '_Exit')
   AutoItSetOption('SendKeyDelay', 20)
EndFunc

Func _Run()
   $oIE = ObjCreate('InternetExplorer.Application')

   With $oIE
	  WinSetState(HWnd(.HWND), '', @SW_MAXIMIZE)

	  .Visible = True

	  .Navigate('http://play.typeracer.com')

	  _IE_BusyWait()

	  WinActivate('TypeRacer')

	  Sleep(3000)

	  Local $anchors = .Document.getElementsByClassName('gwt-Anchor')

	  For $anchor in $anchors
		 If $anchor.innerHTML = 'Enter a typing race' Then
			$anchor.click()
		 EndIf
	  Next

	  _IE_BusyWait()
	  Sleep(5000)

	  Local $times = .document.getElementsByClassName('time')

	  For $time in $times
		 If StringLeft($time.innerHTML, 1) = ':' Then
			ExitLoop
		 EndIf
	  Next

	  Local $middleGwt = .document.getElementById('nhwMiddlegwt-uid-8')
	  Local $rightGwt = .document.getElementById('nhwRightgwt-uid-10')
	  $text = $middleGwt.innerHTML & StringTrimRight($rightGwt.innerHTML, 1)

	  While True
		 If $time.innerHTML = ':00' Then
			ExitLoop
		 EndIf

		 Sleep(250)
	  WEnd

	  Sleep(2000)

	  Send($text)
   EndWith
EndFunc

Func _IE_BusyWait()
   While $oIE.busy
	  Sleep(250)
   WEnd
EndFunc

Func _Exit()
   Exit
EndFunc
