(
	-- global t1 = $Teapot01
	-- global t2 = $Teapot02
	-- global p1 = $Teapot02.center
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
			-- appendifunique pda_ar (dummy name:(t1.name+"_01") pos:p1)
			pas = nb.value
			-- if pda_ar != #() do delete pda_ar
			for i = 1 to (nb.value) do
	 		(
				-- box pos:(t1.center+deplacement(i)) name:("MyBox"+i as string)
				appendifunique pda_ar (dummy name:(pda_sel[1].name+"_0"+(i as string)) pos:(t1+deplacement(i)))
	 		)
		)
		
		on myButton pressed do
		(
			for i = 1 to pda_ar.count do 
			(
				maxOps.cloneNodes pda_sel cloneType:#copy wirecolor:[random 1 250,random 1 250,random 1 250] newNodes:&t2
				append pda_place (copy t1 name:(pda_sel[1].name+"_0"+((i+1) as string)) wirecolor:[random 1 250,random 1 250,random 1 250])
			)

			for i = 1 to pda_place.count do
			(
				pda_place[i].center = pda_ar[i].center
			)
			delete pda_ar
			destroyDialog duplicator
		)
		
	)

	if duplicator.open == true then destroyDialog duplicator else createDialog duplicator pos:[1180,100]
	
	
)


	












x=4
for i = 1 to (4) do
(
	-- appendifunique pda_ar (dummy name:(t1.name+"_0"+(i as string)) pos:(t1.center+deplacement(i)))
	copy t1 name:(t1.name+"_0"+((i+1) as string)) center:(t1.center+deplacement(i)) wirecolor:[random 1 250,random 1 250,random 1 250]
)








---------------------------------



	

delete pda_ar
pda_ar = #()
append pda_ar (dummy pos:[0,0,0] name:"Avirer")
pda_ar.count