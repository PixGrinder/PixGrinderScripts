(

	pda = #()
	cur = getcurrentselection()
	
	if cur.count == 0 then messagebox("Please, select one object.") else
	(
		select cur[1]
		while $.parent != undefined do select $.parent

		for p in selection do
		(
			if p.children != undefined do
			(
				selectmore p.children
			)
		)
	)
	
	-- pda = getcurrentselection()
	

	
	
)


-------------------------------------
-- Brouillon
---------------------------------------
(
	select geometry
	pda = getcurrentselection()
	pda=pda[1]
	pdamin = pda.min    -- axis = pdamin.x     or     pdamin.y    or     pdamin.z
	pdamax = pda.max   -- useless
	pdacenter = pda.pivot
	
	myAxis = [pda.min.x, pda.center.y, pda.center.z]
	
	--dummy name:"Symetry_Axis" boxsize:(($.max-$.min)/4) pos:myAxis
	grid name:"Symetry_Axis" length:(($.max.x - $.min.x)*2) width:(($.max.y - $.min.y)*2)
	$Symetry_Axis.rotation = eulerAngles 0 -90 0
	$Symetry_Axis.position = myAxis
	pdadist = abs(myAxis[1] - pda.center.x)

	maxOps.CloneNodes pda newnodes:&pdaclone
	pdaclone = pdaclone[1]
	pdaclone.scale = [-1,-1,-1]
	--addModifier pdaclone (Mirror() )
	pdaclone.position = [(myAxis[1]-pdadist), pda.position.y, pda.position.z]
	
	resetXform pdaclone
	
	
)