-- Trouver les doublons dans une scene 3D
(
	clearListener()
	max select none
	pda = #()
	for obj in objects do
	(
		x1 = getNodeByName obj.name exact:true ignoreCase:false all:true
		if x1.count >1 do 
		(
			for bla in x1 do append pda bla
		)
		
	)
	max select none
	print pda.count
	for obj in pda do print obj.name -- added
	select pda
)