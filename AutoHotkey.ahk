#SingleInstance ignore
Process, Priority, , High
stage := 1
;----------------------------------------------------------------------------------------------------
; SCRIPTS PARA EDITAR MAS FACIL AHK
;----------------------------------------------------------------------------------------------------
Tab Up:: sendinput {Tab}
Alt:: sendinput {}
RAlt:: sendinput { }
Appskey:: sendinput  { }
::comentarahk::
sendinput,
(
;----------------------------------------------------------------------------------------------------
; ESCRIBA AQUI SU TITULO
;----------------------------------------------------------------------------------------------------
)
sendinput {Up}
return

::comentarcpp::
sendinput,
(
//----------------------------------------------------------------------------------------------------
// ESCRIBA AQUI SU TITULO
//----------------------------------------------------------------------------------------------------
)
sendinput {Up}
return

::nombregithub::Henry12346

;----------------------------------------------------------------------------------------------------
; FUNCIONES
;----------------------------------------------------------------------------------------------------

ToolTipFont(Options := "", Name := "", hwnd := "") 
{
    static hfont := 0
    if (hwnd = "")
        hfont := Options="Default" ? 0 : _TTG("Font", Options, Name), _TTHook()
    else
        DllCall("SendMessage", "ptr", hwnd, "uint", 0x30, "ptr", hfont, "ptr", 0)
}
 
ToolTipColor(Background := "", Text := "", hwnd := "") 
{
    static bc := "", tc := ""
    if (hwnd = "") {
        if (Background != "")
            bc := Background="Default" ? "" : _TTG("Color", Background)
        if (Text != "")
            tc := Text="Default" ? "" : _TTG("Color", Text)
        _TTHook()
    }
    else {
        VarSetCapacity(empty, 2, 0)
        DllCall("UxTheme.dll\SetWindowTheme", "ptr", hwnd, "ptr", 0
            , "ptr", (bc != "" && tc != "") ? &empty : 0)
        if (bc != "")
            DllCall("SendMessage", "ptr", hwnd, "uint", 1043, "ptr", bc, "ptr", 0)
        if (tc != "")
            DllCall("SendMessage", "ptr", hwnd, "uint", 1044, "ptr", tc, "ptr", 0)
    }
}
 
_TTHook() 
{
    static hook := 0
    if !hook
        hook := DllCall("SetWindowsHookExW", "int", 4
            , "ptr", RegisterCallback("_TTWndProc"), "ptr", 0
            , "uint", DllCall("GetCurrentThreadId"), "ptr")
}
 
_TTWndProc(nCode, _wp, _lp) 
{
    Critical 999
   ;lParam  := NumGet(_lp+0*A_PtrSize)
   ;wParam  := NumGet(_lp+1*A_PtrSize)
    uMsg    := NumGet(_lp+2*A_PtrSize, "uint")
    hwnd    := NumGet(_lp+3*A_PtrSize)
    if (nCode >= 0 && (uMsg = 1081 || uMsg = 1036)) {
        _hack_ = ahk_id %hwnd%
        WinGetClass wclass, %_hack_%
        if (wclass = "tooltips_class32") {
            ToolTipColor(,, hwnd)
            ToolTipFont(,, hwnd)
        }
    }
    return DllCall("CallNextHookEx", "ptr", 0, "int", nCode, "ptr", _wp, "ptr", _lp, "ptr")
}
 
_TTG(Cmd, Arg1, Arg2 := "") {
    static htext := 0, hgui := 0
    if !htext {
        Gui _TTG: Add, Text, +hwndhtext
        Gui _TTG: +hwndhgui +0x40000000
    }
    Gui _TTG: %Cmd%, %Arg1%, %Arg2%
    if (Cmd = "Font") {
        GuiControl _TTG: Font, %htext%
        SendMessage 0x31, 0, 0,, ahk_id %htext%
        return ErrorLevel
    }
    if (Cmd = "Color") {
        hdc := DllCall("GetDC", "ptr", htext, "ptr")
        SendMessage 0x138, hdc, htext,, ahk_id %hgui%
        clr := DllCall("GetBkColor", "ptr", hdc, "uint")
        DllCall("ReleaseDC", "ptr", htext, "ptr", hdc)
        return clr
    }
}

convertMinutes(numero)
{
    return numero*60*1000
}
convertHours(numero)
{
    return numero*60*60*1000
}

