-- BitmapTexture finder --

(
	x1 = getClassInstances Bitmaptexture

	for obj in x1 do 
	(
		if matchpattern obj.name pattern:"Map #372222409" == true do meditmaterials[1] = obj
	)
)



