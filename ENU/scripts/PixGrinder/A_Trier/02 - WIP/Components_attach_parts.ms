

(
	clearListener()
	max select none
	myPattern = "ATA_??-??_*" -- Texte à rechercher !
	pda = #()
	pda_final = #()
	-- collection de tous les composants :
	for obj in objects do 
	(
		if superclassof obj != camera and matchpattern obj.name pattern:myPattern == true do appendifunique pda obj
	)
	
	for i = 1 to pda.count do
	(
		for j = 1 to pda.count do
		(
			if matchpattern pda[j].name pattern:(pda[i].name+"_0*") == true do 
			(
				appendifunique pda_final pda[j]
				appendifunique pda_final pda[i]
			)
		)
	)
	
	max select none
	max hide inv

	for obj in pda_final do obj.ishidden = false
	
)
