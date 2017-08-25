; SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
; #Warn  ; Enable warnings to assist with detecting common errors.
; AutoTrim,on
#SingleInstance force

Loop %0%
{
    GivenPath := %A_Index%  ; Retrieve the next command line parameter.
    Loop %GivenPath%,1
	{
		Loop,% (D:=InStr(FileExist(A_LoopFileLongPath), "D")) ? A_LoopFileLongPath "\*.*" : A_LoopFileLongPath ,% D ? 1 : 0, % D ? 1 : 0
		{
;			MsgBox, % A_LoopFileName
			if ((A_LoopFileName = ".DS_Store" || RegExMatch(A_LoopFileName,"i)^thumbs\.db") || RegExMatch(A_LoopFileName,"^\._")) && (!InStr(FileExist(A_LoopFileLongPath), "D")))
			{
;				MsgBox, Delete %A_LoopFileLongPath%
				FileSetAttrib, -RH,% A_LoopFileLongPath
				FileDelete, % A_LoopFileLongPath
			}
			if ((A_LoopFileName = "__MACOSX" || RegExMatch(A_LoopFileName,"i)^\.Trashes")) && (InStr(FileExist(A_LoopFileLongPath), "D")))
			{
;				MsgBox, Delete %A_LoopFileLongPath%
				FileRemoveDir, %A_LoopFileLongPath%,1
			}
		}
	}
}