-------------------------------------
-- Diffuse to white
-- ( materials with diffuse map)
-------------------------------------

(
	clearListener()
	myStd = getClassInstances StandardMaterial
	for obj in myStd where obj.diffusemap != undefined do obj.diffuseColor = (color 255 255 255)
	print "DiffuseToWhite.ms completed"

)