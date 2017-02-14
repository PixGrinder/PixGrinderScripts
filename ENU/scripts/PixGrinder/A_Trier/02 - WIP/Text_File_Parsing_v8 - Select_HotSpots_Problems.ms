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
	myPb = #()


-- pda = tableau de strings des noms présents dans le fichier "test.txt"

	while eof x1 != true do
	(
		--seek x1 i
		myString = readLine x1
		append pda myString
		-- i = i+myString.count
	)
	print pda.count

---------------------------------------
	

	
-- compOk = tableau contenant tous les noeuds 3D présents dans la scène et qui correspondent aux noms de la liste "test.txt"

	for i = 1 to pda.count do
	(
		for obj in objects do if pda[i] == obj.name do appendifunique compOk obj
	)

	
---------------------------------------


myPb = for obj in compOk where custAttributes.count obj == 0 collect obj

clearSelection()
select myPb

)


