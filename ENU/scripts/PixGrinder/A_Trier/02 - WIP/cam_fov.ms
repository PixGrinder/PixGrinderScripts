for obj in cameras do 
(
	if superclassof obj == camera do
	(
		obj.specify_fov = on
		$.fov = 70
	)
)