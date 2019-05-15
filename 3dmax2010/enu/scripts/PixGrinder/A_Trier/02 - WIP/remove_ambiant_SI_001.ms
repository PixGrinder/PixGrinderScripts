
for i =1 to SceneMaterials.count do 
	(
	
		if classof scenematerials[i] == Standardmaterial do 
		(
			scenematerials[i].ambientMap = undefined 
			scenematerials[i].selfillumMap = undefined 
			scenematerials[i].adTextureLock = on
			
			if classof scenematerials[i] == Multimaterial do 
			(
				for j = 1 to scenematerials[i].count do 
				(
				scenematerials[i][j].ambientMap = undefined 
				scenematerials[i][j].selfillumMap = undefined 
				scenematerials[i][j].adTextureLock = on
				)
			)
		)
	)
	
for obj in objects do
(
	if obj.material != undefined do 
	(
		if classof obj.material == Standardmaterial do 
		(
			obj.material.ambientMap = undefined 
			obj.material.selfillumMap = undefined
			obj.material.reflectionMap = undefined
			obj.material.adTextureLock = on
		)
		
		if classof obj.material == Multimaterial do 
		(
			for j = 1 to obj.material.count do 
			(
			obj.material[j].ambientMap = undefined 
			obj.material[j].selfillumMap = undefined 
			obj.material[j].reflectionMap = undefined
			obj.material[j].adTextureLock = on
			)
		)
	)
)






-- Brouillon
--------------

pda_x=meditmaterials[1][3].diffuseMap.filename

meditmaterials[1] = scenematerials[9]

meditmaterials[1].reflectionmap


pda_x = $.material.diffuseMap.filename

pda_y = filenamefrompath pda_x

pda_y.count


pda_z = replace pda_y (pda_y.count-3) 4 ""