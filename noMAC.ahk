; SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
; #Warn  ; Enable warnings to assist with detecting common errors.
; AutoTrim,on
#SingleInstance force

makeCopy := false
initDir := ""
newDir := ""

check(dest)
{
	SplitPath, dest,,dir
	IfNotExist, %dir%
		FileCreateDir, %dir%
}

Loop %0%
{
    GivenPath := %A_Index%  ; Retrieve the next command line parameter.
	if(GivenPath="-nodel" || GivenPath="-move"){
		makeCopy := true
;		MsgBox, % GivenPath
		continue
	}
	if(initDir=""){
		Gosub, getDir
	}
    Loop %GivenPath%,1
	{
		Loop,% (D:=InStr(FileExist(A_LoopFileLongPath), "D")) ? A_LoopFileLongPath "\*.*" : A_LoopFileLongPath ,% D ? 1 : 0, % D ? 1 : 0
		{
;			MsgBox, % A_LoopFileName
			if ((A_LoopFileName = ".DS_Store" || RegExMatch(A_LoopFileName,"i)^thumbs\.db") || RegExMatch(A_LoopFileName,"^\._")) && (!InStr(FileExist(A_LoopFileLongPath), "D")))
			{
				if(makeCopy=true){
					StringReplace, restDir,A_LoopFileLongPath,%initDir%
					dest := initDir . "\" . newDir . restDir
					check(dest)
;					MsgBox, % initDir . "`n" . restDir . "`n" . A_LoopFileLongPath
;					MsgBox, % "Moving`n`n" . A_LoopFileLongPath . "`n`nto`n`n" . dest
					FileMove, %A_LoopFileLongPath%,%initDir%\%newDir%%restDir%
					continue
				}else{
;					MsgBox, Deleting %A_LoopFileLongPath%
					FileSetAttrib, -RH,% A_LoopFileLongPath
					FileDelete, % A_LoopFileLongPath
					continue
				}
			}
			if ((A_LoopFileName = "__MACOSX" || RegExMatch(A_LoopFileName,"i)^\.Trash")) && (InStr(FileExist(A_LoopFileLongPath), "D")))
			{
				if(makeCopy=true){
					StringReplace, restDir,A_LoopFileLongPath,%initDir%
					dest := initDir . "\" . newDir . restDir
					check(dest)
;					MsgBox, % initDir . "`n" . restDir . "`n" . A_LoopFileLongPath
;					MsgBox, % "Moving`n`n" . A_LoopFileLongPath . "`n`nto`n`n" . dest
					FileMoveDir, %A_LoopFileLongPath%,%initDir%\%newDir%%restDir%,2
					continue
				}else{
;					MsgBox, Deleting %A_LoopFileLongPath%
					FileRemoveDir, %A_LoopFileLongPath%,1
					continue
				}
			}
		}
	}
}
ExitApp

getDir:
;	MsgBox, % GivenPath
	IfExist, % GivenPath
	{
		StringLen, len,GivenPath
		StringGetPos, pos,GivenPath,\,r
;		EnvSub, len,%pos%
		len -= pos
		StringTrimRight, initDir,GivenPath,%len%
;		MsgBox, Original Path %GivenPath%`n`nNew Path %initDir%
	getNewDir:
		Random, rnd,1,100
		newDir := "noMac_moved_files_" . SubStr("00" . rnd, -2)
		IfExist, %initDir%\%newDir%
			Goto, getNewDir
;		MsgBox, %initDir%\%newDir%
		FileCreateDir, %initDir%\%newDir%
	}
Return
