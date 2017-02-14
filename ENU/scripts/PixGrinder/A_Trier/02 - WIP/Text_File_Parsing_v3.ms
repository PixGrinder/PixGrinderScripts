

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
	myDiff = #()
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
		for obj in objects do if pda[i] == obj.name do append compOk obj
	)

	myNames = for obj in compOk collect obj.name

	for obj in pda do 
	(
		if (finditem myNames obj == 0) do append myDiff obj
	)
	
	print ("Missing : ")
	for ola in myDiff do print ola
	print myDiff.count
	select compOk
	
)


