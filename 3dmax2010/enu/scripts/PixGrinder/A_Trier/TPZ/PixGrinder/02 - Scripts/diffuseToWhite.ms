(
	clearListener()
	Mats = getclassInstances StandardMaterial 
	for i = 1 to Mats.count do 
	(
		try 
		 (
			if classof Mats[i].diffusemap.bitmap != undefined do Mats[i].diffusecolor = color 255 255 255
		) catch ( print ((i as String) + " error : " + Mats[i].name))
			
	)
)

