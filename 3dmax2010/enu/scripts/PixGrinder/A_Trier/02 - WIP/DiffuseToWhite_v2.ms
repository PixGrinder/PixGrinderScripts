-------------------------------------
-- Diffuse to white
-- ( materials with diffuse map)
-- Optimized by Clement Plantec - 2017-07-03
---------------------------------------------

(
	clearListener()
	for obj in (getClassInstances StandardMaterial) where obj.diffusemap != undefined and obj.diffuseColor != (color 255 255 255) do obj.diffuseColor = (color 255 255 255)
)

