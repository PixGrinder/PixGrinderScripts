-- List Attributes for selected Objects and Materials
-------------------------------------------------------------



for obj in selection do (

	print ((obj.name)+";"+(obj.material.name)+";"+(obj.material.Diffuse.r as string)+";"+(obj.material.Diffuse.g as string)+";"+(obj.material.Diffuse.b as string))
	
)