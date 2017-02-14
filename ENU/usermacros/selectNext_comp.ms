(
	if pda == undefined do pda = for obj in objects where obj.material.name == "CAO_Jaune" collect obj
		

	x1 = finditem pda selection[1]
	if x1 != 0 do select pda[(x1+1)]
)