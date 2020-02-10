
(
	for obj in selection do (
	obj.pos.controller = Position_XYZ ()	
	obj.rotation.controller = Euler_XYZ ()
	obj.scale.controller = ScaleXYZ ()
	)
)