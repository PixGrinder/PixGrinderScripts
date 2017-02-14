-------------------------------------------------------------------------------
-- Felipe_StereoCam.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2014/04/15
-- V3
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

--macroScript StereoCam
-- category:"Felipe Scripts"
-- toolTip:"StereoCam"
-- buttonText:"StereoCam"
-- icon:#("Felipe Scripts",10)
-- silentErrors:true
-- autoUndoEnabled:true

(
	
	if classof $ == Targetcamera then 
	(
		setAppData rootNode -101 ("$"+$.name)
		global pda_maincam = execute (getAppData rootNode -101)
		global pda_fov = pda_maincam.fov
		pda_campos = pda_maincam.transform
		pda_tgtpos = pda_maincam.target.transform
		pda_name=pda_maincam.name
		global x1=1
		global x2=1
		global pda_min = 1
		global pda_max= 10
		global pda_moy= 10
		
		
		pda_maincam.fov.controller = Bezier_Float()
		
		fn pda_vport =	
		(
			
			cam_status = hideByCategory.cameras
			light_status = hideByCategory.lights
			helpers_status = hideByCategory.helpers
			
			hideByCategory.cameras = true
			hideByCategory.lights = true
			hideByCategory.helpers = true
			
			viewport.setLayout #layout_4
			viewport.setGridVisibility #all false
			viewport.activeViewport = 1
			viewport.SetRenderLevel #smoothhighlights
			viewport.setCamera (execute (getAppData rootNode -104))
			max views redraw
			x1 = gw.getViewportDib()
			viewport.activeViewport = 3
			viewport.SetRenderLevel #smoothhighlights
			viewport.setCamera (execute (getAppData rootNode -103))
			max views redraw
			x2 = gw.getViewportDib()
			viewport.activeViewport = 2
			viewport.SetRenderLevel #smoothhighlights
			viewport.setCamera $cam_SharpZone
			max views redraw
			viewport.activeViewport = 4
			viewport.SetRenderLevel #smoothhighlights
			viewport.setCamera (execute (getAppData rootNode -101))
			max views redraw
			viewport.setType #view_persp_user
			max views redraw
			
			
			hideByCategory.cameras = cam_status
			hideByCategory.lights = light_status
			hideByCategory.helpers = helpers_status
			
		)
		
		
		fn drawLineBetweenTwoPoints pointA pointB =
		(
			ss = SplineShape pos:[0,0,0]
			addNewSpline ss
			addKnot ss 1 #corner #line PointA
			addKnot ss 1 #corner #line PointB
			updateShape ss
			ss
		)
		select geometry
		distance $.max $.min
		pda_moy = (pda_maincam.targetdistance)/100
		max select none
		myLine = drawLineBetweenTwoPoints [-pda_moy,0,0] [pda_moy,0,0]
		myLine.scale.controller = scalexyz()
		setAppData rootNode -102 ("$"+myLine.name)
		global myLine = execute (getAppData rootNode -102)
		myLine.transform = pda_maincam.transform
		myLine.parent = pda_maincam
		freeze myLine
		
		cam_right = Targetcamera name:(pda_name+"_right") fov:pda_fov nearclip:0 farclip:50 nearrange:0 farrange:50 mpassEnabled:off mpassRenderPerPass:off transform:pda_campos isSelected:on target:(Targetobject transform:pda_tgtpos) orthoProjection:false
		setAppData rootNode -103 ("$"+cam_right.name)
		global cam_right = execute (getAppData rootNode -103)
		freeze cam_right.target
		freeze cam_right
		cam_right.fov.controller = pda_maincam.fov.controller
		cam_right.transform.controller.Roll_Angle.controller = pda_maincam.transform.controller.Roll_Angle.controller
		cam_right.position.controller = path follow:true
		cam_right.position.controller.path = myLine
		cam_right.position.controller.percent = 100
		deleteKeys cam_right.position.controller.percent.controller #allKeys
		
		
		cam_left = Targetcamera name:(pda_name+"_left") fov:pda_fov nearclip:0 farclip:50 nearrange:0 farrange:50 mpassEnabled:off mpassRenderPerPass:off transform:pda_campos isSelected:on target:(Targetobject transform:pda_tgtpos) orthoProjection:false
		setAppData rootNode -104 ("$"+cam_left.name)
		global cam_left = execute (getAppData rootNode -104)
		freeze cam_left.target
		freeze cam_left
		cam_left.fov.controller = pda_maincam.fov.controller
		cam_left.transform.controller.Roll_Angle.controller = pda_maincam.transform.controller.Roll_Angle.controller
		cam_left.position.controller = path follow:true
		cam_left.position.controller.path = myLine
		cam_left.position.controller.percent = 0
		deleteKeys cam_left.position.controller.percent.controller #allKeys

		dummy boxsize:[320,180,0] name:"SharpZone" transform:pda_maincam.transform position:pda_maincam.target.position
		$SharpZone.parent = pda_maincam
		setTransformLockFlags $SharpZone #{1..2,4..9}
		cam_left.target.position = $SharpZone.position
		cam_left.target.parent = $SharpZone
		cam_right.target.position = $SharpZone.position
		cam_right.target.parent = $SharpZone
		freeze $SharpZone

		Freecamera name:"cam_SharpZone" orthoProjection:true fov:70 transform:$SharpZone.transform isSelected:off targetdistance:($SharpZone.boxsize.x*2) wirecolor:black
		in coordsys local rotate $cam_SharpZone (eulerAngles 0 90 0)
		in coordsys local move $cam_SharpZone [0,0,($SharpZone.boxsize.x)]
		$cam_SharpZone.parent = $SharpZone
		$cam_SharpZone.fov.controller = Bezier_Float()
		freeze $cam_SharpZone

		select pda_maincam

		global pdamod = EmptyModifier ()
		pdamod.name = "StereoCam"
		addmodifier pda_maincam pdamod
		addmodifier pda_maincam.target pdamod
		
		
		global stereoCamCA = attributes stereoCam
		(
			
			
			
			rollout stereoCamRol "Custom Attribs"
			(
				
				label txt1 "      ----------------------\r       Camera Offset :\r      ----------------------\r\r       0 = No 3D effect\r\r    500 = Full 3D effect" pos:[15,10] width:130 height:105 style_sunkenedge:true  offset:[10,0]
				spinner l "Camera Offset" type:#float pos:[35,125] width:100 height:20 range:[0,100000,100] controller:(execute (getAppData rootNode -102)).scale.x_scale.controller
				spinner f "Camera FOV" type:#float pos:[35,155] width:100 height:20 range:[1,175,(execute (getAppData rootNode -101)).fov] controller:(execute (getAppData rootNode -101)).fov.controller
				spinner s "SharpZone" type:#float pos:[35,185] width:100 height:20 range:[-1000000,1000000,$SharpZone.transform.pos.z] controller:$SharpZone.position.Z_Position.controller
				spinner dummy_w "SharpZone Width" type:#float pos:[35,215] width:100 height:20 range:[0,1000000,$SharpZone.boxsize.x]
				spinner dummy_h "SharpZone Height" type:#float pos:[35,245] width:100 height:20 range:[0,1000000,$SharpZone.boxsize.y]
				spinner dummy_l "SharpZone Length" type:#float pos:[35,275] width:100 height:20 range:[0,1000000,0]
				spinner dummy_fov "SharpZone FOV" type:#float pos:[35,305] width:100 height:20 range:[0,175,$cam_SharpZone.fov] controller:$cam_SharpZone.fov.controller
				button pda_img "Display result"
				button pda_select "Select Cameras"
				button pda_del "Delete cams"
					
				rollout t "Result"
				(
				)
					
					
				on l changed state do
				(
					(execute (getAppData rootNode -102)).scale.y = (execute (getAppData rootNode -102)).scale.x
					(execute (getAppData rootNode -102)).scale.z = (execute (getAppData rootNode -102)).scale.x
				)
				
				on pda_del pressed  do 
				(
					delete (execute (getAppData rootNode -104))
					delete (execute (getAppData rootNode -103))
					delete (execute (getAppData rootNode -102))
					delete $SharpZone
					delete $cam_SharpZone
					pda_x = ("deleteModifier "+getAppData rootNode -101+" "+getAppData rootNode -101+".modifiers[\"StereoCam\"]")
					pda_y = ("deleteModifier "+getAppData rootNode -101+".target "+getAppData rootNode -101+".target.modifiers[\"StereoCam\"]")
					execute pda_x
					execute pda_y
					if t.open == true do destroyDialog t
					-- select (execute (getAppData rootNode -101))
				)
				
				on pda_img pressed do
				(
					
					fn compfn c1 p1 c2 p2 = 
					(
							res = (c1*0.5 + c2*0.5)
							res
					)
						
					fn pda_vport =	
					(
						
						global cam_status = hideByCategory.cameras
						global light_status = hideByCategory.lights
						global helpers_status = hideByCategory.helpers
						
						hideByCategory.cameras = true
						hideByCategory.lights = true
						hideByCategory.helpers = true
						
						viewport.setLayout #layout_4
						viewport.setGridVisibility #all false
						viewport.activeViewport = 1
						viewport.SetRenderLevel #smoothhighlights
						viewport.setCamera (execute (getAppData rootNode -104))
						max views redraw
						global x1 = gw.getViewportDib()
						viewport.activeViewport = 3
						viewport.SetRenderLevel #smoothhighlights
						viewport.setCamera (execute (getAppData rootNode -103))
						max views redraw
						global x2 = gw.getViewportDib()
						viewport.activeViewport = 2
						viewport.SetRenderLevel #smoothhighlights
						viewport.setCamera $cam_SharpZone
						max views redraw
						viewport.activeViewport = 4
						viewport.SetRenderLevel #smoothhighlights
						viewport.setCamera (execute (getAppData rootNode -101))
						max views redraw
						viewport.setType #view_persp_user
						max views redraw
						
						
						hideByCategory.cameras = cam_status
						hideByCategory.lights = light_status
						hideByCategory.helpers = helpers_status
						
					)
					pda_vport()
					pastebitmap x1 x2 [0,0] [0,0] type:#function function:compfn
					-- display x2 pos:[10,10]
					
					if t.open == false then 
					(
						createDialog t bitmap:x2 width:x2.width height:x2.height 
					) else 
					(
						SetDialogBitmap t x2
					)
					select (execute (getAppData rootNode -101))
				)
				
				on pda_select pressed do
				(
				select #((execute (getAppData rootNode -101)), (execute (getAppData rootNode -103)), (execute (getAppData rootNode -104)))
				)
				
				on dummy_w changed state do
				(
					$SharpZone.boxsize.x = dummy_w.value
				)
							
				on dummy_h changed state do
				(
					$SharpZone.boxsize.y = dummy_h.value
				)				
				
				on dummy_l changed state do
				(
					$SharpZone.boxsize.z = dummy_l.value
				)
				
			)
		)
		
		custAttributes.add pda_maincam.modifiers["StereoCam"] stereoCamCA baseobject:false
		
		pda_vport()
		
		select pda_maincam
		
		max modify mode 
		
		
		
	) else (
		messageBox "You must have a single TargetCamera selected !" title:"Warning of the Dead" beep:true
	)


)





