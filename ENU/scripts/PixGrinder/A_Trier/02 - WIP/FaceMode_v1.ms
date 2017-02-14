-- Script designed to replace the "4" key on keyboard in order to quickly access face subobject mode , in poly mode, on any geometry object.


(
	obj = selection[1]
	
	if superclassof obj == shape do
	(
		if obj.render_displayRenderMesh == true do
		(
			convertToPoly obj
			max modify mode
			subobjectlevel = 4
		)
	)
	
	if superclassof obj == GeometryClass do
	(
		convertToPoly obj
		max modify mode
		subobjectlevel = 4
	)
)
	



