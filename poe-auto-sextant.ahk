sextant_position_x = 0
sextant_position_y = 0
compass_position_x = 0
compass_position_y = 0
watchstone_position_x = 0
watchstone_position_y = 0
bag_for_stored_compass_position_x = 0
bag_for_stored_compass_position_y = 0

F6::
    ; Change the value below here to limit how many times it will try to roll before giving up
    QuantityToRoll := 10
    ; Change the value below here if you want to look for a different sextant modifier

    SearchString:="aaa|bbb|ccc"

    Send, {Shift down}
    Sleep, 200
    
    Loop, %QuantityToRoll%
    {
        clipboard:=""
        Send ^c
        Clipwait, 0
        if ErrorLevel
        {
            GetKeyState, state, Shift
            if(state = "D")
                Send, {Shift up}
            break
        }
        ; MsgBox %clipboard%

        clipboard := clipboard
        watchstoneDetails := clipboard
        clipboard := ""

        hasRoll := 0
        
        Loop, parse, SearchString, |
            If(InStr(watchstoneDetails, A_LoopField, 0))
            {
                hasRoll:= 1
            }
        }
        
        If(hasRoll == 1)
        {
            Send, {Shift up}
            Send, {Shift down}
            Send, {Shift up}
            storeWithCompass()
            Send, {Shift down}
            MouseClick, right, sextant_position_x, sextant_position_y
            MouseClick, left, watchstone_position_x, watchstone_position_x
            Sleep, 100
        }   
        If(hasRoll == 0 )
        {
            ; MsgBox Does not have roll
            OutputDebug, %A_Now%: Clicking
            Send, {Click}
            Sleep, 100

        }
    }

    GetKeyState, state, Shift
    if(state = "D")
        Send, {Shift up}

    return

storeWithCompass(){
    MouseClick, right, compass_position_x, compass_position_y
    MouseClick, left, watchstone_position_x, watchstone_position_y
    MouseClick, left, bag_for_stored_compass_position_x, bag_for_stored_compass_position_x
    Send, {Shift down}
    MouseClick, left, bag_for_stored_compass_position_x, bag_for_stored_compass_position_x
    Send, {Shift up}
}