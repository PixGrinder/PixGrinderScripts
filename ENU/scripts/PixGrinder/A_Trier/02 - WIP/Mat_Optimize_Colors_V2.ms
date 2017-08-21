-- v2.0 --
	
	-- !! Be sure to Run sccript "Apply_CollapseMultiMaterial" before this one !! --

(

	clearListener()

	myProg = 0

	fn myNumberFormat v1 = 
	(
		t1 = v1 as point3
		ta = t1[1] as integer
		tb = t1[2] as integer
		tc = t1[3] as integer
		ta = formattedPrint ta format:"03d"
		tb = formattedPrint tb format:"03d"
		tc = formattedPrint tc format:"03d"
		result = ta+"_"+tb+"_"+tc
		result
	)


	fn readAsPoint3 v1 = 
	(
		a = (substring v1 1 3 ) as integer
		b = (substring v1 5 3) as integer
		c = (substring v1 9 3) as integer
		[a,b,c]
	)


	allStand  = getClassInstances StandardMaterial

	InfosMat = for obj in objects where classof obj.material == StandardMaterial collect #(obj,obj.name,obj.material,(myNumberFormat obj.material.diffuse),obj.material.diffuseMap,obj.material.opacity,obj.material.opacityMap)

	colorStrings = #() 
	for obj in allStand where obj.diffuseMap == undefined and obj.opacity == 100.0 do appendIfUnique colorStrings (myNumberFormat obj.diffuse)

	-- Create Library --
	myMatLib = for obj in colorStrings collect (StandardMaterial name:("ColorMat_"+obj) diffuse:(readAsPoint3 obj) specularLevel:50.0 glossiness:20.0)

	-- Display Infos -- 
	--for obj in myMatLib do format "%\r" obj.name
	format "% %\r" "All Standard Materials :" allStand.count
	format "% %\r" "InfosMat :" InfosMat.count
	format "% %\r" "colorStrings :" colorStrings.count
	format "% %\r" "myMatLib :" myMatLib.count




	disableSceneRedraw()

	progressStart "Processing Single Color Mat..."
	-- Optimization -- 
	for i = 1 to InfosMat.count do 
	(
		if InfosMat[i][5] == undefined and InfosMat[i][6] == 100.0 then
		(
			for bla in myMatLib do
			(
				if InfosMat[i][4] == myNumberFormat(bla.diffuse) then InfosMat[i][1].material = bla
			)
		)
		if (100*(i as float)/InfosMat.count > (myProg as float)) do
		(
			myProg = myProg+1
			progressUpdate myProg
		)
	)
	ProgressEnd()


	


	-- Part 2  - Multimaterials Color Type --


	-- gc light:false delayed:false

	--clearListener()
	MultiInfo = #()
	

	for obj in objects where classof obj.material == multiMaterial do
	(
		for i = 1 to obj.material.count do
		(
			if obj.material[i].diffuseMap == undefined and obj.material[i].opacity == 100.0  then append MultiInfo #(obj,obj.name,obj.material,obj.material[i],i, myNumberFormat (obj.material[i].diffuse))
		)
	)
	MultiInfo.count


	myProg = 0

	progressStart "Processing Multi Color Mat..."

	for i = 1 to MultiInfo.count do
	(
		for bla in myMatLib do
		(
			if MultiInfo[i][6] == myNumberFormat(bla.diffuse) then MultiInfo[i][1].material[(MultiInfo[i][5])] = bla
		)

		if (100*(i as float)/MultiInfo.count > (myProg as float)) do
		(
			myProg = myProg+1
			progressUpdate myProg
		)
	)


	ProgressEnd()

	



	--for obj in MultiInfo do format "%  %\r" obj[5] obj[4]



	-- Part 3  - Single Materials Texture Type --

	bitmapStrings = #() 
	for obj in allStand where classof obj.diffuseMap == bitmapTexture and obj.opacityMap == undefined do appendIfUnique bitmapStrings (fileNameFromPath obj.diffuseMap.bitmap.fileName)
	-- for obj in bitmapStrings do format"%\r" obj
	format "% %\r" "bitmapStrings :" bitmapStrings.count


	theBitmaps = getClassInstances BitmapTexture
	-- show theBitmaps[1]
	



	-- Create Library --
	myMatLibTex = #()
	for obj in bitmapStrings do
	(
		myTempA = for bla in theBitmaps where obj == fileNameFromPath bla.fileName collect bla
		myTempA[1].name = ("BitmapTex_"+ (getFilenameFile obj))
		append myMatLibTex (StandardMaterial name:("BitmapMat_"+ (getFilenameFile obj)) diffuse:[255,255,255] diffuseMap:myTempA[1] specularLevel:50.0 glossiness:20.0)
	)

	-- for obj in myMatLibTex do format "%\r" obj.name
	format "% %\r" "myMatLibTex :" myMatLibTex.count



	-- InfosMat : 
	-- 1 - obj
	-- 2 - obj.name
	-- 3 - obj.material
	-- 4 - diffuse color code as string
	-- 5 - obj.material.diffuseMap
	-- 6 - obj.material.opacity
	-- 7 - obj.material.opacityMap

	myProg = 0

	progressStart "Processing Single BITMAP Mat..."
	-- Optimization -- 
	for i = 1 to InfosMat.count do 
	(
		if classof InfosMat[i][5] == Bitmaptexture and InfosMat[i][7] == undefined then
		(
			for bla in myMatLibTex do
			(
				if getFilenameFile InfosMat[i][5].filename == getFilenameFile bla.diffuseMap.filename then InfosMat[i][1].material = bla
			)
		)
		if (100*(i as float)/InfosMat.count > (myProg as float)) do
		(
			myProg = myProg+1
			progressUpdate myProg
		)
	)
	ProgressEnd()



	
	

	MultiBitmapInfo = #()


	for obj in objects where classof obj.material == multiMaterial do
	(
		for i = 1 to obj.material.count do
		(
			if classof obj.material[i].diffuseMap == BitmapTexture and obj.material[i].opacityMap == undefined  then append MultiBitmapInfo #(obj,obj.name,obj.material,obj.material[i],i,(filenamefrompath obj.material[i].diffusemap.filename))
		)
	)
	MultiBitmapInfo.count	


	myProg = 0

	progressStart "Processing Multi BITMAP Mat..."

	for i = 1 to MultiBitmapInfo.count do
	(
		for bla in myMatLibTex do
		(
			if MultiBitmapInfo[i][6] == (filenamefrompath bla.diffusemap.filename) then MultiBitmapInfo[i][1].material[(MultiBitmapInfo[i][5])] = bla
		)

		if (100*(i as float)/MultiBitmapInfo.count > (myProg as float)) do
		(
			myProg = myProg+1
			progressUpdate myProg
		)
	)

	ProgressEnd()

	-- MultiMono = for obj in (getClassInstances multimaterial) where obj.count == 1 collect obj
	MonoMatObjects = for obj in objects where classof obj.material == multiMaterial and obj.material.count == 1 collect obj
	for obj in MonoMatObjects do 
	(
		matTemp = obj.material[1]
		obj.material = matTemp
	)

	enableSceneRedraw() 

	actionMan.executeAction 0 "63545"

 	forceCompleteRedraw doDisabled:true





)

-- count1 = for obj in getClassInstances multimaterial collect obj
-- print count1.count
