


for i =1 to SceneMaterials.count do (
	
		if classof scenematerials[i] == Standardmaterial do (
			if scenematerials[i].diffuseMap != undefined do (
				pda_x = scenematerials[i].diffuseMap.filename
				pda_y = filenamefrompath pda_x
				pda_z = replace pda_y (pda_y.count-3) 4 ""
				scenematerials[i].name = pda_z
			)
			
		)
)




-- Brouillon
--------------

pda_x = $.material.diffuseMap.filename

pda_y = filenamefrompath pda_x

pda_y.count


pda_z = replace pda_y (pda_y.count-3) 4 ""

