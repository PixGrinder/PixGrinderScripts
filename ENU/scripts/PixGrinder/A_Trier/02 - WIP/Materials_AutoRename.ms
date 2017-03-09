
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Materials Auto Rename --
-- Renames Materials and Bitmap Textures with materials bitmap name--
-- V 1.2 --

---------------------------------------------------------------------


(
	StdMaterials = getClassInstances StandardMaterial
	StdBitmap = for obj in StdMaterials where classof obj.diffuseMap == BitmapTexture and obj.diffuseMap.filename != undefined collect obj
	StdColor = for obj in StdMaterials where obj.diffuseMap == undefined collect obj
	BmTex = getClassInstances BitmapTexture
	myPrefix = "AS365_"

	for obj in StdBitmap do 
	(
		pda_y = getFilenameFile obj.diffuseMap.filename
		--pda_z = replace pda_y (pda_y.count-3) 4 ""
		obj.name = (myPrefix+"BitMapMat_"+pda_y)
	)

	for i = 1 to StdColor.count do
	(
		StdColor[i].name = (myPrefix + "ColorMat_" + (i as string))
	)

	for obj in BmTex where obj.filename != undefined do obj.name = (getFilenameFile obj.filename +"_BitMap")


	for obj in objects where classof obj.material == MultiMaterial do obj.material.name = (myPrefix + "MultiMat_" + obj.name )


	--- Adding Transparency feature ---

	for obj in StdColor where obj.opacity < 100.0 do 
	(
		i=1
		obj.name = (myPrefix + "TranspColor_" + (i as string))
		i = i+1
	)

		for obj in StdBitmap where obj.opacityMap != undefined do 
	(
		pda_y = getFilenameFile obj.diffuseMap.filename
		--pda_z = replace pda_y (pda_y.count-3) 4 ""
		obj.name = (myPrefix+"TranspBitmap_"+pda_y)
	)



)





