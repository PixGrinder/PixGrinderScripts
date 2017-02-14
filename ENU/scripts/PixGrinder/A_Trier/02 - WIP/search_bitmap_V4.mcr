-- Felipe Search bitmap Script
------------------------------------

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

	fn bmpsearch pda_fname =
	(
		
			for i = 1 to pda.count do
			(
				if pda[i].diffusemap != undefined do 
				(
					pda_x = pda[i].diffusemap.filename
					if findstring pda_x pda_fname != undefined do appendifunique pdaname pda[i]
				)
					
				if pda[i].ambientMap != undefined do 
				(
					pda_x = pda[i].ambientMap.filename
					if findstring pda_x pda_fname != undefined do appendifunique pdaname pda[i]
				)
					
				if pda[i].specularMap != undefined do 
				(
					pda_x = pda[i].specularMap.filename
					if findstring pda_x pda_fname != undefined do appendifunique pdaname pda[i]
				)
					
				if pda[i].specularLevelMap != undefined do 
				(
					pda_x = pda[i].specularLevelMap.filename
					if findstring pda_x pda_fname != undefined do appendifunique pdaname pda[i]
				)
					
				if pda[i].glossinessMap != undefined do 
				(
					pda_x = pda[i].diffusemap.filename
					if findstring pda_x pda_fname != undefined do appendifunique pdaname pda[i]
				)
					
				if pda[i].selfIllumMap != undefined do 
				(
					pda_x = pda[i].selfIllumMap.filename
					if findstring pda_x pda_fname != undefined do appendifunique pdaname pda[i]
				)
					
				if pda[i].opacityMap != undefined do 
				(
					pda_x = pda[i].opacityMap.filename
					if findstring pda_x pda_fname != undefined do appendifunique pdaname pda[i]
				)
					
				if pda[i].filterMap != undefined do 
				(
					pda_x = pda[i].filterMap.filename
					if findstring pda_x pda_fname != undefined do appendifunique pdaname pda[i]
				)
					
				if pda[i].bumpMap != undefined do 
				(
					pda_x = pda[i].bumpMap.filename
					if findstring pda_x pda_fname != undefined do appendifunique pdaname pda[i]
				)
					
				if pda[i].reflectionMap != undefined do 
				(
					pda_x = pda[i].reflectionMap.filename
					if findstring pda_x pda_fname != undefined do appendifunique pdaname pda[i]
				)
					
				if pda[i].refractionMap != undefined do 
				(
					pda_x = pda[i].refractionMap.filename
					if findstring pda_x pda_fname != undefined do appendifunique pdaname pda[i]
				)
					
				if pda[i].displacementMap != undefined do 
				(
					pda_x = pda[i].displacementMap.filename
					if findstring pda_x pda_fname != undefined do appendifunique pdaname pda[i]
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
			macros.run "Medit Tools" "clear_medit_slots"
			bmpsearch (bmpname.text)
			--testy (bmpname.text)
			DestroyDialog searchBmp
		)	
	)

	createDialog searchBmp 300 100

)





