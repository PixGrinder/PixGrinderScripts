global materialDirVar = undefined
global textureDirVar = undefined
	
-- macroScript ExportUnityMaterial category: "Export" tooltip: "Export scene Physical Materials to Unity material assets"
(
    include "$userScripts/Unity_Materials/unity_material_export_Standard.ms"

    local prevMaterialDir = globalVars.get #materialDirVar
    local prevTextureDir = globalVars.get #textureDirVar

	if prevMaterialDir == undefined then
	(
		prevMaterialDir = ""
	)
	local materialDir = getSavePath caption:"Select the Unity project material folder destination..." initialDir:prevMaterialDir

    textureDir = substituteString materialDir "Materials" "maps" 
	
    if materialDir != undefined then
    (
        /*
        if prevTextureDir == undefined then
        (
            prevTextureDir = materialDir
        )
        local textureDir = getSavePath caption:"Select the Unity project texture folder..." initialDir:prevTextureDir
        */
        if textureDir != undefined then
        (
            globalVars.set #materialDirVar materialDir
            globalVars.set #textureDirVar textureDir

            textureDir = 
			exportUnitySceneMaterials materialDir textureDir
        )
    )

)



