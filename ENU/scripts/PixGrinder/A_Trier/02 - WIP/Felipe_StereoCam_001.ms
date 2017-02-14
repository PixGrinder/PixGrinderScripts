pda_maincam = $
pda_fov = $.fov
pda_campos = $.transform
pda_tgtpos = $.target.transform
pda_name=$.name
pda_init = 1


if classof $ == Targetcamera then 
(

cam_right = Targetcamera name:(pda_name+"_right") fov:pda_fov nearclip:0 farclip:50 nearrange:0 farrange:50 mpassEnabled:off mpassRenderPerPass:off transform:pda_campos isSelected:on target:(Targetobject transform:pda_tgtpos)
freeze cam_right.target
in coordsys pda_maincam cam_right.position = [pda_init,0,0]

cam_right.parent = pda_maincam 
cam_right.target.parent = pda_maincam.target


-- Brouillon

cam_left = Targetcamera name:(pda_name+"_left") fov:pda_fov nearclip:0 farclip:50 nearrange:0 farrange:50 mpassEnabled:off mpassRenderPerPass:off transform:pda_campos isSelected:on target:(Targetobject transform:pda_tgtpos)
freeze cam_left.target
in coordsys pda_maincam cam_left.position = [pda_init,0,0]

cam_left.parent = pda_maincam 
cam_left.target.parent = pda_maincam.target



rollout a "cam control" 
(
	spinner l "Camera Offset" type:#float pos:[20,35] width:100 height:20 range:[0,1000000,pda_init]
	

		on l changed state do
		(
			in coordsys pda_maincam cam_right.position =  [l.value,0,0]
			in coordsys pda_maincam cam_left.position =  [-l.value,0,0]
		)

	
)
createDialog a 150 120


) else (
	