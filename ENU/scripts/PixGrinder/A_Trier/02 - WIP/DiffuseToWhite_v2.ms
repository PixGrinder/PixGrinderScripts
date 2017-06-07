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
	for bla in x1 do bla.diffuseColor = (color 255 255 255)
	x2 = standardMaterial name:"StandardMat"
	for i = 1 to 24 do meditmaterials[i] = x2
	if x1.count >24 then myMax = 24 else myMax = x1.count
	for i = 1 to myMax do meditmaterials[i] = x1[i]
	print "DiffuseToWhite.ms completed"
	MatEditor.Open()
)

