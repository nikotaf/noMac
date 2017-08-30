; SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
; #Warn  ; Enable warnings to assist with detecting common errors.
AutoTrim,on
#SingleInstance force
#Include %A_ScriptDir%/functions.ahk

makeCopy := false ; use for -nodel and -move flags
initDir := "" ; holds the base dir
newDir := "" ; holds the extra folder in case we move files

Loop %0% ; iterates through command line arguments
{
    GivenPath := %A_Index%  ; Retrieve the next command line parameter
	if(GivenPath="-nodel" || GivenPath="-move"){ ; checking for flags
		makeCopy := true ; and setting option
		continue ; moving on to next argument
	}
	if(initDir=""){ ; first time check only
		Gosub, getDir ; get the base dir
	}
	Gosub, checkPath ; moved code to a label for future gui calls
}
Return ; protecting labels below from executing
#Include %A_ScriptDir%/labels.ahk
