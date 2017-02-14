for obj in cameras do
(
	if obj.isselected == true do
	(
		x= replace obj.name 1 4 ""
		Sphere radius:50 name:x position:obj.position
	)
	
)

