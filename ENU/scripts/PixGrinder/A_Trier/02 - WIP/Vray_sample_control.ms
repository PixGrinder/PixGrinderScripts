(
	pda=getClassInstances VRayMtl

	for i = 1 to pda.count do 
	(
		-- format "name:%, pos:%\n" pda[i].name pda[i].reflection_subdivs
		pda[i].reflection_subdivs = 8
		pda[i].reflection_useInterpolation = false
		pda[i].hilight_glossiness = 0.46
		-- pda[i].reflection_glossiness = 0.46
		pda[i].reflection_lockGlossiness = false
		pda[i].texmap_reflection_on = false
		pda[i].reflection = [20,20,20]
		-- pda[i].texmap_bump_on =false
		-- pda[i]
	)

)




-- Brouillon
----------------

meditMaterials[1].reflection_lockGlossiness = false
meditMaterials[1].texmap_reflection_on  = false
meditMaterials[1].reflection = [50,50,50]


show pda[1]