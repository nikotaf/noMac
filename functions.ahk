check(dest) ; function to check if path exists
{
	SplitPath, dest,,dir ; mainly interested for the folder
	IfNotExist, %dir% ; if it does not exist
	{
		FileCreateDir, %dir% ; create it
		Return, true ; and return success
	}
	Return, false ; otherwise return failure creating existing folder
}
