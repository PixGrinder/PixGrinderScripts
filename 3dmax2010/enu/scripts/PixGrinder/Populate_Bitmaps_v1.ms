
-- Populate Bitmaps

(

	clearListener()

	btMaps = getclassinstances Bitmaptexture
	sTd	= getclassinstances StandardMaterial
	
	for i = 1 to sTd.count do 
	(
		for j = 1 to btMaps.count do
		(
			if sTd[i].diffusemap != undefined and classof sTd[i].diffusemap == Bitmaptexture and sTd[i].diffusemap.filename != undefined do
			(
				if  filenameFromPath sTd[i].diffusemap.filename == filenameFromPath btMaps[j].filename do 
				(
					sTd[i].diffusemap = btMaps[j]
					try (i = i+1) catch ()
				)
			)
		)
	)
	
	for i = 1 to btMaps.count do print btMaps[i]
	
	
	x1 = getclassinstances Bitmaptexture
	x1.count
	
	for i = 1 to pda.count do appendifunique pda2 pda[i]
	pda2.count
	
	for i = 1 to pda2.count do
	(
		for j = 1 to pda2.count do
		(
			if 
		)
	)
	
	pda2[i]
	
)

classof meditmaterials[1]
---------------------------------
x1[1] = x1[4]


i = 2 
---------------------------------
