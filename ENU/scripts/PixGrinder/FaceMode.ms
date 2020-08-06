-- FaceMode v 3.0 --
-- Script designed to replace the "4" key on keyboard in order to quickly access face subobject mode , in poly mode, on any geometry object.


	clearListener()
	setCommandPanelTaskMode mode:#modify
	obj = selection[1]
	obj.backfacecull = on


	if superclassof obj == GeometryClass and classof obj != Editable_Poly and classof obj != PolyMeshObject then convertToPoly obj

	if superclassof obj == shape then
	(
		if obj.render_displayRenderMesh == true then 
		(
			convertToPoly obj
			subobjectlevel = 4
		)
	)
	
	if classof obj == Editable_Poly or classof obj == PolyMeshObject then 
	(
		
		myAction = off
		if subobjectlevel == 3 then
		(
			if obj.modifiers.count > 0 and classof obj.modifiers[1] == Unwrap_UVW then
			(
				if myAction == off then
				(
					myAction = on
					subobjectlevel = 0
				)
			) else (
				subobjectlevel = 2
				myTemp = (polyop.getEdgeSelection obj)
				if myTemp.count != 0 then mySel = polyop.getFacesUsingEdge obj myTemp
				subobjectlevel = 4
				polyop.setFaceSelection obj mySel
				update obj
				mySel = undefined
			)
		)

		if subobjectlevel == 4 and myAction == off then 
		(
			subobjectlevel = 0
			myAction = on
		)

		if subobjectlevel == 0 and myAction == off then 
		(
			if obj.modifiers.count > 0 and classof obj.modifiers[1] == Unwrap_UVW then
			(
				myAction = on
				subobjectlevel = 3
			) else (
				myAction = on
				subobjectlevel = 4
			)
		)
	
		if subobjectlevel == 2 then
		(
			if obj.modifiers.count > 0 and classof obj.modifiers[1] == Unwrap_UVW then
			(
				subobjectlevel = 3
			) else (
				myTemp = (polyop.getEdgeSelection obj)
				if myTemp.count != 0 then mySel = polyop.getFacesUsingEdge obj myTemp
				subobjectlevel = 4
				polyop.setFaceSelection obj mySel
				update obj
				mySel = undefined
			)
		)

		if subobjectlevel == 1 then
		(
			if obj.modifiers.count > 0 and classof obj.modifiers[1] == Unwrap_UVW then
			(
				subobjectlevel = 3
			) else (
				myTemp = (polyop.getVertSelection obj)
				if myTemp.count != 0 then mySel = polyop.getFacesUsingVert obj myTemp
				subobjectlevel = 4
				-- polyop.setFaceSelection obj #{}
				-- update obj
				polyop.setFaceSelection obj mySel
				update obj
				mySel = undefined
			)
		)

		if subobjectlevel == 5 then subobjectlevel = 4
	)

	



