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

cam_right.parent = pda_maincam 
cam_right.target.parent = pda_maincam.target

global cam_left = Targetcamera name:(pda_name+"_left") fov:pda_fov nearclip:0 farclip:50 nearrange:0 farrange:50 mpassEnabled:off mpassRenderPerPass:off transform:pda_campos isSelected:on target:(Targetobject transform:pda_tgtpos)
freeze cam_left.target
freeze cam_left
in coordsys pda_maincam cam_left.position = [-pda_init,0,0]

cam_left.parent = pda_maincam 
cam_left.target.parent = pda_maincam.target

select pda_maincam




rollout a "cam control" 
(
	spinner l "Camera Offset" type:#float pos:[35,20] width:100 height:20 range:[0,1000000,pda_init]
	spinner f "Camera FOV" type:#float pos:[35,45] width:100 height:20 range:[1,175,45]
	button pda_img "Display result"
	
	button pda_select "Select Cameras"
	
	button pda_del "Delete cams"
	

		on l changed state do
		(
			in coordsys pda_maincam cam_right.position =  [l.value,0,0]
			in coordsys pda_maincam cam_left.position =  [-l.value,0,0]
		)
		
		on f changed state do
		(
			pda_maincam.fov = f.value
			cam_left.fov = f.value
			cam_right.fov = f.value
		)
		
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
		)
		
		on pda_select pressed do
		(
			select #(pda_maincam, cam_left, cam_right)
		)
		
	
)
createDialog a 150 300

) else (
	
	messageBox "You must have a single TargetCamera selected !" title:"Warning of the Dead" beep:true

)


)





































-- Brouillon
--------------
$.targetdistance

viewport.setLayout #layout_3vl

viewport.activeViewport = 1

viewport.setCamera cam_left
x1 = gw.getViewportDib()


viewport.activeViewport = 2

viewport.setCamera cam_right
x2 = gw.getViewportDib()

------------------------------

fn compfn c1 p1 c2 p2 = 

(

res = (c1*0.5 + c2*0.5) --the result will contain the G and B of b2

-- res.r = c1.r*0.5 --but the R from b1

res --then we return the resulting color value

)

 

--Perform the compositing using the above function:

pastebitmap x1 x2 [0,0] [0,0] type:#function function:compfn

display x2

-- undisplay x2


