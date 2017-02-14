(
	global pda_ar = #()
	global pda_place = #()
	

	fn deplacement r1 = 
	(
		dr*((distance t1 p1)/pas)*r1
	)


	if $ == undefined then messagebox"You must have at least 1 object selected" Title:"You got no selection for me" else
	(
		global scx = systemTools.GetScreenWidth()
		global scy = systemTools.GetScreenheight()


		global dialog_witdh = 150
		global dialog_height = 200

		global pda_sel=#()
		global t2=#()

		global t1 = [0,0,0]
		


		if scx > 1920 then scx=(1920-dialog_witdh)/2 else scx = (scx-dialog_witdh)/2
		if scy > 1080 then scy=(1080-dialog_height)/2 else scy = (scy-dialog_height)/2

		global pda_sel = getCurrentSelection()
		l0 = pda_sel[1].layer
		l0.current = true
		select pda_sel
		global pda_bbox = [abs($.max.x-$.min.x),abs($.max.y-$.min.y),abs($.max.z-$.min.z)]
		
		t1 = $.center
		maxOps.cloneNodes pda_sel cloneType:#instance newNodes:&t2
		select t2
		max move

		rollout msg "Move Warning"
		(
			label txtmsg1 "1 - Move current selection.\r\r2 - Click \"DuplicateMode\"" pos:[10,20] width:130 height:100 style_sunkenedge:true align:#center
			button dpmode "DuplicateMode" offset:[0,10] width:100
			button cncl "Cancel" offset:[0,10] width:100
			
			on dpmode pressed do
			(
				select t2
				global p1 = $.center
				destroyDialog msg
				-- fileIn "C:\Program Files\Autodesk\3ds Max 2010\ui\macroscripts\Duplicator_exec.mse"
				
				
				
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
				
				
				
			)
			
			on cncl pressed do
			(
				delete t2
				select pda_sel
				destroyDialog msg
			)
			
		)

		destroyDialog msg
		createDialog msg pos:[20,75]
		)

)


