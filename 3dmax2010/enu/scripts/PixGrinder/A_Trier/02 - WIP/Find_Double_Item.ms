-- Find double components

(
	clearListener()
	max select none
	myPattern = "ATA_??-??_*" -- Texte à rechercher !
	pda = #()
	pda_final = #()
	for obj in objects do 
	(
		if superclassof obj != camera and matchpattern obj.name pattern:myPattern == true do appendifunique pda obj
	)
	
	for i = 1 to pda.count do print pda[i].name
	
	for i = 1 to pda.count do
	(
		for j = 2 to pda.count do
		(
			if pda[i].name == pda[j].name and distance pda[i].min pda[j].min != 0.0 do appendifunique pda_final pda[j]
		)
	)
	
	select pda_final
)

