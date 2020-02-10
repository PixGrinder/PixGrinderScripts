
(
	for obj in selection do (
	obj.pos.controller = Position_XYZ ()	
	obj.rotation.controller = linear_rotation ()
	obj.scale.controller = ScaleXYZ ()
	)
)