
(
	
	pda = getCurrentSelection()
	
	for i = 1 to pda.count do
	(
		x = random 1 255
		y = random 1 255
		z = random 1 255
		
		pda_name = "Color"+(i as string)
		
		pda[i].material = StandardMaterial () 
		pda[i].material.diffuse = color x y z
		pda[i].material.selfIllumAmount = 100
		pda[i].material.name = pda_name
	)

	
)
