macroScript openPopulateTerrain category:"Populate" tooltip:"Open Populate:Terrain..."
(
	local thisScript=((getdir #maxRoot)+"\\Scripts\\populate-terrain\\populate-terrain.mse" )
	if doesFileExist thisScript then fileIn thisScript
	else messageBox "Files missing, please reinstall." title:"Error"
 )
