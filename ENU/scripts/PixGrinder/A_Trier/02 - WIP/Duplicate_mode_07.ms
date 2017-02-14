
-- Boite 1


(

	if $ == undefined then messagebox"You must have at least 1 object selected" Title:"You got no selection for me" else
	(
		
		global pda_ar = #()
		global pda_place = #()
		
-- 		global scx = systemTools.GetScreenWidth()
-- 		global scy = systemTools.GetScreenheight()
		
		global dialog_witdh = 150
		global dialog_height = 200
		
		global pda_sel=#()
		global t2=#()
		
		global t1 = [0,0,0]
		global pas = 10 -- division de la distance
		
		global pda_sel = getCurrentSelection()
		select pda_sel
		global pda_bbox = [abs($.max.x-$.min.x),abs($.max.y-$.min.y),abs($.max.z-$.min.z)]
		
		t1 = $.center
		maxOps.cloneNodes pda_sel cloneType:#instance newNodes:&t2
		select t2
		max move
		
		
		
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
		
		
		rollout msg "Move Warning"
		(
			label txtmsg1 "Please, move current selection.\r\rWhen ready, click the button to enter duplicate mode" pos:[10,20] width:130 height:100 style_sunkenedge:true align:#center
			button dpmode "DuplicateMode" offset:[0,10] width:100
			button cncl "Cancel" offset:[0,10] width:100
			
			on dpmode pressed do
			(
				select t2
				global p1 = $.center
				destroyDialog msg
				global dr = normalize (p1 - t1) -- détermine la direction entre 2 objets : déplacement de 1 unité de distance
				delete t2
				appendifunique pda_ar (dummy name:(pda_sel[1].name+"_01") pos:p1 boxSize:pda_bbox)
				createDialog duplicator pos:mouse.pos
			)
			
			on cncl pressed do
			(
				delete t2
				select pda_sel
				destroyDialog msg
			)
			
		)
			
		fn deplacement r1 = 
		(
			dr*((distance t1 p1)/pas)*r1
		)
		
		
		if msg.open == true then destroyDialog msg else createDialog msg pos:mouse.pos width:dialog_witdh height:dialog_height
		
	)

)