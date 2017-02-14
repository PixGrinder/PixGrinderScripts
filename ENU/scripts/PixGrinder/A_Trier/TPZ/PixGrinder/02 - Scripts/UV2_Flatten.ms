
--------------------------------------------- UV2 Flatten
	
(
	global myProg = 0
	progressStart "Flattening UVs 2..."
	
	for i = 1 to geometry.count do
	(
		
		obj = geometry[i]
		select obj
		max modify mode
		x1 = unwrap_UVW()
		modPanel.addModToSelection x1
		subobjectLevel = 3
		max select all
		myMod = obj.modifiers["Unwrap UVW"]
		myMod.setMapChannel 2
		myMod.flattenMap 66.0 #() 0.01 true 0 true true
		collapseStack obj

		if (100*i/geometry.count) > (myProg as float) do
		(
			myProg = myProg+1
			progressUpdate myProg
		)
		test = myProg as string
		if findstring test "0" != undefined do sleep 1
		
	)
	progressEnd()
)

	--------------------------------------------- / UV2 Flatten