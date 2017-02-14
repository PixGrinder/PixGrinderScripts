(
	--global bitmapName = getClassInstances BitmapTexture
	global pda = #()
	global pdamap = #()
	global pdadif = #()
	global pda_std = #()
	global pda_end = #()

	pda = getClassInstances Arch___Design__mi
	pda_std = getClassInstances Standardmaterial
	--for obj in geometry do appendifunique pda obj.material
	for obj in pda do appendifunique pdadif obj.mapM0
	for obj in pda_std do appendifunique pdadif obj.diffuseMap
	for obj in pdadif do if obj != undefined do 
	(
		pda_temp = getClassInstances BitmapTexture target:obj
		if classof pda_temp == array do 
		(
			for i = 1 to pda_temp.count do appendifunique pdamap pda_temp[i]
			
		)
		
		

		
		
	)


	try
		for i = 1 to pdamap.count do
		(
			for j = 1 to pda.count do
			(
				showTextureMap pda[j] pdamap[i] on
			)			
			for j = 1 to pda_std.count do
			(
				showTextureMap pda_std[j] pdamap[i] on
			)
		)
	catch ()

)



------------------------------------
x1 = #("test")
x1 = 1
x1[1]


x = getClassInstances BitmapTexture pdadif[1]


for obj in pdamap do print (classof obj)
pdamap[1][1].filename

for obj in pda do print (classof obj)

for obj in pda_std do print (classof obj)

for obj in pdadif do print (classof obj)

classof pda[1]

for obj in geometry do 
(
	if classof obj.material == Arch___Design__mi do 
	(
		if classof obj.material.mapM0 == Ambient_Reflective_Occlusion__3dsmax and classof
	)
	
)


showTextureMap bitmapName[1]



classof $.material.mapM0.bright_shader


