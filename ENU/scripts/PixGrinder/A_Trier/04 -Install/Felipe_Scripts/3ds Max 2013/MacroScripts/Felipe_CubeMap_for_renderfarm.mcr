-------------------------------------------------------------------------------
-- Felipe_CubeMap_for_renderfarm.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2013/06/19
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript CubeMap_for_renderfarm
category:"Felipe Scripts"
toolTip:"CubeMap for renderfarm"

(
pda_cams = cameras as array
pda1 = eulerangles 0 90 0
pda2 = eulerangles 90 0 0

Freecamera fov:90 name:"cam_panorama" pos:[0,0,0] TargetDistance:1 isSelected:on 

slidertime=-1
animate on
for i=1 to pda_cams.count do 
	(
	slidertime+=1
	at time slidertime $cam_panorama.transform = pda_cams[i].transform
	slidertime+=1
	in coordsys local rotate $cam_panorama pda1
	$cam_panorama.pos=pda_cams[i].pos
	slidertime+=1
	in coordsys local rotate $cam_panorama pda1
	$cam_panorama.pos=pda_cams[i].pos	
	slidertime+=1
	in coordsys local rotate $cam_panorama pda1
	$cam_panorama.pos=pda_cams[i].pos	
	slidertime+=1
	in coordsys local rotate $cam_panorama pda1
	in coordsys local rotate $cam_panorama pda2
	$cam_panorama.pos=pda_cams[i].pos
	slidertime+=1
	in coordsys local rotate $cam_panorama pda2
	in coordsys local rotate $cam_panorama pda2
	$cam_panorama.pos=pda_cams[i].pos
	)


)



