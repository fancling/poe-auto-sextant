F6::
    ; Change the value below here to limit how many times it will try to roll before giving up
    QuantityToRoll := 10
    ; Change the value below here if you want to look for a different sextant modifier
    SearchString:="for each Poison on them"

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
        ; If(InStr(watchstoneDetails, "for each Poison on them", 0))
        If(InStr(watchstoneDetails, SearchString, 0))
        {
            hasRoll:= 1
        }
        
        If(hasRoll == 1)
        {
            Send, {Shift up}
            Send, {Shift down}
            Send, {Shift up}
            ; MsgBox Craft found -- stop rolling
            break
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