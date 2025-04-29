;----------------------------------------------------------------------------------------------------
; CAPA APPSKEY
;----------------------------------------------------------------------------------------------------
Appskey & r::send {Click Right}
Appskey & w::send {Click}
;Appskey & q::send {WheelUp}
;Appskey & a::send {WheelDown}

#SingleInstance force
#Persistent

currentMonitor := 1

Appskey & g::  ; Ctrl + Alt + T
SysGet, monitorCount, MonitorCount

if (monitorCount < 1)
    return

if (currentMonitor > monitorCount)
    currentMonitor := 1

; obtener dimensiones del monitor
SysGet, mon, Monitor, %currentMonitor%

; monLeft := monLeft
; monTop := monTop
; monRight := monRight
; monBottom := monBottom

centerX := (monLeft + monRight) // 2
centerY := (monTop + monBottom) // 2

MouseMove, %centerX%, %centerY%, 0

currentMonitor++
return



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

ScrollLock:: WinSet, AlwaysOnTop, , A
return


GetMonitorArea(winID, ByRef left, ByRef top, ByRef right, ByRef bottom) {
    WinGetPos, X, Y, W, H, ahk_id %winID%
    SysGet, monitorCount, MonitorCount
    Loop, %monitorCount% {
        SysGet, mon, Monitor, %A_Index%
        if (X >= monLeft and X < monRight and Y >= monTop and Y < monBottom) {
            left := monLeft
            top := monTop
            right := monRight
            bottom := monBottom
            return
        }
    }
}

GetWindowFrame(winID, ByRef borderX, ByRef borderY) {
    WinGetPos, x1, y1, w1, h1, ahk_id %winID%
    WinGet, style, Style, ahk_id %winID%
    ; WS_THICKFRAME = 0x40000 → tiene borde redimensionable
    if (style & 0x40000) {
        borderX := 8  ; píxeles comunes de borde horizontal
        borderY := 8  ; píxeles comunes de borde vertical
    } else {
        borderX := 0
        borderY := 0
    }
}

ResizeWindow(winID, posX, posY, w, h) {
    GetWindowFrame(winID, borderX, borderY)
    WinMove, ahk_id %winID%, , posX - borderX, posY - borderY, w + (borderX * 2), h + (borderY * 2)
}

#!Down::
WinGet, winID, ID, A
GetMonitorArea(winID, left, top, right, bottom)
ResizeWindow(winID, left, top + (bottom - top)//2, right - left, (bottom - top)//2)
return

#!Up::
WinGet, winID, ID, A
GetMonitorArea(winID, left, top, right, bottom)
ResizeWindow(winID, left, top, right - left, (bottom - top)//2)
return

#!Left::
WinGet, winID, ID, A
GetMonitorArea(winID, left, top, right, bottom)
ResizeWindow(winID, left, top, (right - left)//2, bottom - top)
return

#!Right::
WinGet, winID, ID, A
GetMonitorArea(winID, left, top, right, bottom)
ResizeWindow(winID, left + (right - left)//2, top, (right - left)//2, bottom - top)
return

