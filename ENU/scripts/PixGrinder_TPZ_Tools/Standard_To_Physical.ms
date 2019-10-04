-- Physical to Standard -- 

/*

Base color = Diffuse
Roughness = specularLevel
Metalness = glossiness
Emissive = selfillumMap


Diffuse = Base color
specularLevel = Roughness
glossiness = Metalness
selfillumMap = Emissive

*/


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
			if classof myMat[id] == StandardMaterial then 
			(
	-- 			myTempAr = #(myMat[id].base_weight_map, myMat[id].base_color_map, myMat[id].bump_map)
				myTempAr = #(myMat[id].ambientMap, myMat[id].diffuseMap, myMat[id].diffuseColor, myMat[id].bumpMap, myMat[id].specularLevel, myMat[id].glossiness, myMat[id].selfillumMap, myMat[id].selfillumMapAmount, myMat[id].selfIllumColor,myMat[id].filterMap)
				meditMaterials[24] = Physicalmaterial()
				meditMaterials[24].material_mode = 1
				meditMaterials[24].name = myMat[id].name
				meditMaterials[24].base_weight_map = myTempAr[1]
				meditMaterials[24].base_color_map = myTempAr[2]
				meditMaterials[24].base_color = myTempAr[3]
				meditMaterials[24].roughness_inv = on
				meditMaterials[24].roughness_map = meditMaterials[24].base_weight_map
				meditMaterials[24].metalness_map = meditMaterials[24].base_weight_map
				meditMaterials[24].bump_map = myTempAr[4]
				meditMaterials[24].roughness = myTempAr[5]/100
				meditMaterials[24].metalness = myTempAr[6]/100

				meditMaterials[24].emit_color_map = myTempAr[7]
				meditMaterials[24].emission = myTempAr[8]/100
				meditMaterials[24].emit_color = myTempAr[9]
				meditMaterials[24].cutout_map = myTempAr[10]

	-- 			meditMaterials[24].bumpMapAmount = 100.0
				meditMaterials[24].showInViewport = true
				myMat[id] = meditMaterials[24]
			)
		)
	)

	meditMaterials[24] = myBackup
	redrawViews()

) --else (messageBox "Please select 1 object with the main multimaterial")



if selection.count >0 and classof selection[1].material == Standardmaterial then 
(
	-- myMult = getclassinstances MultiMaterial
	myMat = selection[1].material
	myBackup = meditMaterials[24]
	meditMaterials[24] = Standardmaterial()

	with redraw off
	(
		--print id
		myTempAr = #(myMat[id].ambientMap, myMat[id].diffuseMap, myMat[id].diffuseColor, myMat[id].bumpMap, myMat[id].specularLevel, myMat[id].glossiness, myMat[id].selfillumMap, myMat[id].selfillumMapAmount, myMat[id].selfIllumColor,myMat[id].filterMap)
		meditMaterials[24] = Physicalmaterial()
		meditMaterials[24].material_mode = 1
		meditMaterials[24].name = myMat[id].name
		meditMaterials[24].base_weight_map = myTempAr[1]
		meditMaterials[24].base_color_map = myTempAr[2]
		meditMaterials[24].base_color = myTempAr[3]
		meditMaterials[24].roughness_inv = on
		meditMaterials[24].roughness_map = meditMaterials[24].base_weight_map
		meditMaterials[24].metalness_map = meditMaterials[24].base_weight_map
		meditMaterials[24].bump_map = myTempAr[4]
		meditMaterials[24].roughness = myTempAr[5]/100
		meditMaterials[24].metalness = myTempAr[6]/100

		meditMaterials[24].emit_color_map = myTempAr[7]
		meditMaterials[24].emission = myTempAr[8]/100
		meditMaterials[24].emit_color = myTempAr[9]
		meditMaterials[24].cutout_map = myTempAr[10]

-- 			meditMaterials[24].bumpMapAmount = 100.0
		meditMaterials[24].showInViewport = true
		selection[1].material = meditMaterials[24]
	)

	meditMaterials[24] = myBackup
	redrawViews()

) 




------------------

/*


meditMaterials[24].specularLevel = 10
meditMaterials[24].glossiness = 10



myTempAr = #(meditmaterials[3].base_weight_map, meditmaterials[3].base_color_map, meditmaterials[3].roughness_map, meditmaterials[3].metalness_map, meditmaterials[3].bump_map)

obj= meditMaterials[1]
meditMaterials[1][1].material_mode   
show meditMaterials[1][1]
meditMaterials[1][1].diffusemap.bitmap.hasAlpha
show meditMaterials[1][1].diffusemap
id = 1

*/



