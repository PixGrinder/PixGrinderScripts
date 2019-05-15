-- PBR_LoadMaps --
-- v2.0 --
-- Setup the DX Material from picking the basecolor map -- 

(
	clearListener()
	initPath = getDir #scene
	x1 = medit.GetActiveMtlSlot()
	meditMaterials[x1].useshaderfx = 2
	
	fn FileSelec thePath = 
	(
		theDialog = dotNetObject "System.Windows.Forms.OpenFileDialog" -- create a OpenFileDialog 
		theDialog.title = "PLEASE Select One Or More Files" --set the title
		theDialog.Multiselect = false --allow multiple files to be selected
		theDialog.Filter = "Files(*_basecolor.*)|" --specify the filter
		theDialog.FilterIndex = 1 --set the filter drop-down list to All Files
		theDialog.InitialDirectory = thePath
		theDialog.FileName="*_basecolor.*"
		result = theDialog.showDialog() --display the dialog, get result into variable
		result.ToString() --when closed, convert the result to string
		result.Equals result.OK --returns TRUE if OK was pressed, FALSE otherwise
		result.Equals result.Cancel --returns TRUE if Cancel was pressed, FALSE otherwise
		theFilenames = theDialog.fileNames --the selected filenames will be returned as an array
		return theFilenames
	)

	myMap = (FileSelec initPath)[1]

	pda_path = getFilenamePath myMap
	pda_name =  filenamefrompath myMap
	pda_type = getFilenameType myMap
	rpStart = (findString pda_name "_basecolor")
	pda_radical = replace pda_name rpStart (pda_name.count - rpStart + 1) ("_*" + pda_type)


	pda_files = getfiles (pda_path + pda_radical)

	for str in pda_files do
	(
		if MatchPattern str pattern:"*_basecolor*" == true then meditMaterials[x1].TEX_color_map = (bitmaptexture filename:str).bitmap
		if MatchPattern str pattern:"*_metallic*" == true then meditMaterials[x1].TEX_metallic_map = (bitmaptexture filename:str).bitmap
		if MatchPattern str pattern:"*_normal*" == true then meditMaterials[x1].TEX_normal_map = (bitmaptexture filename:str).bitmap
		if MatchPattern str pattern:"*_roughness*" == true then meditMaterials[x1].TEX_roughness_map = (bitmaptexture filename:str).bitmap
		if MatchPattern str pattern:"*_ambiant*" == true then meditMaterials[x1].TEX_ao_map = (bitmaptexture filename:str).bitmap
	)


	if meditMaterials[x1].TEX_color_map == undefined then meditMaterials[x1].use_color_map = 0.0 else meditMaterials[x1].use_color_map = 1.0
	if meditMaterials[x1].TEX_metallic_map == undefined then meditMaterials[x1].use_metallic_map = 0.0 else meditMaterials[x1].use_metallic_map = 1.0
	if meditMaterials[x1].TEX_normal_map == undefined then meditMaterials[x1].use_normal_map = 0.0 else meditMaterials[x1].use_normal_map = 1.0
	if meditMaterials[x1].TEX_roughness_map == undefined then meditMaterials[x1].use_roughness_map = 0.0 else meditMaterials[x1].use_roughness_map = 1.0
	if meditMaterials[x1].TEX_ao_map == undefined then meditMaterials[x1].use_ao_map = 0.0 else meditMaterials[x1].use_ao_map = 1.0
	meditMaterials[x1].base_color = (color 255 255 255 255)


)


/*
	meditMaterials[1].TEX_color_map = undefined
	show meditmaterials[1]
	classof meditmaterials[1].TEX_color_map
	getFilenamePath myMap
	replace pda_name rpStart (pda_name.count - rpStart + 1) ("_metallic" + pda_type)


	str = (bitmaptexture filename:pda_files[1]).bitmap

	str = pda_files[1]

	TheBitMap = bitmaptexture filename:myMap
	meditMaterials[1].TEX_color_map = TheBitMap.bitmap


*/
