

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
		for obj in objects do if pda[i] == obj.name do append compOk obj.name
	)

	
-- 	myNames = for obj in compOk collect obj.name
-- 	myDiff = for obj in pda where finditem myNames obj == false collect obj
	for obj in pda do 
	(
		if (finditem compOk obj == false) do append myDiff obj
	)
	
	for ola in myDiff do (print ("missing : " + (ola as string)))
	
-- 	if compOk.count == pda.count then messageBox("All Components found !") else messageBox((pda.count - compOk.count) as string + " Components are Missing")
	
	print "youpi"
		

-- 	for obj in myNames do print obj
-- 	print myNames.count

	
)

