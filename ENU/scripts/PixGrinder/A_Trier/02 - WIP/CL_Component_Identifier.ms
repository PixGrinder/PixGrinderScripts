-- CL_Component_Identifier --
-- v 0.3 --

clearListener()

myFile = @"d:\DataH160_ForScripts_2Lines.txt"

fl = openFile myFile

myTable = #()
nbLine = 0


-- Find file end character number --
	seek fl #eof
	myEnd = filePos fl
	seek fl 0


-- Find nb of lines --

seek fl 0
while (filePos fl) < myEnd do
(
	skipToString fl ";"
	skipToString fl ";"
	nbLine = nbLine + 1
)
nbLine = nbLine - 3




-- skip line 0 --
seek fl 0
readLine fl

-- Functions -- 

	fn ReadWord = 
	(
		-- read word 1 --
		tmpStart = filePos fl
		skipToString fl ";"
		tmpEnd = (filePos fl)
		seek fl tmpStart
		x1 = (readChars fl (tmpEnd - tmpStart))
		skipToString fl ";"

		-- read word 2 --
		tmpStart = filePos fl
		skipToString fl ";"
		tmpEnd = (filePos fl) - 1
		seek fl tmpStart
		readChar fl
		x2 = (readChars fl (tmpEnd - tmpStart))
		skipToString fl ";"
		readLine fl
		return #(x1,x2)
	)



-- Read characters between separator";" --
	
	for i = 1 to (nbLine) do append myTable (ReadWord())


clearListener()
--for Yo = 1 to (nbLine) do (format "%    |    %" myTable[Yo][1] myTable[Yo][2])
myTable.count

close fl



-- print nbLine

------------------


/*
close fl

readLine fl

readChar fl

filePos fl



*/

--close WKfile