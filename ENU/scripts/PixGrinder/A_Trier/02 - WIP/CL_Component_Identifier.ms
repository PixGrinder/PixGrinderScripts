-- CL_Component_Identifier --
-- v 0.1 --

clearListener()

myFile = @"d:\DataH160_ForScripts_2Lines.txt"

fl = openFile myFile

myTable = #()



-- Find file end character number --
	seek fl #eof
	myEnd = filePos fl
	seek fl 0



-- Read characters between separator";" --
	tmpStart = filePos fl
	try (skipToString fl ";") catch (seek fl #eof)
	tmpEnd = filePos fl
	seek fl tmpStart
	readChars fl (tmpEnd - tmpStart - 1)
	try (skipToString fl ";") catch (seek fl #eof)

------------------



/*
readLine fl

readChar fl

filePos fl

*/

--close WKfile