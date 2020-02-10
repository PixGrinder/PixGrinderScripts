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

StdMats = getclassInstances StandardMaterial

for obj in StdMats do
(

	CreateDialog pda_Working
	-- myMult = getclassinstances MultiMaterial
	--obj = selection[1].material
	myBackup = meditMaterials[24]
	meditMaterials[24] = Standardmaterial()

	with redraw off
	(
		--print id
		myTempAr = #(obj.ambientMap, obj.diffuseMap, obj.diffuseColor, obj.bumpMap, obj.specularLevel, obj.glossiness, obj.selfillumMap, obj.selfillumMapAmount, obj.selfIllumColor,obj.filterMap)
		meditMaterials[24] = Physicalmaterial()
		meditMaterials[24].material_mode = 1
		meditMaterials[24].name = obj.name
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
		if obj.opacity < 100 then 
		(
			meditMaterials[24].transparency = 1-(obj[id].opacity/100)
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

