

(

global pda_maincam = execute (getAppData rootNode -101)

custAttributes.delete pda_maincam.modifiers["StereoCam"] 1
custAttributes.delete pda_maincam.target.modifiers["StereoCam"] 1



$cam_SharpZone.fov.controller = Bezier_Float()


		global stereoCamCA = attributes stereoCam
		(
			
			
			
			rollout stereoCamRol "Custom Attribs"
			(
				
				label txt1 "      ----------------------\r       Camera Offset :\r      ----------------------\r\r       50 = No 3D effect\r\r    100 = Full 3D effect" pos:[15,10] width:130 height:105 style_sunkenedge:true  offset:[10,0]
				spinner l "Camera Offset" type:#float pos:[35,125] width:100 height:20 range:[50,100,51] controller:(execute (getAppData rootNode -103)).position.controller.percent.controller
				spinner f "Camera FOV" type:#float pos:[35,155] width:100 height:20 range:[1,175,(execute (getAppData rootNode -101)).fov] controller:(execute (getAppData rootNode -101)).fov.controller
				spinner s "SharpZone" type:#float pos:[35,185] width:100 height:20 range:[-1000000,1000000,$SharpZone.transform.pos.z] controller:$SharpZone.position.Z_Position.controller
				spinner dummy_w "SharpZone Width" type:#float pos:[35,215] width:100 height:20 range:[0,1000000,$SharpZone.boxsize.x]
				spinner dummy_h "SharpZone Height" type:#float pos:[35,245] width:100 height:20 range:[0,1000000,$SharpZone.boxsize.y]
				spinner dummy_l "SharpZone Length" type:#float pos:[35,275] width:100 height:20 range:[0,1000000,$SharpZone.boxsize.z]
				spinner dummy_fov "SharpZone FOV" type:#float pos:[35,305] width:100 height:20 range:[0,175,$cam_SharpZone.fov] controller:$cam_SharpZone.fov.controller
				button pda_img "Display result"
				button pda_select "Select Cameras"
				button pda_del "Delete cams"
					
				rollout t "Result"
				(
				)
					
					
				on l changed state do
				(
					(execute (getAppData rootNode -104)).position.controller.percent = (100 - l.value)
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
custAttributes.add pda_maincam.target.modifiers["StereoCam"] stereoCamCA baseobject:false
)

