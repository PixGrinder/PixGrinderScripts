clearListener()

fn updateMatInfos =
(
	-- Force to update Scene Materials informations by saving an empty maxFile --
	tempFile = maxFilePath + "_tempSceneMaterialsHack.max"
	saveNodes #() tempFile
	deleteFile tempFile
)

allStand  = getClassInstances StandardMaterial
format "% %\r" "All Standard Materials :" allStand.count

InfosMat = for obj in objects where classof obj.material == StandardMaterial collect #(obj,obj.name,obj.material,obj.material.diffuse,obj.material.diffuseMap,obj.material.opacity,obj.material.opacityMap)
format "% %\r" "InfosMat :" InfosMat.count

colorStrings = #() 
for obj in InfosMat where obj[5] == undefined and obj[6] == 100 do appendIfUnique colorStrings obj[4]
format "% %\r" "colorStrings :" colorStrings.count

-- Create Library --
myMatLib = for obj in colorStrings collect (StandardMaterial name:("ColorMat_"+(obj as string)) diffuse:(obj as point3) )
format "% %\r" "myMatLib :" myMatLib.count



-- Optimization -- 
for obj in InfosMat where obj[5] == undefined and obj[6] == 100 do
(
	for bla in myMatLib do
	(
		if obj[4] == bla.diffuse then obj[1].material = bla
	)
)

updateMatInfos()

allStand  = getClassInstances StandardMaterial
format "% %\r" "All Standard Materials :" allStand.count