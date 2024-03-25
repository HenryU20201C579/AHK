;----------------------------------------------------------------------------------------------------
; CAPA APPSKEY
;----------------------------------------------------------------------------------------------------
Appskey & r::send {Click Right}
Appskey & w::send {Click}
;Appskey & q::send {WheelUp}
;Appskey & a::send {WheelDown}


Appskey & e::
if GetKeyState("Alt", "P") 
    MouseMove 0, -5, 1, R
else 
    MouseMove 0, -100, 1, R
return

Appskey & d::
if GetKeyState("Alt", "P") 
    MouseMove 0, 5, 1, R
else 
    MouseMove 0, 100, 1, R
return

Appskey & s::
if GetKeyState("Alt", "P") 
    MouseMove -5, 0, 1, R
else 
    MouseMove -100, 0, 1, R
return

Appskey & f::
if GetKeyState("Alt", "P") 
    MouseMove 5, 0, 1, R
else 
    MouseMove 100, 0, 1, R
return

Appskey & a::
if GetKeyState("Control", "P") 
    sendinput {CtrlDown}{WheelDown}{CtrlUp}
else 
    send {WheelDown}
return

Appskey & q::
if GetKeyState("Control", "P") 
    sendinput {CtrlDown}{WheelUp}{CtrlUp}
else 
    send {WheelUp}
return