(
	global t1 = $Teapot01
	global t2 = $Teapot02
	global pda_ar = #()

	global dr = normalize (t2.center - t1.center) -- détermine la direction entre 2 objets : déplacement de 1 unité de distance

	global pas = 10 -- division de la distance

	fn deplacement r1 = 
	(
		dr*((distance t1.center t2.center)/pas)*r1
	)

	-- box pos:t1.center name:"MyBox" isselected:true

	-- move $ (deplacement(1))

	-- on crée une boite nommée "MyBox"
	-- pos:(t1.center+..... position du 1er objet t1+ .....
	-- dr*....on multiplie 1 unité de distance par ...
	-- (distance t1.center t2.center)..... distance entre 1er et 2eme objet
	-- /pas)))   Et on divise par le pas.

		

	rollout duplicator "duplicator"
	(
		label txt1 "Number of objects : "
		spinner nb "" type:#integer pos:[30,50] width:50 height:50 range:[1,100,1]
		
	 	
		on nb buttondown do 
		(
			pda_ar
			for i = 1 to nb.value do
	 		(
				-- box pos:(t1.center+deplacement(i)) name:("MyBox"+i as string)
				--pas = nb.value
				append pda_ar (dummy name:(t1.name+"_0"+(i as string)) pos:(t1.center+deplacement(i)) )
	 		)
		)
		
		--on nb changed state do

	)

)


createDialog duplicator



---------------------------------

delete $MyBox*
	
	
x = $ as array
delete x
pda_ar = #()
append pda_ar (dummy pos:[0,0,0] name:"Avirer")
