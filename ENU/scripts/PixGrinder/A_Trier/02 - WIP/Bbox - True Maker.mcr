--Creates a Dummy Bbox for 1 selected object

(
	if selection.count == 0 then messageBox("Select at least 1 object")
	else 
	(
		x1 = abs ( selection.max.x-selection.min.x )
		y1 = abs ( selection.max.y-selection.min.y )
		z1 = abs ( selection.max.z-selection.min.z )
		myDum = dummy pos:selection.center name:(selection[1].name+"_bbox") isselected:true boxsize:[x1,y1,z1]
	)
)

