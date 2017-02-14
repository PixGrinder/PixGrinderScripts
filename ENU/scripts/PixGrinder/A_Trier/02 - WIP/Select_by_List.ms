

(
	clearListener()
	pda=#()
	compOk = #()
	i = 0
	x1 = openFile "d:\\myList.txt"
	myValue = 0
	seek x1 #eof
	myMax = filePos x1
	seek x1 0
	myDiff = #()


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
		for obj in objects do if pda[i] == obj.name do append compOk obj
	)

	
---------------------------------------




-- myNames = tableau de strings des noms de composants présents dans le fichier texte ET dans la scene 3D

	myNames = for obj in compOk collect obj.name   

---------------------------------------




-- myDiff = recherche des noms de composants absents de la scène 3D

	for obj in pda do 
	(
		if (finditem myNames obj == 0) do append myDiff obj
	)

---------------------------------------
	


-- Affichage dans le listener des noms de composants manquants dans la scene 3D

	print ("Missing : ")
	for ola in myDiff do print ola

---------------------------------------

	print myDiff.count  -- Affichage du nombre de composants manquants
	select compOk  -- selection des composants présents
	close x1 -- fermeture du fichier texte
)


