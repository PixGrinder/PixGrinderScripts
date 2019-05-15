
if $ == undefined then messagebox"You must have at least 1 object selected" Title:"You got no selection for me" else
(
	global scx = systemTools.GetScreenWidth()
	global scy = systemTools.GetScreenheight()


	global dialog_witdh = 150
	global dialog_height = 175

	global pda_sel=#()
	global t2=#()

	global t1 = [0,0,0]
	


	if scx > 1920 then scx=(1920-dialog_witdh)/2 else scx = (scx-dialog_witdh)/2
	if scy > 1080 then scy=(1080-dialog_height)/2 else scy = (scy-dialog_height)/2

	pda_sel = getCurrentSelection()
	select pda_sel
	t1 = $.center
	maxOps.cloneNodes pda_sel cloneType:#copy newNodes:&t2
	select t2
	max move

	rollout msg "Move Warning"
	(
		label txtmsg1 "Please, move current selection.\r\rWhen ready, click the button to enter duplicate mode" pos:[10,20] width:130 height:100 style_sunkenedge:true align:#center
		button dpmode "DuplicateMode" offset:[0,10]
		
		on dpmode pressed do
		(
			select t2
			global p1 = $.center
			destroyDialog msg
			
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
			
			
		)
	)

	if msg.open == true then destroyDialog msg else createDialog msg pos:[scx,scy] width:dialog_witdh height:dialog_height

)

