(
	clearListener()
	pda = #()
	Comps = #()
	
	-- selection des géometries visibles
	for obj in geometry do
	(
		if obj.ishidden == false do appendifunique pda obj
	)
	
	-- selection des groupes visibles
	for hp in helpers do
	(
		if hp.ishidden == false do appendifunique pda hp
	)
	
	-- tri des composants dans les objets visibles
	for obj in pda do
	(
		if matchpattern obj.name pattern:"ATA_??-??_*" == true do append Comps obj
	)
	
	-- selectionne 1er composant si la selection courante n'en est pas un
	if matchpattern selection[1].name pattern:"ATA_??-??_*" == false then
	(
		select  Comps[1]
	) else (
		
		for i = 1 to Comps.count do 
		(
			
		)
	
)

