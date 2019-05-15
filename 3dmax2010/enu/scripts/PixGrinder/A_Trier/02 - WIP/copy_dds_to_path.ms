-- global pdapath = "\\\Bla-nas-01\shares\REALFUSIO\E13COA0050\Incoming\From Airbus\Sources _3D\Cabine_3D\20131014 - A350 Cabine 3D\maps\\"-- global pdapath = "\\\Bla-nas-01\shares\REALFUSIO\E13COA0050\Incoming\From Airbus\Sources _3D\Cabine_3D\20131014 - A350 Cabine 3D\maps\\"
global pdapath = "d:\alphas\\"

for obj in objects do
(
	if classof obj.material == StandardMaterial and obj.material.opacityMap != undefined do 
	(
		pdax = obj.material.opacityMap.filename
		pday= filenamefrompath obj.material.opacityMap.filename
		pda_all = pdapath + pday
		copy pdax pda_all
	)
		
	if classof obj.material == Multimaterial do 
	(	
		for i = 1 to obj.material.count do 
		(
			if classof obj.material[i] == StandardMaterial and obj.material[i].opacityMap != undefined do 
			(
				pdax = obj.material[i].opacityMap.filename
				pday= filenamefrompath obj.material[i].opacityMap.filename
				pda_all = pdapath + pday
				copy pdax pda_all
			)
		)
	)
)
	
	
-------------------------------

padx = meditmaterials[1][3].opacityMap.filename
pda_y = filenamefrompath meditmaterials[1][3].opacityMap.filename
pdapath = "\\\Bla-nas-01\shares\REALFUSIO\E13COA0050\Incoming\From Airbus\Sources _3D\Cabine_3D\20131014 - A350 Cabine 3D\maps\\"

pda_all = pdapath + pda_y

meditmaterials[1][3].opacityMap.filename = pda_all

-- pda_z = replace pda_y (pda_y.count-3) 4 ""




--------------------------------



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



i = 92
meditmaterials[1] = scenematerials[i]





pda_x = $.material.diffuseMap.filename

pda_y = filenamefrompath pda_x

pda_y.count


pda_z = replace pda_y (pda_y.count-3) 4 ""
