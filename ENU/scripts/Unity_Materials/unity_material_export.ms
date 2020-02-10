global MATERIAL_TEMPLATE = include "$userScripts/Unity_Materials/template.mat"

function collectMaterials mat materials =
(
	local classMat = classof mat
	if classMat == PhysicalMaterial then
		append materials mat
	else if classMat == Multimaterial then
		for subMaterial in mat do
			collectMaterials subMaterial materials
)

mapped function collectObjectMaterials obj materials =  collectMaterials obj.material materials

function getBitmap map =
(
	case (classof map) of
	(
		Bitmaptexture: map
		Normal_Bump: map.normal
		default: undefined
	)
)

function findMapGUID map textureDir =
(
	local metaFilename = textureDir + "\\" + (filenameFromPath map.filename) + ".meta"
	local metaFile = memStreamMgr.openFile metaFilename
	local guid = 0
	if metaFile != undefined then
	(
		while not metaFile.eos() and guid == 0 do
		(
			local token = metaFile.readToken()
			if token == "guid:" then
			(
				token = metaFile.readToken()
				guid = "2800000, guid: "+token+", type: 3"
			)
		)
		memStreamMgr.close metaFile
	)
	else
	(
		local msg = "Unable to find texture Unity meta file "+metaFilename+".\nDid you forget to extract textures?"
		messageBox msg
	)
	guid
)

function toStr v = formattedprint v format:"g"
	
function colorToYAML col al =
(
	ss = stringstream ""
	r = toStr (col.r/255.0)
	g = toStr (col.g/255.0) 
	b = toStr (col.b/255.0) 
	a = toStr al
	format "{r: %, g: %, b: %, a: %}" r g b a to:ss
	free r
	free g
	free b
	free a
	ss as string
)

function isAlphaMap map =
(
	image = map.bitmap
	if image.hasAlpha then
	(
		-- We need to scan every pixels to check if there is alpha
		for y=0 to (image.height-1) do
		(
			rowPixels = getPixels image (Point2 0 y) image.width
			for pix in rowPixels do
			(
				if pix.a < 255 then
					free rowPixels
					return true
			)
			free rowPixels
		)
	)
	false
)