;----------------------------------------------------------------------------------------------------
; PAD NUMERICO
;----------------------------------------------------------------------------------------------------
!u:: sendinput {7}
!i:: sendinput {8}
!o:: sendinput {9}
!j:: sendinput {4}
!k:: sendinput {5}
!l:: sendinput {6}
!m:: sendinput {1}
!,:: sendinput {2}
!.:: sendinput {3}
!space::sendinput {0}
;----------------------------------------------------------------------------------------------------
; GUARDADO DEL SCRIPT
;----------------------------------------------------------------------------------------------------
Pause:: 
send {ctrl down}s{ctrl up}
sleep 0
reload C:\Users\Henry\Documents\AutoHotkey.ahk
return
;----------------------------------------------------------------------------------------------------
; CAPA ALT
;----------------------------------------------------------------------------------------------------
!a:: send {Home}
!g:: send {End}
!s:: send {Left}
!f:: send {Right}
!e:: send {Up}
!d:: send {Down}
!w:: send {BackSpace}
!r:: send {Delete}
!p:: sendinput {NumpadSub}
!;:: sendinput {NumpadAdd}
!h:: sendinput {NumpadMult}
!n:: sendinput {=}
!/:: sendinput {\}
!q:: sendinput {@}
!CapsLock:: sendinput {Esc}
!c:: sendinput {CtrlDown}c{CtrlUp}
!v:: sendinput {CtrlDown}v{CtrlUp}
!x:: sendinput {CtrlDown}x{CtrlUp}
;----------------------------------------------------------------------------------------------------
; CAPA ALT GR
;----------------------------------------------------------------------------------------------------
<^>!k:: sendinput { { }
<^>!l:: sendinput {Shift down}]{Shift up}
<^>!j:: sendinput {^}{Space}
<^>!m:: sendinput {Shift down}5{Shift up}
<^>!p:: sendinput {_}
<^>!f:: sendinput {!}
<^>!g:: sendinput ¡{Left}{BS}{Right}
<^>!q:: sendinput ° ;{Left}{BS}{Right}
<^>!h:: sendinput {&}
<^>!s:: sendinput {(}
<^>!d:: sendinput {)}
<^>!w:: sendinput {#}
<^>!x:: sendinput {[}
<^>!c:: sendinput {]}
<^>!CapsLock:: sendinput {~}{Space}
<^>!r:: sendinput {|}

;----------------------------------------------------------------------------------------------------
; CAPA CAPSLOCK
;----------------------------------------------------------------------------------------------------
var:= false
CapsLock::
var:= not(var)
ToolTipFont("s20","Showcard Gothic")
ToolTipColor("White", "Red")

if (var)
{
    SetCapsLockState, on
    ToolTip, CAPSLOCK ON, 10, 10
    SetTimer, RemoveToolTip, 99999999999999999999
    return
}
else
{
    SetCapsLockState, off    
    ToolTip, CAPSLOCK OFF, 10, 10
    SetTimer, RemoveToolTip, 1000
    return
}
RemoveToolTip:
SetTimer, RemoveToolTip, off
ToolTip
return


Capslock & e:: 
if GetKeyState("Shift", "P")
{
    loop, 10
    {
        sendinput {Shift down}{up}{Shift up}
    }
}
else
{
    loop 10 
    {
        sendinput {Up}
    }
}
return

Capslock & d:: 
if GetKeyState("Shift", "P")
{
    loop, 10
    {
        sendinput {Shift down}{down}{Shift up}
    }
}
else
{
    loop 10 
    {
        sendinput {down}
    }
}
return

Capslock & s:: 
if GetKeyState("Shift", "P")
{
    loop, 10
    {
        sendinput {Shift down}{Left}{Shift up}
    }
}
else
{
    loop 10 
    {
        sendinput {Left}
    }
}
return

Capslock & f:: 
if GetKeyState("Shift", "P")
{
    loop, 10
    {
        sendinput {Shift down}{Right}{Shift up}
    }
}
else
{
    loop 10 
    {
        sendinput {Right}
    }
}
return

Capslock & w::
loop 10 
{
sendinput {BS}
}
return

Capslock & r::
loop 10 
{
sendinput {Delete}
}
return

Capslock & u:: sendinput {f1}
Capslock & i:: sendinput {f2}
Capslock & o:: sendinput {f3}
;Capslock & p:: sendinput {f4}
Capslock & j:: sendinput {f5}
Capslock & k:: sendinput {f6}
Capslock & l:: sendinput {f7}
CapsLock & `;:: sendinput {f8}
Capslock & m:: sendinput {f9}
Capslock & ,:: sendinput {f10}
Capslock & .:: sendinput {f11}
Capslock & /:: sendinput {f12}
Capslock & p:: 
if GetKeyState("Alt", "P")
    sendinput {Alt down}{f4}{Alt up}
else
    sendinput {f4}
return

f13::
WinGetActiveTitle, activewin
Clipboard =
SendInput, ^c
ClipWait
transtext := StrReplace(Clipboard, " ", "%20")
transurl := "https://translate.google.com/#view=home&op=translate&sl=en&tl=es&text=" . transtext
Run, % transurl

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

;----------------------------------------------------------------------------------------------------
; CAPA MULTIMEDIA
;----------------------------------------------------------------------------------------------------
;!Volume_Up:: send {WheelUp}
;!Volume_Down:: send {WheelDown}
;^Volume_Up:: send {WheelLeft}
;^Volume_Down:: send {WheelRight}
;----------------------------------------------------------------------------------------------------
; CONBINACION DE 3 TECLAS
;----------------------------------------------------------------------------------------------------
!^w:: send {ctrl down}{BackSpace}{ctrl up}
;!^r:: send {ctrl down}{NumpadDel}{ctrl up} 
!^s:: send {ctrl down}{Left}{ctrl up}
!^f:: send {ctrl down}{Right}{ctrl up}
; seleccionar texto
!+s:: send {ShiftDown}{CtrlDown}{Left}{CtrlUp}{ShiftUp}
!+f:: send {ShiftDown}{CtrlDown}{Right}{CtrlUp}{ShiftUp}
!+e:: send {ShiftDown}{Up}{ShiftUp}
!+d:: send {ShiftDown}{Down}{ShiftUp}
!+a:: send {ShiftDown}{Home}{ShiftUp}
!+g:: send {ShiftDown}{End}{ShiftUp}
; seleccionar lineas y partes
<^>!+e:: send {ShiftDown}{AltDown}{Up}{AltUp}{ShiftUp}
<^>!+d:: send {ShiftDown}{AltDown}{Down}{AltUp}{ShiftUp}
<^>!+s:: send {ShiftDown}{AltDown}{Left}{AltUp}{ShiftUp}
<^>!+f:: send {ShiftDown}{AltDown}{Right}{altup{ShiftUp}
<+>+f:: send {ShiftDown}{Right}{ShiftUp}
<+>+s:: send {ShiftDown}{Left}{ShiftUp}
<+>+e:: send {ShiftDown}{Up}{ShiftUp}
<+>+d:: send {ShiftDown}{Down}{ShiftUp}
return
;----------------------------------------------------------------------------------------------------
; EXTRAS
;----------------------------------------------------------------------------------------------------
ScrollLock:: WinSet, AlwaysOnTop, , A
return

f1:: 
VarSetCapacity(powerstatus, 4)
success := DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus)

acLineStatus:=ReadInteger(&powerstatus,0,1,false)
batteryLifePercent:=ReadInteger(&powerstatus,2,1,false)
FormatTime, time, A_now, dddd d-MMMM(MM)-yy `nhh:mm tt


if (acLineStatus)
    ToolTipColor("Green", "White")
else
    ToolTipColor("White", "Black")

output=Bateria: %batteryLifePercent%`%  `n%time%
ToolTipFont("s20","Times New Roman")
ToolTip, %output%, 10, 10
SetTimer, RemoveToolTip, 15000

ReadInteger( p_address, p_offset, p_size, p_hex=true )
{
  value = 0
  old_FormatInteger := a_FormatInteger
  if ( p_hex )
    SetFormat, integer, hex
  else
    SetFormat, integer, dec
  loop, %p_size%
    value := value+( *( ( p_address+p_offset )+( a_Index-1 ) ) << ( 8* ( a_Index-1 ) ) )
  SetFormat, integer, %old_FormatInteger%
  return, value
}
return


~LWin::
    KeyWait, LWin			; wait for LWin to be released
    KeyWait, LWin, D T0.1	; and pressed again within 0.1 seconds
    if ErrorLevel 			; timed-out (only a single press)
        Send {}
    Else
        sendinput {LWinDown}{g}{LWinUp}
Return


::lorem ipsum:: Lorem ipsum dolor sit amet consectetur, adipisicing elit. Libero harum natus ducimus cumque aliquid temporibus, fugiat quia quae maiores quam exercitationem minima aspernatur ut aperiam porro. Asperiores cupiditate vel provident?
::link meet:: https://meet.google.com/hzs-umxo-mad

;----------------------------------------------------------------------------------------------------
; SECCION PRUEBA
;----------------------------------------------------------------------------------------------------

f4::
if (stage = 2) 
    stage = 0
stage += 1 
if (stage = 1)
{
    ToolTipFont("s20","Showcard Gothic")
    ToolTipColor("White", "BLUE")
    ToolTip , MODO 1, 10, 10, 1

    ToolTipColor("Black", "gray")
    ToolTip , MODO 2, 115, 10, 2

    Sleep 300
    ToolTip ,,,, 1
    ToolTip ,,,, 2
    ToolTip ,,,, 3
}
else if (stage = 2)
{
    ToolTipFont("s20","Showcard Gothic")
    ToolTipColor("Black", "gray")
    ToolTip , MODO 1, 10, 10, 1

    ToolTipColor("White", "BLUE")
    ToolTip , MODO 2, 115, 10, 2

    Sleep 300
    ToolTip ,,,, 1
    ToolTip ,,,, 2
    ToolTip ,,,, 3
}
return

#If (stage = 2)
u:: sendinput {7} 
i:: sendinput {8}
o:: sendinput {9}
j:: sendinput {4}
k:: sendinput {5}
l:: sendinput {6}
m:: sendinput {1}
,:: sendinput {2}
.::
    KeyWait, .			; wait for z to be released
    KeyWait, ., D T0.07		; and pressed again within 0.2 seconds
    if ErrorLevel 			; timed-out (only a single press)
        sendinput {3}
    Else
        sendinput .
Return
space::sendinput {0}
p:: sendinput {NumpadSub}
`;:: sendinput {NumpadAdd}
h:: sendinput {NumpadMult}
n:: sendinput {=}
return
