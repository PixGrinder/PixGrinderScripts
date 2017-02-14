pda_ref = $.material.reflectionmap



for i = 1 to scenematerials.count do ( 
	if (classOf scenematerials[i]== standard ) and (scenematerials[i].reflectionmap != pda_ref)  then (scenematerials[i]=pda_ref)
	
	
	)
	
for i = 1 to scenematerials.count do ( 
	
	if (classOf scenematerials[i]== Multimaterial ) do
		for j = 1 to scenematerials[i].numsubs do (
			if scenematerials[i][j].reflectionmap != pda_ref  then (scenematerials[i][j].reflectionmap=pda_ref)
		)
	
	)
