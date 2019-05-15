

---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Select_by_List --
-- Select_by_List.ms --
-- Selects all components in scene from a .txt list of names --
-- Outputs missing names from list in Listener --

-- Coming improvements : UI to select text file --

-- V 0.1 --

---------------------------------------------------------------------

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
	format "%%\r" "Lines in text file : " pda.count

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

	format ("Missing : \r")
	for ola in myDiff do format "%\r" ola

---------------------------------------

	format "%\r" myDiff.count  -- Affichage du nombre de composants manquants
	select compOk  -- selection des composants présents
	close x1 -- fermeture du fichier texte
)


