
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Materials Auto Rename --
-- Renames Materials and Bitmap Textures with materials bitmap name--
-- V 1.0 --

---------------------------------------------------------------------


(
	StdMaterials = getClassInstances StandardMaterial
	StdBitmap = for obj in StdMaterials where classof obj.diffuseMap == BitmapTexture and obj.diffuseMap.filename != undefined collect obj
	StdColor = for obj in StdMaterials where obj.diffuseMap == undefined collect obj
	BmTex = getClassInstances BitmapTexture

	for obj in StdBitmap do 
	(
		pda_y = getFilenameFile obj.diffuseMap.filename
		--pda_z = replace pda_y (pda_y.count-3) 4 ""
		obj.name = pda_y+"_material"
	)

	for i = 1 to StdColor.count do
	(
		StdColor[i].name = ("AS365_Material_" + (i as string))
	)

	for obj in BmTex where obj.filename != undefined do obj.name = (getFilenameFile obj.filename +"_bitmap")


	for obj in objects where classof obj.material == MultiMaterial do obj.material.name = (obj.name + "_MultiMat")


)





-- OLD
--------------


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



obj = meditmaterials[2]

getFilenameFile obj.diffuseMap.filename