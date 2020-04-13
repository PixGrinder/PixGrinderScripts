-- PBR Maps Seeker (On Standard Material)

rollout pda_Working "Working"
(
	Label lbl1 "Locating Bitmaps..."
)
myBackupMat = meditmaterials[1]

myTab = getClassInstances Standardmaterial
myModMat = #()

CreateDialog pda_Working

for obj in myTab do
(
	meditmaterials[1] = obj
	if meditmaterials[1].diffuseMap != undefined do
	(
		if MatchPattern meditmaterials[1].diffuseMap.filename pattern:"*_basecolor*" == true then 
		(
			tempPath = getFilenamePath meditmaterials[1].diffuseMap.filename
			myPrefix = getFilenameFile meditmaterials[1].diffuseMap.filename
			myPrefix = substring myPrefix 1 (myPrefix.count-17)
			--substring <string> <from_integer> <length_integer>
			if doesFileExist (tempPath+myPrefix+"_MultipleOutput.png") then
			(
				meditmaterials[1].specularLevelMap = Bitmaptexture filename:(tempPath+myPrefix+"_MultipleOutput.png")
				meditmaterials[1].glossinessMap = meditmaterials[1].specularLevelMap
				meditmaterials[1].specularLevelMapEnable = off
				meditmaterials[1].glossinessMapEnable = off
				append myModMat obj.name

			)
			if doesFileExist (tempPath+myPrefix+"_Normal_output.png") then
			(
				myBitmap = Bitmaptexture filename:(tempPath+myPrefix+"_Normal_output.png")
				meditmaterials[1].bumpMap = Normal_Bump normal_map:myBitmap
				meditmaterials[1].bumpMapAmount = 100
			)
			if matchPattern meditmaterials[1].name pattern:"t_*" then 
			(
				meditmaterials[1].opacityMap = meditmaterials[1].diffuseMap
				meditmaterials[1].opacityMap.alphaSource = 0
				meditmaterials[1].opacityMap.monoOutput = 1
			)
		)
	)
)

clearListener()
for obj in myModMat do print obj
meditmaterials[1] = myBackupMat

DestroyDialog pda_Working

actionMan.executeAction 0 "40472"
-- messageBox("Conversion Finished")



/*

show meditmaterials[1].bumpMap
classOf meditmaterials[1].bumpMap.normal_map
x1=Bitmaptexture filename:(tempPath+myPrefix+"_MultipleOutput.png")
x1.filename
$.material[1].opacityMap
*/