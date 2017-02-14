(
	delete t2
	global pda_ar = #()
	global pda_place = #()
	global dr = normalize (p1 - t1) -- détermine la direction entre 2 objets : déplacement de 1 unité de distance

	global pas = 10 -- division de la distance

	fn deplacement r1 = 
	(
		dr*((distance t1 p1)/pas)*r1
	)

	appendifunique pda_ar (dummy name:(pda_sel[1].name+"_01") pos:p1)
	
	rollout duplicator "duplicator"
	(
		label txt1 "Number of objects : "
		spinner nb "" type:#integer pos:[30,50] width:50 height:50 range:[1,1000,1]
		button myButton "Collapse" 
		
		on nb changed state do 
		(
			delete pda_ar
			pda_ar = #()
			pas = nb.value
			fn deplacement r1 = 
			(
				dr*((distance t1 p1)/pas)*r1
			)
			for i = 1 to (nb.value) do
	 		(
				appendifunique pda_ar (dummy name:(pda_sel[1].name+"_0"+(i as string)) pos:(t1+deplacement(i)))
	 		)
		)
		
		on myButton pressed do
		(
			for i = 1 to pda_ar.count do 
			(
				maxOps.cloneNodes pda_sel cloneType:#copy newNodes:&n1
				select n1
				x=$.center
				append pda_place (dummy name:("temp_0"+(i as string)) pos:x)
				select n1
				$.parent = pda_place[i]
			)

			for i = 1 to pda_place.count do
			(
				pda_place[i].center = pda_ar[i].center
			)
			delete pda_ar
			delete pda_place
			destroyDialog duplicator
		)
		
	)

	if duplicator.open == true then destroyDialog duplicator else createDialog duplicator pos:[1180,100]
	
	
)




