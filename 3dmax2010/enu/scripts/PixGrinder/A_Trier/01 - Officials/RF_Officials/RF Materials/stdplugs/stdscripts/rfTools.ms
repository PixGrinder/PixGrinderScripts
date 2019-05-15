global StdMaterialID = #(0x00000002, 0x00000000)
global rfMaterialID = #(0x5ab1c788, 0x3611fb18)
global shellMaterialID = #(0x0000255, 0x00000000)
global compositeMaterialID = #(0x0000200, 0x00000000)
global materialList = #()
global strstream = ""
global allStr = ""

fn matchID a b =
(
	res = true
	if( a[1] != b[1] ) do res = false
	if( a[2] != b[2] ) do res = false
	
	res
)


fn copyProperties mat1 mat2 =
(
	-- float types
	mat2.ior = mat1.ior
	mat2.wireSize = mat1.wireSize
	mat2.dimLevel = mat1.dimLevel
	mat2.reflectionLevel = mat1.reflectionLevel
	mat2.samplerQuality = mat1.samplerQuality
	mat2.samplerAdaptThreshold = mat1.samplerAdaptThreshold
	mat2.UserParam0 = mat1.UserParam0
	mat2.UserParam1 = mat1.UserParam1
	mat2.soften = mat1.soften
	mat2.bounce = mat1.bounce
	mat2.staticFriction = mat1.staticFriction
	mat2.slidingFriction = mat1.slidingFriction
	
	-- integer types
	mat2.shaderType = mat1.shaderType
	mat2.opacityType = mat1.opacityType
	mat2.opacityFallOffType = mat1.opacityFallOffType
	mat2.wireUnits = mat1.wireUnits
	mat2.sampler = mat1.sampler
	
	
	-- percent types
	mat2.opacity = mat1.opacity
	mat2.opacityFallOff = mat1.opacityFallOff
	mat2.selfIllumAmount = mat1.selfIllumAmount
	mat2.specularLevel = mat1.specularLevel
	mat2.glossiness = mat1.glossiness
	
	-- boolean types
	mat2.wire = mat1.wire
	mat2.twoSided = mat1.twoSided
	mat2.faceMap = mat1.faceMap
	mat2.faceted = mat1.faceted
	mat2.applyReflectionDimming = mat1.applyReflectionDimming
	mat2.samplerEnable = mat1.samplerEnable
	mat2.samplerAdaptOn = mat1.samplerAdaptOn
	mat2.subSampleTextureOn = mat1.subSampleTextureOn
	mat2.samplerAdvancedOptions = mat1.samplerAdvancedOptions
	mat2.samplerUseGlobal = mat1.samplerUseGlobal
	mat2.adTextureLock = mat1.adTextureLock
	mat2.noExposureControl = mat1.noExposureControl
	mat2.exposureControlInvertSelfIllum = mat1.exposureControlInvertSelfIllum
	mat2.exposureControlInvertReflection = mat1.exposureControlInvertReflection
	mat2.exposureControlInvertRefraction = mat1.exposureControlInvertRefraction
	mat2.adTextureLock = mat1.adTextureLock
	mat2.adLock = mat1.adLock
	mat2.dsLock = mat1.dsLock
	mat2.useSelfIllumColor = mat1.useSelfIllumColor
	
	-- string types
	mat2.shaderByName = mat1.shaderByName
	mat2.samplerByName = mat1.samplerByName
	
	-- color types
	mat2.filterColor = mat1.filterColor
	mat2.ambient = mat1.ambient
	mat2.diffuse = mat1.diffuse
	mat2.specular = mat1.specular
	mat2.selfIllumColor = mat1.selfIllumColor	
	
	-- texture map types
	mat2.filterMap = mat1.filterMap
	
	-- array types
	i = 1
	for elem in mat1.mapEnables do
	(
		mat2.mapEnables[i] = elem
		i = i+1
	)
	
	i = 1
	for elem in mat1.maps do
	(
		mat2.maps[i] = elem
		i = i+1
	)
	
	i = 1
	for elem in mat1.mapAmounts do
	(
		mat2.mapAmounts[i] = elem
		i = i+1
	)
	--showproperties(mat1)
)

