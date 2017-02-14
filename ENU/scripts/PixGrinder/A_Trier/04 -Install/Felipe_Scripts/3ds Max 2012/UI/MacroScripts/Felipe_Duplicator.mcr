-------------------------------------------------------------------------------
-- Felipe_Duplicator.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( phda2000-fb@yahoo.fr)
-- 2014/04/17
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

-- Warning !! :
-- This script needs the 'side script' : "Felipe_Duplicator_exec.ms" to work correctly


macroScript Duplicator
category:"Felipe Scripts"
toolTip:"Duplicator"

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
				fileIn "C:\Program Files\Autodesk\3ds Max 2010\ui\macroscripts\Felipe_Duplicator_exec.ms"
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


