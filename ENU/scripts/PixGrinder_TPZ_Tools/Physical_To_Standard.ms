-- Physical to Standard -- 

clearListener()
if selection.count >0 and classof selection[1].material == Multimaterial then 
(
	myMult = getclassinstances MultiMaterial
	myMat = selection[1].material
	myBackup = meditMaterials[24]
	meditMaterials[24] = Standardmaterial()

	with redraw off
	(
		myAr = myMat.materialIDList
		for id in myAr do
		(
			if classof myMat[id] == Physicalmaterial then 
			(
				--print id
				myTempAr = #(myMat[id].base_weight_map, myMat[id].base_color_map, myMat[id].base_color, myMat[id].bump_map, myMat[id].roughness, myMat[id].metalness, myMat[id].emit_color_map, myMat[id].emission, myMat[id].emit_color,myMat[id].cutout_map)
				meditMaterials[24] = Standardmaterial()
				meditMaterials[24].name = myMat[id].name
				meditMaterials[24].adTextureLock = off
				meditMaterials[24].adLock = off
				meditMaterials[24].ambientMap = myTempAr[1]
				meditMaterials[24].diffuseMap = myTempAr[2]
				meditMaterials[24].diffuse = myTempAr[3]
				meditMaterials[24].specularLevelMap = meditMaterials[24].ambientMap
				meditMaterials[24].glossinessMap = meditMaterials[24].ambientMap
				meditMaterials[24].bumpMap = myTempAr[4]
				meditMaterials[24].bumpMapAmount = 100.0
				meditMaterials[24].specularLevel = myTempAr[5]*100
				meditMaterials[24].glossiness = myTempAr[6]*100
				meditMaterials[24].selfillumMap = myTempAr[7]
				meditMaterials[24].selfillumMapAmount = myTempAr[8]*100
				meditMaterials[24].selfIllumColor = myTempAr[9]
				meditMaterials[24].filterMap = myTempAr[10]
-- 				if meditMaterials[24].diffusemap != undefined and meditMaterials[24].diffusemap.bitmap.hasAlpha then meditMaterials[24].opacityMap = meditMaterials[24].diffuseMap
				if myTempAr[8] == 0 then meditMaterials[24].selfillumMapEnable = off
				meditMaterials[24].adTextureLock = off
				meditMaterials[24].adLock = off
				meditMaterials[24].ambientMapEnable = off
				meditMaterials[24].specularLevelMapEnable = off
				meditMaterials[24].glossinessMapEnable = off
				meditMaterials[24].filterMapEnable = off
				meditMaterials[24].showInViewport = true
				myMat[id] = meditMaterials[24]
			)
		)
	)

	meditMaterials[24] = myBackup

	redrawViews()
) else (messageBox "Please select 1 object with the main multimaterial")



------------------

/*

myTempAr = #(meditmaterials[3].base_weight_map, meditmaterials[3].base_color_map, meditmaterials[3].roughness_map, meditmaterials[3].metalness_map, meditmaterials[3].bump_map)

obj= meditMaterials[1]
id = 1

for obj in meditmaterials[1] do print(obj.name + "   " + (obj.metalness as string))

for id in myAr do print myMat[id].name

*/



