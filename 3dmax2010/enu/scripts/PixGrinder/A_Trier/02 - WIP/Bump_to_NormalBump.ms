


for i = 1 to scenematerials.count do ( 
	if (classOf scenematerials[i]== standard ) and (scenematerials[i].bumpmap != undefined)   and (scenematerials[i].bumpmap != Normal_Bump)  then (
		pda_bmp = scenematerials[i].bumpmap
		scenematerials[i].bumpmap=Normal_Bump ()
		scenematerials[i].bumpmap.Normal_map = pda_bmp
		)
	)
	
for i = 1 to scenematerials.count do ( 
		if (classOf scenematerials[i]== MultiMaterial ) do (
			for j = 1 to scenematerials[i].numsubs do (
				if (classOf scenematerials[i][j]== standard ) and (scenematerials[i][j].bumpmap != undefined) and (scenematerials[i][j].bumpmap != Normal_Bump) then (
				pda_bmp = scenematerials[i][j].bumpmap
				scenematerials[i][j].bumpmap=Normal_Bump ()
				scenematerials[i][j].bumpmap.Normal_map = pda_bmp
			)
		)
	)
)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
-- 	for i = 1 to scenematerials.count do ( 
-- 	if (classOf scenematerials[i]== Multimaterial ) do
-- 		for j = 1 to scenematerials[i].numsubs do (
-- 			if scenematerials[i][j].reflectionmap != pda_ref  then (scenematerials[i][j].reflectionmap=pda_ref)
-- 		)
-- 	
-- 	)


if meditMaterials[2].bumpmap != Normal_Bump do ( print "youpla") else do (print "râté")