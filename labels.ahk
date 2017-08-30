getDir: ; creates a folder to base dir to hold files and folders of interest
	IfExist, % GivenPath ; GivenPath is set each time within the loop
	{
		StringLen, len,GivenPath ; get GivenPath length
		StringGetPos, pos,GivenPath,\,r ; get last \ position
		len -= pos ; and subtract it from length
		StringTrimRight, initDir,GivenPath,%len% ; now we can have the base dir
	getNewDir:
		Random, rnd,1,100 ; we choose to have 1 to 100 random folders
		newDir := "noMac_moved_files_" . SubStr("00" . rnd, -2) ; and form its file name
		IfExist, %initDir%\%newDir% ; if the folder exists
			Goto, getNewDir ; form another file name
		FileCreateDir, %initDir%\%newDir% ; finaly create the folder
	}
Return

checkPath: ; checking GivenPath for folder/files of interest
    Loop %GivenPath%,1
	{
		Loop,% (D:=InStr(FileExist(A_LoopFileLongPath), "D")) ? A_LoopFileLongPath "\*.*" : A_LoopFileLongPath ,% D ? 1 : 0, % D ? 1 : 0
		{
			if ((A_LoopFileName = ".DS_Store" || RegExMatch(A_LoopFileName,"i)^thumbs\.db") || RegExMatch(A_LoopFileName,"^\._")) && (!InStr(FileExist(A_LoopFileLongPath), "D")))
			{
				if(makeCopy=true){
					StringReplace, restDir,A_LoopFileLongPath,%initDir%
					dest := initDir . "\" . newDir . restDir
					check(dest)
					FileMove, %A_LoopFileLongPath%,%initDir%\%newDir%%restDir%
					continue
				}else{
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
					FileMoveDir, %A_LoopFileLongPath%,%initDir%\%newDir%%restDir%,2
					continue
				}else{
					FileRemoveDir, %A_LoopFileLongPath%,1
					continue
				}
			}
		}
	}
Return
