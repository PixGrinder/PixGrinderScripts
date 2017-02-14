
if $ == undefined then messagebox"You must have at least 1 object selected" Title:"You got no selection for me" else
(
	global scx = systemTools.GetScreenWidth()
	global scy = systemTools.GetScreenheight()


	global dialog_witdh = 150
	global dialog_height = 175

	global pda_sel=#()

	global t1 = [0,0,0]


	if scx > 1920 then scx=(1920-dialog_witdh)/2 else scx = (scx-dialog_witdh)/2
	if scy > 1080 then scy=(1080-dialog_height)/2 else scy = (scy-dialog_height)/2

	pda_sel = getCurrentSelection()
	select pda_sel
	t1 = $.center
	maxOps.cloneNodes pda_sel cloneType:#copy newNodes:&pda_sel2
	select pda_sel2

	rollout msg "Move Warning"
	(
		label txtmsg1 "Please, move current selection.\r\rWhen ready, click the button to enter duplicate mode" pos:[10,20] width:130 height:100 style_sunkenedge:true align:#center
		button dpmode "DuplicateMode" offset:[0,10]
		
		on dpmode pressed do
		(
			select pda_sel2
			t2 = $.center
			destroyDialog msg
		)
	)

	if msg.open == true then destroyDialog msg else createDialog msg pos:[scx,scy] width:dialog_witdh height:dialog_height

)