fn replaceMat mat shouldReplace isRfMaterial =
(	
	if(shouldReplace) then
	(
		i = 1
		for element in materialList do 
		( 
			if (element == mat) do
			(
				--strstream += "\tmaterial has already been processed\r\n"
				curMat = materialList[i+1]
				if(curMat == undefined) then
				(
					--print("undefined found")
					--print i
					--print materialList.count
					--print mat.name
					
					strstream += "\tmaterial is found and is undefined\r\n"
				)
				return materialList[i+1]
			)
			i = i+1
		)
	
		--strstream += "\treplacing material\r\n"
		if (isRfMaterial) then
		(
			--showproperties(mat.Standard)
			if (mat.CustomMap != undefined) do
			(
				strstream += "\twarning, discarding light map\r\n"
			)
			newMat = standard()
			(copyProperties mat.Standard newMat)
			--print mat.Standard.ambient
			--print newMat.ambient
			newMat.name = mat.name
			append materialList mat	
			append materialList newMat
			return newMat
		)
		else
		(
			--showproperties(mat)
			newMat = RfMaterial()
			(copyProperties mat newMat.Standard)
			newMat.name = mat.name
			--print newMat.Standard.ambient
			--print mat.ambient
			
			--showproperties(newMat)
			
			append materialList mat	
			append materialList newMat
			return newMat
		)
	)
	else	(
		--strstream += "\tno replacement\r\n"
		--append materialList mat
		--append materialList mat
		return mat
	)
)


fn buildMat mat replaceStd =
(
	matToReturn = undefined
	
	--print mat.classID
	--showproperties(mat)
	
	if (matchID mat.classID shellMaterialID) then
	(
		if(mat.bakedMaterial != undefined) then
		(
			matBuilt = (buildMat mat.bakedMaterial replaceStd)
			if (matBuilt == undefined) then
			(
				strstream += "\terror when building material shell baked\r\n"
			)
			else
			(
				mat.bakedMaterial = matBuilt
			)
		)
		if(mat.originalMaterial != undefined) then
		(
			matBuilt = (buildMat mat.originalMaterial replaceStd)
			if (matBuilt == undefined) then
			(
				strstream += "\terror when building material shell original\r\n"
			)
			else
			(
				mat.originalMaterial = matBuilt
			)
		)
		matToReturn = mat
	)
	else 
	( 
		if (matchID mat.classID compositeMaterialID) then
		(
			j = 1
			for curMat in mat.materialList do
			(
				if(curMat != undefined) then
				(
					matBuilt = (buildMat curMat replaceStd)
					if (matBuilt == undefined) then
					(
						curStr = j as string
						strstream += "\terror when building material composite "+curStr+"\r\n"
					)
					else
					(
						mat.materialList[j] = matBuilt
					)
				)
				j = j+1
			)
			matToReturn = mat
		)
		else
		(
			if (matchID mat.classID rfMaterialID) then
			(
				val = (replaceStd == false)
				matToReturn = (replaceMat mat val true)
			)
			else 
			( 
				if (matchID mat.classID StdMaterialID) then
				(
					matToReturn = (replaceMat mat replaceStd false)
				)
				else
				(
					strstream += "\tunknown material type\r\n"
					matToReturn = undefined
				)
			)	
		)
	)
	return matToReturn
)


fn buildObject elem replaceStd =
(
	if(elem.material != undefined) then
	(
		curMat = (buildMat elem.material replaceStd)
		if (curMat != undefined) do
		(
			elem.material = curMat
		)
	)
	else
	(
		--strstream += "\tno material\r\n"
	)
)

fn process replaceStd =
(
	materialList = #()
	allStr = ""	
	
	if (replaceStd) then
	(
		allStr += "Real Fusio Transform To rfMaterial script\r\n"
	)
	else
	(
		allStr += "Real Fusio Transform From rfMaterial script\r\n"
	)
	
	--elem = $Box403
	for elem in geometry do
	(
		strstream = ""
		(buildObject elem replaceStd)
		if(strstream != "") then
		(
			allStr += (elem.name+" "+strstream)
		)
		
	)
	allStr += "tranform done !"
	
	rollout ExportResult "Real Fusio Light Export Script" width:600 height:200
    (
		edittext strLabel readOnly:true height:180
		on ExportResult open do ( strLabel.text = allStr )
    )
	
	--output = NewRolloutFloater "Export script results" 300 200
	--addRollout ExportResult output
	createdialog ExportResult
	print allStr
)

global toStd 
global toRf

fn toStd =
(
	replaceStd = False
	(process replaceStd)
)

fn toRf =
(
	replaceStd = True
	(process replaceStd)
)
