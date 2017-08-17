
	
	-- !! Be sure to Run sccript "Apply_CollapseMultiMaterial" before this one !! --

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


	allStand  = getClassInstances StandardMaterial
	format "% %\r" "All Standard Materials :" allStand.count

	InfosMat = for obj in objects where classof obj.material == StandardMaterial collect #(obj,obj.name,obj.material,obj.material.diffuse,obj.material.diffuseMap,obj.material.opacity,obj.material.opacityMap)
	format "% %\r" "InfosMat :" InfosMat.count

	colorStrings = #() 
	for obj in allStand where obj.diffuseMap == undefined and obj.opacity == 100.0 do appendIfUnique colorStrings obj.diffuse
	format "% %\r" "colorStrings :" colorStrings.count

	-- Create Library --
	myMatLib = for obj in colorStrings collect (StandardMaterial name:("ColorMat_"+(myNumberFormat obj)) diffuse:(obj as point3) )
	for obj in myMatLib do format "%\r" obj.name
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
				if InfosMat[i][4] == bla.diffuse then InfosMat[i][1].material = bla
			)
		)
		if (100*(i as float)/InfosMat.count > (myProg as float)) do
		(
			myProg = myProg+1
			progressUpdate myProg
		)
	)
	ProgressEnd()

	

	


	-- Part 2 --


	gc light:false delayed:false

	--clearListener()
	MultiInfo = #()
	myProg = 0

	for obj in objects where classof obj.material == multiMaterial do
	(
		for i = 1 to obj.material.count do
		(
			if obj.material[i].diffuseMap == undefined and obj.material[i].opacity == 100.0  then append MultiInfo #(obj,obj.name,obj.material,obj.material[i],i)
		)
	)
	MultiInfo.count




	progressStart "Processing Multi Color Mat..."

	for i = 1 to MultiInfo.count do
	(
		for bla in myMatLib do
		(
			if MultiInfo[i][4] == bla.diffuse then MultiInfo[i][1].material[(MultiInfo[i][5])] = bla
		)

		if (100*(i as float)/MultiInfo.count > (myProg as float)) do
		(
			myProg = myProg+1
			progressUpdate myProg
		)
	)


	ProgressEnd()

	enableSceneRedraw() 



--for obj in MultiInfo do format "%  %\r" obj[5] obj[4]



