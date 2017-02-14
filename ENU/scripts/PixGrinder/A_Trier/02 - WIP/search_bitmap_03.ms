
(

	global pda = #()
	global pdaname = #()

	fn scenemat =
	(
		for obj in objects do
		(
			if obj.material != undefined do 
			(
				if classof obj.material == standardmaterial do appendifunique pda obj.material
				
				if classof obj.material == multimaterial do 
				(
					for i = 1 to obj.material.count do
					(
						if classof obj.material[i] == standardmaterial do appendifunique pda obj.material[i]
					)
				)
			)
		)
	)

	scenemat()

	fn bmpsearch filename =
	(
		
			for i = 1 to pda.count do
			(
				if pda[i].diffusemap != undefined do 
				(
					pda_x = pda[i].diffusemap.bitmap as string
					if findstring pda_x filename != undefined do appendifunique pdaname pda[i]
				)
					
			)
			
			if pdaname.count < 24 then 
			(
				for j = 1 to pdaname.count do 
				(
					meditmaterials[j] = pdaname[j]
				)
			) 
			else 
			(
				for j = 1 to 24 do
				(
					meditmaterials[j] = pdaname[j]
				)
			)
			
	)
		
	
	
	rollout searchBmp "Search bitmap in scene materials" 
	(
		edittext bmpname "Search for this Bitmap in scene materials:" fieldWidth:200 labelOnTop:true
		button searchbtn "Search !" toolTip:"Search !" border:true
		on searchbtn pressed do
		(
			bmpsearch (bmpname.text)
			--testy (bmpname.text)
			DestroyDialog searchBmp
		)	
	)

	createDialog searchBmp 300 100

)

--------------------------------------------------------



	fn testy filename =
	(
		print filename
	)



scenemat()

pda
pdaname

x = $.material[1].diffusemap.bitmap as string

bmpname.text


findstring x "noir"


fn matsearch =
(
	
	for i = 1 to pda.count do
	(
		if findstring bmpname pda[i].diffusemap.bitmap  != undefined do appendifunique pdaname pda[i]
		
		
	)
	
	for j = 1 to 24 do meditmaterials[j] = pdaname[j]
	
)


meditmaterials[1] = pdaname[1]

