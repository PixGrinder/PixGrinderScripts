(
	cam_status = hideByCategory.cameras
	light_status = hideByCategory.lights
	helpers_status = hideByCategory.helpers
	
	if classof $ == Targetcamera then 
	(
		pda_maincam = $
		pda_fov = $.fov
		pda_campos = $.transform
		pda_tgtpos = $.target.transform
		pda_name=$.name
		pda_init = 1
		global x1=1
		global x2=1
		
		pda_maincam.fov.controller = Bezier_Float()
		
		
		fn drawLineBetweenTwoPoints pointA pointB =

		(

		  ss = SplineShape pos:[0,0,0]

		  addNewSpline ss

		  addKnot ss 1 #corner #line PointA

		  addKnot ss 1 #corner #line PointB

		  updateShape ss

		  ss

		)

		myLine = drawLineBetweenTwoPoints [-10,0,0] [10,0,0]
		
		myLine.transform = pda_maincam.transform
		myLine.parent = pda_maincam
		freeze myLine
		
		fn compfn c1 p1 c2 p2 = 
		(
				res = (c1*0.5 + c2*0.5)
				res
		)
			
		fn pda_vport =	
		(
			hideByCategory.cameras = true
			hideByCategory.lights = true
			hideByCategory.helpers = true
			
			viewport.setLayout #layout_3vl
			viewport.setGridVisibility #all false
			viewport.activeViewport = 1
			viewport.SetRenderLevel #smoothhighlights
			viewport.setCamera cam_left
			viewport.activeViewport = 2
			viewport.SetRenderLevel #smoothhighlights
			viewport.setCamera cam_right
			max views redraw
			viewport.activeViewport = 1
			x1 = gw.getViewportDib()
			viewport.activeViewport = 2
			x2 = gw.getViewportDib()
			hideByCategory.cameras = cam_status
			hideByCategory.lights = light_status
			hideByCategory.helpers = helpers_status
			
		)
		
	global cam_right = Targetcamera name:(pda_name+"_right") fov:pda_fov nearclip:0 farclip:50 nearrange:0 farrange:50 mpassEnabled:off mpassRenderPerPass:off transform:pda_campos isSelected:on target:(Targetobject transform:pda_tgtpos)
	freeze cam_right.target
	freeze cam_right
	in coordsys pda_maincam cam_right.position = [pda_init,0,0]
	cam_right.fov.controller = pda_maincam.fov.controller

	cam_right.parent = pda_maincam 
	cam_right.target.parent = pda_maincam.target

	global cam_left = Targetcamera name:(pda_name+"_left") fov:pda_fov nearclip:0 farclip:50 nearrange:0 farrange:50 mpassEnabled:off mpassRenderPerPass:off transform:pda_campos isSelected:on target:(Targetobject transform:pda_tgtpos)
	freeze cam_left.target
	freeze cam_left
	in coordsys pda_maincam cam_left.position = [-pda_init,0,0]
	cam_left.fov.controller = pda_maincam.fov.controller

	cam_left.parent = pda_maincam 
	cam_left.target.parent = pda_maincam.target

	select pda_maincam

	pdamod = EmptyModifier () 
	pdamod.name = "StereoCam"
	addmodifier pda_maincam pdamod

	stereoCamCA = attributes stereoCam
	(
		rollout stereoCamRol "Custom Attribs"
		(
			spinner l "Camera Offset" type:#float pos:[35,20] width:100 height:20 range:[0,1000000,pda_init] controller:(Bezier_Float())
			spinner f "Camera FOV" type:#float pos:[35,45] width:100 height:20 range:[1,175,pda_maincam.fov] controller:pda_maincam.fov.controller
			button pda_img "Display result"
			button pda_select "Select Cameras"
			button pda_del "Delete cams"
			
			
			
			on l changed state do
			(
				in coordsys pda_maincam cam_right.position.x =  l.value
				in coordsys pda_maincam cam_left.position.x =  -l.value
			)
			
			
-- 			on f changed state do
-- 			(
-- 				cam_left.fov = pda_maincam.fov
-- 				cam_right.fov = pda_maincam.fov
-- 			)
			
			on pda_del pressed  do 
			(
				delete cam_left
				delete cam_right
				select pda_maincam
			)
			
			on pda_img pressed do
			(
				pda_vport()
				pastebitmap x1 x2 [0,0] [0,0] type:#function function:compfn
				-- display x2 pos:[10,10]
				
				rollout t "Result" 
				(
				)
				if t.open == false then 
				(
					createDialog t bitmap:x2 width:x2.width height:x2.height 
				) else 
				(
					SetDialogBitmap t x2
				)
				select pda_maincam
			)
			
			on pda_select pressed do
			(
			select #(pda_maincam, cam_left, cam_right)
			)
		)
	)

	custAttributes.add pda_maincam.modifiers["StereoCam"] stereoCamCA baseobject:false

	) else (
		messageBox "You must have a single TargetCamera selected !" title:"Warning of the Dead" beep:true
	)


)











-- Brouillon
--------------

line isselected:true

paramWire.connect pda_maincam.modifiers["StereoCam"].stereoCamRol.f  pda_maincam.fov.controller


pda_maincam.fov.controller
$Camera01.fov.controller



fn drawLineBetweenTwoPoints pointA pointB =

(

  ss = SplineShape pos:[0,0,0]

  addNewSpline ss

  addKnot ss 1 #corner #line PointA

  addKnot ss 1 #corner #line PointB

  updateShape ss

  ss

)

myLine = drawLineBetweenTwoPoints [-10,0,0] [10,0,0]




