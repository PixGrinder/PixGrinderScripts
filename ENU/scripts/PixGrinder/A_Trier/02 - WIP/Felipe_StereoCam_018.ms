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
		pda_init = 50
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
	cam_right.fov.controller = pda_maincam.fov.controller
	cam_right.transform.controller.Roll_Angle.controller = pda_maincam.transform.controller.Roll_Angle.controller
	cam_right.target.parent = pda_maincam.target
	cam_right.position.controller = path follow:true
	cam_right.position.controller.path = myLine
	cam_right.position.controller.percent = 51
	deleteKeys cam_right.position.controller.percent.controller #allKeys



	global cam_left = Targetcamera name:(pda_name+"_left") fov:pda_fov nearclip:0 farclip:50 nearrange:0 farrange:50 mpassEnabled:off mpassRenderPerPass:off transform:pda_campos isSelected:on target:(Targetobject transform:pda_tgtpos)
	freeze cam_left.target
	freeze cam_left
	cam_left.fov.controller = pda_maincam.fov.controller
	cam_left.transform.controller.Roll_Angle.controller = pda_maincam.transform.controller.Roll_Angle.controller
	cam_left.target.parent = pda_maincam.target
	cam_left.position.controller = path follow:true
	cam_left.position.controller.path = myLine
	cam_left.position.controller.percent = 49
	deleteKeys cam_left.position.controller.percent.controller #allKeys

	select pda_maincam

	global pdamod = EmptyModifier () 
	pdamod.name = "StereoCam"
	addmodifier pda_maincam pdamod

	stereoCamCA = attributes stereoCam
	(
		rollout stereoCamRol "Custom Attribs"
		(
			
			label txt1 "Camera Offset :\r 50 = no 3D effect \r 100 = Full 3D effect" pos:[15,25] width:100 height:50 align:#center style_sunkenedge:true 
			spinner l "Camera Offset" type:#float pos:[35,75] width:100 height:20 range:[50,100,pda_init] controller:cam_right.position.controller.percent.controller
			spinner f "Camera FOV" type:#float pos:[35,100] width:100 height:20 range:[1,175,pda_maincam.fov] controller:pda_maincam.fov.controller
			button pda_img "Display result"
			button pda_select "Select Cameras"
			button pda_del "Delete cams"
			
			
			
			on l changed state do
			(
				cam_left.position.controller.percent = (100 - l.value)
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
				delete myLine
				deleteModifier pda_maincam pdamod
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




