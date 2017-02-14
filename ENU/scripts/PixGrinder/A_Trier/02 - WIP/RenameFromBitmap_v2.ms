-- RenameFromBitmap --


(
	x1 = getClassInstances BitmapTexture
	x2 = getClassInstances StandardMaterial
	x3 = getClassInstances MultiMaterial
	myI = 0
	myM = 0
	
	for obj in x1 do
	(
		obj.name = getFilenameFile obj.filename + "_map"
	)
	

	for obj in x2 do
	(
		try (obj.name = getFilenameFile obj.diffusemap.filename + "_mtl") catch 
		(
			myI = myI+1
			obj.name = ( "SimpleMat_" + (myI as string)) 
		)
	)
	
	for obj in x3 do
	(
		try 
		(
			if matchpattern obj.name pattern:"_mtl" == true then 
			(
				obj.name = substring obj[1].name 1 (obj[1].name.count-4) + "_multiMat"
			) else (
				myM = myM + 1
				obj.name = ( "MultiMat_" + (myM as string) )
			)
		) catch (
			myM = myM + 1
			obj.name = ( "MultiMat_" + (myM as string) )
		)
	)
	
	
	MatEditor.Open()
	
)

