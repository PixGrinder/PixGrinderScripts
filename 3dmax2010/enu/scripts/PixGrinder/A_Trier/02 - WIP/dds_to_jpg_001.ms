
for i =1 to SceneMaterials.count do (
	
		if classof scenematerials[i] == Standardmaterial do 
		(
			if scenematerials[i].diffuseMap != undefined do 
			(
				pda_x = scenematerials[i].diffuseMap.filename
				pda_y = filenamefrompath pda_x
				pda_z = replace pda_y (pda_y.count-3) 4 ".jpg"
				pda_path = "D:\A350\__maps__\\" + pda_z
				scenematerials[i].diffuseMap.filename = pda_path
			)
			
		)
		
		
		if classof scenematerials[i] == Multimaterial do 
		(
			for j = 1 to scenematerials[i].count do 
			(
				if scenematerials[i][j].diffuseMap != undefined do 
				(
					pda_x = scenematerials[i][j].diffuseMap.filename
					pda_y = filenamefrompath pda_x
					pda_z = replace pda_y (pda_y.count-3) 4 ".jpg"
					pda_path = "D:\A350\__maps__\\" + pda_z
					scenematerials[i][j].diffuseMap.filename = pda_path
				)
			)
		)
		
)




-- Brouillon
--------------

pda_x=meditmaterials[1][3].diffuseMap.filename

meditmaterials[1] = scenematerials[111]

i


pda_x = $.material.diffuseMap.filename

pda_y = filenamefrompath pda_x

pda_y.count


pda_z = replace pda_y (pda_y.count-3) 4 ""
