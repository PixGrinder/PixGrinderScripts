

(
	
	
	pda_p = #() 	-- Objects with no parents
	pda_c = #() 	--  Objects with children
	pda_o = #() 	--  Objects top of scenegraph with no children (orphaned )
	pda_nb = 5 	-- Max number of orphaned objects to export

	for obj in objects do
	(
		if obj.parent == undefined do append pda_p obj
	)


	for i = 1 to pda_p.count do
	(
		if ( pda_p[i].children.count != 0 ) then ( append pda_c pda_p[i] ) else (append pda_o pda_p[i] )
	)


	for i = 1 to pda_c.count do
	(
		select pda_c[i]
		for p in selection do
		(
			if p.children != undefined do
			(
				selectmore p.children
			)
		)
		savenodes selection ("c:\\temp\\" + pda_c[i].name + ".max")
	)

	

)




------------------------------------

(

	if $ == undefined then messagebox("Please, select one object.") else
	(
	
		while $.parent != undefined do select $.parent

		for p in selection do
		(
			if p.children != undefined do
			(
				selectmore p.children
			)
		)
	)
)