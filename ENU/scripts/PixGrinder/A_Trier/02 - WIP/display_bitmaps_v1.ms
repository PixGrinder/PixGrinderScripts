(
	global bitmapName = getClassInstances BitmapTexture
	global pda = #()
	global pdamap = #()
	global pdadif = #()

	for obj in geometry do appendifunique pda obj.material
	for obj in pda do appendifunique pdadif obj.material.mapM0
	for obj in pdadif do pdamap = getClassInstances BitmapTexture target:obj
	


	try
		for i = 1 to bitmapName.count do
		(
			for j = 1 to pda.count do
			(
				showTextureMap pda[j] bitmapName[i] on
			)
		)
	catch ()

)



------------------------------------
for obj in geometry do 
(
	if classof obj.material == Arch___Design__mi do 
	(
		if classof obj.material.mapM0 == Ambient_Reflective_Occlusion__3dsmax and classof
	)
	
)


showTextureMap bitmapName[1]



classof $.material.mapM0.bright_shader


