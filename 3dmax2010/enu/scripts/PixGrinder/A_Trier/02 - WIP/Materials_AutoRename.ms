
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Materials Auto Rename --
-- Renames Materials and Bitmap Textures with materials bitmap name--
-- V 1.4 --
-- 2018/07/30 --

---------------------------------------------------------------------


(
	StdMaterials = getClassInstances StandardMaterial
	StdBitmap = for obj in StdMaterials where classof obj.diffuseMap == BitmapTexture and obj.diffuseMap.filename != undefined collect obj
	StdColor = for obj in StdMaterials where obj.diffuseMap == undefined collect obj
	transpCol = for obj in StdColor where obj.opacity < 100.0 collect obj
	BmTex = getClassInstances BitmapTexture

	fn renameMats myPrefix = 
	(
		for obj in StdBitmap do 
		(
			pda_y = getFilenameFile obj.diffuseMap.filename
			obj.name = (myPrefix+"BitMapMat_"+pda_y)
		)

		for obj in BmTex where obj.filename != undefined do obj.name = (getFilenameFile obj.filename +"_BitMap")


		for obj in objects where classof obj.material == MultiMaterial do obj.material.name = (myPrefix + "MultiMat_" + obj.name )


		--- Transparency feature ---

		for i = 1 to transpCol.count do
		(
			transpCol[i].name = (myPrefix + "TranspColor_" + (i as string))
		)

		for obj in StdBitmap where obj.opacityMap != undefined do 
		(
			pda_y = getFilenameFile obj.diffuseMap.filename
			--pda_z = replace pda_y (pda_y.count-3) 4 ""
			obj.name = (myPrefix+"TranspBitmap_"+pda_y)
		)

	)


	rollout myPrefixer "PrefixChoose" 
	(
		label lbl "Choose Materials Prefix : "
		edittext myField "myCaption" text:"H160_" fieldWidth:150
		button myPrefixBtn "OK"

		on myPrefixBtn pressed do 
		(
			renameMats (myField.text)
		)
	)


	createDialog myPrefixer modal:true


)

