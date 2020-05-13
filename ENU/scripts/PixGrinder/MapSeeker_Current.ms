-- PBR Maps Seeker (On Standard Material)


--(medit.GetCurMtl())


if (medit.GetCurMtl()).diffuseMap != undefined do
(
	(medit.GetCurMtl()).diffuse = (color 256 256 256)
	(medit.GetCurMtl()).glossiness = 20
	(medit.GetCurMtl()).specularLevel = 20
	if MatchPattern (medit.GetCurMtl()).diffuseMap.filename pattern:"*_basecolor*" == true then 
	(
		tempPath = getFilenamePath (medit.GetCurMtl()).diffuseMap.filename
		myPrefix = getFilenameFile (medit.GetCurMtl()).diffuseMap.filename
		(medit.GetCurMtl()).name = substring myPrefix 1 (myPrefix.count-17)
		myPrefix = substring myPrefix 1 (myPrefix.count-17)
		--substring <string> <from_integer> <length_integer>
		if doesFileExist (tempPath+myPrefix+"_MultipleOutput.png") then
		(
			(medit.GetCurMtl()).specularLevelMap = Bitmaptexture filename:(tempPath+myPrefix+"_MultipleOutput.png")
			(medit.GetCurMtl()).glossinessMap = (medit.GetCurMtl()).specularLevelMap
			(medit.GetCurMtl()).specularLevelMapEnable = off
			(medit.GetCurMtl()).glossinessMapEnable = off
			--append myModMat obj.name

		)
		if doesFileExist (tempPath+myPrefix+"_Normal_output.png") then
		(
			myBitmap = Bitmaptexture filename:(tempPath+myPrefix+"_Normal_output.png")
			(medit.GetCurMtl()).bumpMap = Normal_Bump normal_map:myBitmap
			(medit.GetCurMtl()).bumpMapAmount = 100
		)
		if matchPattern (medit.GetCurMtl()).name pattern:"t_*" then 
		(
			(medit.GetCurMtl()).opacityMap = (medit.GetCurMtl()).diffuseMap
			(medit.GetCurMtl()).opacityMap.alphaSource = 0
			(medit.GetCurMtl()).opacityMap.monoOutput = 1
		)
	)
)



-- clearListener()


--actionMan.executeAction 0 "40472"
-- messageBox("Conversion Finished")



/*

substring myPrefix 1 (myPrefix.count-17)

_basecolor_output
medit.GetCurMtl()


show (medit.GetCurMtl()).bumpMap
classOf (medit.GetCurMtl()).bumpMap.normal_map
x1=Bitmaptexture filename:(tempPath+myPrefix+"_MultipleOutput.png")
x1.filename
$.material[1].opacityMap
*/