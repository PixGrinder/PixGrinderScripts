-- Substance to Physical -- 
-- Substance_to_Physical.ms -- 
-- Creates Physical materials from a substance exported folder --
-- Materials are placed in material editor's slots --

clearListener()

macros.run "Medit Tools" "clear_medit_slots"

fn getRadical str1 = 
(
	myTemp = getFilenameFile str1
	theStart = findstring myTemp "_basecolor"
	theBase = replace myTemp theStart (myTemp.count-(theStart-1)) ""
	return theBase
)

myFolder = getSavePath caption:"Select folder containing bitmaps: " initialDir:"D:\\01\\___DemoScene\\Substance\\Material_Exports"
myFolder = myFolder + "\\"


myFiles = getFiles (myFolder +"*_basecolor*.*")

-- for obj in myFiles do print obj

for i = 1 to myFiles.count do
(
	myMat = PhysicalMaterial()
	myMat.base_color_map = Bitmaptexture fileName:myFiles[i]
	myMat.base_color_map.name = getRadical myFiles[i]+"_color"
	myMat.roughness_inv = on
	myMat.metalness_map = Bitmaptexture fileName:(myFolder + getRadical myFiles[i] + "_MultipleOutput" + getFilenameType myFiles[i])
	myMat.metalness_map.name = getRadical myFiles[i] + "_roughMetalAO"
	myMat.base_weight_map = myMat.metalness_map
	myMat.roughness_map = myMat.metalness_map
	myMat.bump_map = Normal_Bump ()
	myMat.bump_map.normal_map = Bitmaptexture fileName:(myFolder + getRadical myFiles[i] + "_Normal_output" + getFilenameType myFiles[i])
	myMat.bump_map.normal_map.name = getRadical myFiles[i] + "_Normal"
	myMat.name = getRadical myFiles[i]+"_mtl"

	meditMaterials[i] = myMat
)


--------------------
/*
getRadical myFiles[1]

myFolder
*/
