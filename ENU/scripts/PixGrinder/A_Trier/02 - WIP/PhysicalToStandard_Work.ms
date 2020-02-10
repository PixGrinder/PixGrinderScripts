-- Physical to Standard -- 

clearListener()
myMult = getclassinstances MultiMaterial
myMat = myMult[1]
my Backup = meditMaterials[24]
meditMaterials[24] = Standardmaterial()

with redraw off
(
	myAr = myMat.materialIDList
	for id in myAr do
	(
		if classof myMat[id] == Physicalmaterial then 
		(
			--print id
			myTempAr = #(myMat[id].base_weight_map, myMat[id].base_color_map, myMat[id].bump_map)
			meditMaterials[24] = Standardmaterial()
			meditMaterials[24].name = myMat[id].name
			meditMaterials[24].adTextureLock = off
			meditMaterials[24].adLock = off
			meditMaterials[24].ambientMap = myTempAr[1]
			meditMaterials[24].diffuseMap = myTempAr[2]
			meditMaterials[24].specularLevelMap = meditMaterials[24].ambientMap
			meditMaterials[24].glossinessMap = meditMaterials[24].ambientMap
			meditMaterials[24].bumpMap = myTempAr[3]
			meditMaterials[24].bumpMapAmount = 100.0
			meditMaterials[24].adTextureLock = off
			meditMaterials[24].adLock = off
			meditMaterials[24].ambientMapEnable = off
			meditMaterials[24].specularLevelMapEnable = off
			meditMaterials[24].glossinessMapEnable = off
			myMat[id] = meditMaterials[24]
		)
	)
)

meditMaterials[24] = myBackup

redrawViews()


------------------

/*

myTempAr = #(meditmaterials[3].base_weight_map, meditmaterials[3].base_color_map, meditmaterials[3].roughness_map, meditmaterials[3].metalness_map, meditmaterials[3].bump_map)

obj= meditMaterials[1]
id = 1

*/



