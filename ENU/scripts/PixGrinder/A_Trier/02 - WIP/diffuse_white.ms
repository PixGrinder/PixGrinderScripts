-- Diffuse To White -- 
-- put all diffuseColor to white fot materials with diffuse bitmap--
-- v2.0 --

myStd = getClassInstances StandardMaterial

for obj in myStd where obj.diffusemap != undefined do
(
	meditMaterials[24] = obj
	meditMaterials[24].diffuse = (color 255 255 255)
)



/*

--pda = GetCurrentSelection()
pda = geometry as array

for i = 1 to pda.count do
(
	if classof pda[i].material == StandardMaterial and pda[i].material.diffusemap != undefined then pda[i].material.diffuse = (color 255 255 255)
	
	if classof pda[i].material == Multimaterial do
	(
		for j = 1 to pda[i].material.count do
		(
			if classof pda[i].material[j] == StandardMaterial and pda[i].material[j].diffusemap != undefined then pda[i].material[j].diffuse = (color 255 255 255)
			
		)
		
	)
)


*/