mapped function exportMaterial material matDir: texDir:  =
(
	if classof material == PhysicalMaterial then
	(
		materialFilename = material.name
		materialFilename = materialFilename + ".mat"
		-- Write material file
		materialFilePath = matDir + "\\" + materialFilename
		materialFile = createFile materialFilePath encoding:#utf8 writeBOM:false
		if materialFile != undefined then
		(
			format "Writing material file %\n"  materialFilePath
			
			albedoMap = getBitmap material.base_color_map
			cutoutMap = getBitmap material.cutout_map

			keywords = ""
			lightmapFlags = 4
			
			content = substituteString MATERIAL_TEMPLATE "$NAME" material.name
			
			-- Check if material is opaque, transparent or cutout
			renderQueue = -1
			stringTagMap = " {}"
			mode = 0
			dstBlend = 0
			srcBlend = 1
			zWrite = 1
			if albedoMap != undefined and cutoutMap != undefined and albedoMap == cutoutMap and material.cutout_map_on then
			(
				keywords = "_ALPHATEST_ON "
				renderQueue = 2450
				stringTagMap = "\n    RenderType: TransparentCutout"
				mode = 1
			)
			else if material.transparency > 0 or (albedoMap != undefined and isAlphaMap albedoMap) then
			(
				keywords = "_ALPHABLEND_ON "
				renderQueue = 3000
				stringTagMap = "\n    RenderType: Transparent"
				mode = 2
				dstBlend = 10
				srcBlend = 5
				zWrite = 0
			)
			content = substituteString content "$RENDERQUEUE" (renderQueue as string)
			content = substituteString content "$STRING_TAG_MAP" (trimRight stringTagMap)
			content = substituteString content "$MODE" (mode as string)
			content = substituteString content "$DST_BLEND" (dstBlend as string)
			content = substituteString content "$SRC_BLEND" (srcBlend as string)
			content = substituteString content "$Z_WRITE" (zWrite as string)
			
			-- Normal map
			map = getBitmap material.bump_map
			map_id = 0
			if map != undefined and material.bump_map_on then
			(
				map_id = findMapGUID map texDir
				if map_id !=0 then
					keywords = keywords + "_NORMALMAP "
			)
			content = substituteString content "$BUMP_MAP" (map_id as string)				
			content = substituteString content "$BUMP_SCALE" (toStr (material.bump_map_amt / 0.3))				
			
			-- Emissive map
			emitColor = material.emit_color
			map = getBitmap material.emit_color_map
			map_id = 0
			if map != undefined and material.emit_color_map_on then
			(
				map_id = findMapGUID map texDir
				if map_id != 0 then
				(
					emitColor.r = 255
					emitColor.g = 255
					emitColor.b = 255
				)
			)
			content = substituteString content "$EMISSIVE_MAP" (map_id as string)	
			content = substituteString content "$EMISSIVE" (colorToYAML (emitColor * material.emission) 0.0)
			if material.emission > 0 then
			(
				lightmapFlags = 2
				keywords = keywords + "_EMISSION "
			)
			
			-- Albedo map
			albedoColor = material.base_color
			opacity = 1.0 - material.transparency			
			map_id = 0
			if albedoMap != undefined and material.base_color_map_on then
			(
				map_id = findMapGUID albedoMap texDir
				if map_id != 0 then
				(
					albedoColor.r = 255
					albedoColor.g = 255
					albedoColor.b = 255
					opacity = 1.0
				)
			)
			content = substituteString content "$ALBEDO_MAP" (map_id as string)
			content = substituteString content "$ALBEDO" (colorToYAML albedoColor opacity)				
			
			-- Metallic map
			map = getBitmap material.metalness_map
			map_id = 0
			if map != undefined and material.metalness_map_on then
			(
				map_id = findMapGUID map texDir
				if map_id !=0 then
					keywords = keywords + "_METALLICGLOSSMAP "
			)
			content = substituteString content "$METALLIC_MAP" (map_id as string)				
			content = substituteString content "$METALLIC" (toStr material.metalness)				
			
			-- Occlusion map
			map = getBitmap material.base_weight_map
			map_id = 0
			if map != undefined and material.base_weight_map_on then
			(
				map_id = findMapGUID map texDir
			)
			content = substituteString content "$OCCLUSION_MAP" (map_id as string)				
			
			-- Roughness map
			map = getBitmap material.roughness_map
			map_id = 0
			if map != undefined and material.roughness_map_on then
			(
				map_id = findMapGUID map texDir
				if map_id !=0 then
					keywords = keywords + "_SPECGLOSSMAP "
			)
			content = substituteString content "$SMOOTHNESS_MAP" (map_id as string)
			local smoothness = material.roughness
			if not material.roughness_inv then
				smoothness = 1.0 - smoothness
			content = substituteString content "$SMOOTHNESS" (toStr smoothness)				
			
			content = substituteString content "$SHADER_KEYWORDS" (trimRight keywords)
			content = substituteString content "$LIGHT_MAP_FLAGS" (lightmapFlags as string)
			
			format "%" content to: materialFile
			free content
			close materialFile
		) 
		else
		(
			msg = "Unable to create material file "+materialFilePath
			messageBox msg
		)
	)
	else if classof material == Multimaterial then
	(
		for subMaterial in material do
			exportMaterial subMaterial matDir:matDir texDir:texDir
	)
)

function exportUnitySceneMaterials materialDir textureDir = 
(
	local physMaterials = #()
	collectObjectMaterials $* physMaterials
	physMaterials = makeUniqueArray physMaterials
	format "Collected % physical materials for export\n" physMaterials.count
	-- Process materials N by N for faster process
	local matIndex = 1
	local exportedMaterialCount = 0
	while matIndex <= physMaterials.count do
	(
		local materialBatch = #()
		local endMatIndex = matIndex+19
		if endMatIndex > physMaterials.count then
			endMatIndex = physMaterials.count
		
		-- Free up some memory now to prevent blocking
		gc delayed:false
		while matIndex <= endMatIndex do
		(
			append materialBatch physMaterials[matIndex]
			matIndex = matIndex+1
		)
		exportMaterial materialBatch matDir:materialDir texDir:textureDir
		-- This is just to check that the proper number of materials have been exported
		exportedMaterialCount = exportedMaterialCount + materialBatch.count
		free materialBatch
	)

	msg = stringstream ""
	format "Done exporting % Unity materials to folder\n%" exportedMaterialCount materialDir to:msg
	messageBox (msg as string)
)