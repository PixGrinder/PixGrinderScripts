-------------------------------------
-- Diffuse to white
-- ( materials with diffuse map)
-------------------------------------

(
	clearListener()
	MatEditor.Close()
	myStd = getClassInstances StandardMaterial
-- 	for obj in myStd where obj.diffusemap != undefined do 
-- 	(
-- 		obj.diffuseColor = (color 255 255 255)
-- 		print obj.name
-- 	)
	
	x1 = for obj in myStd where obj.diffusemap != undefined and obj.diffuseColor != (color 255 255 255) collect obj
	print x1.count
	x2 = standardMaterial name:"StandardMat"
	for i = 1 to 24 do meditmaterials[i] = x2
	for i = 1 to x1.count do meditmaterials[i] = x1[i]
	print "DiffuseToWhite.ms completed"
	MatEditor.Open()

)

