-- Script designed to replace the "4" key on keyboard in order to quickly access face subobject mode , in poly mode, on any geometry object.


(
	obj = selection[1]

	fn myConvert x1 = 
	(
		convertToPoly x1
		max modify mode
		subobjectlevel = 4
	)
	
	if superclassof obj == GeometryClass do
	(
		obj.backfacecull = on
		max modify mode
		if classof obj == Editable_Poly then 
		(
			if subobjectlevel == 4 then subobjectlevel = 0 else subobjectlevel = 4
		) else (
		convertToPoly obj
		subobjectlevel = 4
		)
	)
	
	if superclassof obj == shape do
	(
		if obj.render_displayRenderMesh == true do myConvert obj
	)
	
)
	



