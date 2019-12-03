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


-- Functions -- 

	fn ReadWord = 
	(
		tmpStart = filePos fl
		skipToString fl ";"
		tmpEnd = filePos fl
		seek fl tmpStart
		x1 = (readChars fl (tmpEnd - tmpStart - 1))
		skipToString fl ";"
		tmpStart = filePos fl
		skipToString fl ";"
		tmpEnd = filePos fl
		seek fl tmpStart
		x2 = (readChars fl (tmpEnd - tmpStart - 1))
		skipToString fl ";"
		return #(x1,x2)
	)



-- Read characters between separator";" --
	
	append myTable (ReadWord())




------------------



/*
readLine fl

readChar fl

filePos fl

close fl

*/

--close WKfile