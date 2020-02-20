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

rollout pda_Working "Working"
(
	Label lbl1 "Converting materials..."
)


clearListener()
if selection.count >0 and classof selection[1].material == Multimaterial then 
(
	CreateDialog pda_Working
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
				if myMat[id].opacity < 100 then 
				(
					meditMaterials[24].transparency = 1-(myMat[id].opacity/100)
					meditMaterials[24].thin_walled = on
				)


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
	CreateDialog pda_Working
	-- myMult = getclassinstances MultiMaterial
	myMat = selection[1].material
	myBackup = meditMaterials[24]
	meditMaterials[24] = Standardmaterial()

	with redraw off
	(
		--print id
		myTempAr = #(myMat.ambientMap, myMat.diffuseMap, myMat.diffuseColor, myMat.bumpMap, myMat.specularLevel, myMat.glossiness, myMat.selfillumMap, myMat.selfillumMapAmount, myMat.selfIllumColor,myMat.filterMap)
		meditMaterials[24] = Physicalmaterial()
		meditMaterials[24].material_mode = 1
		meditMaterials[24].name = myMat.name
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
		if myMat.opacity < 100 then 
		(
			meditMaterials[24].transparency = 1-(myMat.opacity/100)
			meditMaterials[24].thin_walled = on
		)

-- 			meditMaterials[24].bumpMapAmount = 100.0
		meditMaterials[24].showInViewport = true
		selection[1].material = meditMaterials[24]
	)

	meditMaterials[24] = myBackup
	redrawViews()

) 

DestroyDialog pda_Working
messageBox("Conversion Finished")

