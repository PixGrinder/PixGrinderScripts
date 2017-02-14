(
	global t1 = $Teapot01
	global t2 = $Teapot02
	global p1 = $Teapot02.center
	delete t2
	global pda_ar = #()

	global dr = normalize (p1 - t1.center) -- détermine la direction entre 2 objets : déplacement de 1 unité de distance

	global pas = 10 -- division de la distance

	fn deplacement r1 = 
	(
		dr*((distance t1.center p1)/pas)*r1
	)

	-- box pos:t1.center name:"MyBox" isselected:true

	-- move $ (deplacement(1))

	-- on crée une boite nommée "MyBox"
	-- pos:(t1.center+..... position du 1er objet t1+ .....
	-- dr*....on multiplie 1 unité de distance par ...
	-- (distance t1.center t2.center)..... distance entre 1er et 2eme objet
	-- /pas)))   Et on divise par le pas.

		appendifunique pda_ar (dummy name:(t1.name+"_0"+(i as string)) pos:p1)

	rollout duplicator "duplicator"
	(
		label txt1 "Number of objects : "
		spinner nb "" type:#integer pos:[30,50] width:50 height:50 range:[1,100,1]
		
	 	
		on nb buttondown do 
		(
			delete pda_ar
			pda_ar = #()
			pas = nb.value
			-- if pda_ar != #() do delete pda_ar
			for i = 1 to nb.value do
	 		(
				-- box pos:(t1.center+deplacement(i)) name:("MyBox"+i as string)
				appendifunique pda_ar (dummy name:(t1.name+"_0"+(i as string)) pos:(t1.center+deplacement(i)))
	 		)
		)
		
		--on nb changed state do

	)

)

if duplicator.open == true then destroyDialog duplicator


createDialog duplicator position:[10,10]



---------------------------------



	

delete pda_ar
pda_ar = #()
append pda_ar (dummy pos:[0,0,0] name:"Avirer")
pda_ar.count