-------------------------------------------------------------------------------
-- Felipe_Duplicator_exec.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( phda2000-fb@yahoo.fr)
-- 2014/04/17
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

-- Warning !! :
-- Don't launch this script as a standalone !!
-- It is just needed by "Felipe_Duplicator.mcr" but is useless if launched alone

(

	
	global dr = normalize (p1 - t1) -- détermine la direction entre 2 objets : déplacement de 1 unité de distance

	global pas = 10 -- division de la distance
	
	delete t2

	appendifunique pda_ar (dummy name:(pda_sel[1].name+"_01") pos:p1 boxSize:pda_bbox)
	
	fn deplacement r1 = 
	(
		dr*((distance t1 p1)/pas)*r1
	)
		
	
	rollout duplicator "duplicator"
	(
		label txt1 "Number of objects : "
		spinner nb "" type:#integer pos:[30,50] width:100 height:50 range:[1,1000,1]
		button myButton "Collapse"  width:100
		button CancelBtn "Cancel" width:100
		
		
		on CancelBtn pressed do
		(
			delete pda_ar
			select pda_sel
			destroyDialog duplicator
		)
		
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
				appendifunique pda_ar (dummy name:(pda_sel[1].name+"_0"+(i as string)) pos:(t1+deplacement(i)) boxSize:pda_bbox)
	 		)
		)
		
		on myButton pressed do
		(
			for i = 1 to pda_ar.count do 
			(
				maxOps.cloneNodes pda_sel cloneType:#instance newNodes:&n1
				select n1
				x=$.center
				append pda_place (dummy name:("temp_0"+(i as string)) pos:x boxSize:pda_bbox)
				select n1
				n2 = #()
				for j = 1 to n1.count do
				(
					if n1[j].parent == undefined do append n2 n1[j]
				)
				select n2
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

	destroyDialog duplicator 
	createDialog duplicator pos:[20,75]
	)
	
	
	




