		-- Auto UV Mapping --
		obj = selection[1]
		max modify mode
		mySpacing = 0.01
		MyWarp = unwrap_UVW()
		if superclassof obj == GeometryClass and classof obj != Editable_Poly then 
		(
			convertToPoly obj
			update obj
		)
		setFaceSelection obj #{1..obj.numfaces}
		addModifier obj MyWarp
		MyWarp.setMapChannel 1
		
		-- <void><Unwrap_UVW>.normalMap <point3 array>normalList <float>spacing <boolean>normalize <integer>layOutType <boolean>rotateClusters <boolean>alignWidth
		-- layOutType determines which of the 6 mapping types to use: Back/Front, Left/Right, Top/Bottom, Box Mapping No Top, Box Mapping, Diamond mapping  
		-- alignWidth will sort the clusters by there width otherwise it will use their heights. 

		MyWarp.normalMap #() mySpacing true 0 false true
		--MyWarp.flattenMap 80.0 #() mySpacing true 0 true true
		--update obj
		collapseStack obj


		MyWarp.normalMapDialog()