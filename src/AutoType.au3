#include <AutoItConstants.au3>

Local $oIE

_Main()

Func _Main()
	_Init()
	_Run()
EndFunc

Func _Init()
	HotKeySet('{END}', '_Exit')
	AutoItSetOption('SendKeyDelay', 25)
EndFunc

Func _Run()
	$oIE = ObjCreate('InternetExplorer.Application')

	With $oIE
		Local $text

		.visible = True

		WinActivate('New tab - Internet Explorer')

		.navigate('http://www.typeracer.com')

		_IE_BusyWait()

		Sleep(1000)

		For $gwtAnchor in .document.getElementsByClassName('gwt-Anchor')
			If $gwtAnchor.innerHTML = 'Enter a typing race' Then
				$gwtAnchor.click()

				ExitLoop
			EndIf
		Next

		Sleep(1000)

		With $oIE.document
			$text = .getElementById('nhwMiddlegwt-uid-8').innerHTML & .getElementById('nhwMiddleCommagwt-uid-9').innerHTML & StringTrimRight(.getElementById('nhwRightgwt-uid-10').innerHTML, 1)
		EndWith

		While True
			For $time in .document.getElementsByClassName('time')
				If $time.innerHTML = ':01' Then
					ExitLoop 2
				EndIf
			Next
		WEnd

		Sleep(2000)

		Send($text, $SEND_RAW)
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
