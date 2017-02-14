pda=#()
x1 = openFile "d:\\test.txt"
seek x1 #eof 
filePos x1
append pda (readLine x1)
--------------------------



(
	clearListener()
	pda=#()
	compOk = #()
	i = 0
	x1 = openFile "d:\\test.txt"
	myValue = 0
	seek x1 #eof
	myMax = filePos x1
	seek x1 0
	while eof x1 != true do
	(
		--seek x1 i
		myString = readLine x1
		append pda myString
		-- i = i+myString.count
	)
	print pda.count
	
	for i = 1 to pda.count do
	(
		for obj in objects do if pda[i] == obj.name then append compOk obj
	)

	
	if compOk.count == pda.count then messageBox("All Components found !") else messageBox("Some Components are Missing !!!")

	
)


