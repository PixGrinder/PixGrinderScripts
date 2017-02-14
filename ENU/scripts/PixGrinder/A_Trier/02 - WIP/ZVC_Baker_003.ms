pda_cams = #()
pda_zvc=#()
pda_cams = cameras as array
max time end
pda_end = sliderTime.frame as integer
max time start
pda_start = sliderTime.frame as integer
sliderTime = 0

for i=1 to pda_cams.count do if findstring pda_cams[i].name "ZVC" == 1 do if findstring pda_cams[i].name "tgt" == undefined do append pda_zvc pda_cams[i]
	
i=1
			animate on
for i=1 to pda_zvc.count do (
	Freecamera fov:(pda_zvc[i].fov) targetDistance:(pda_zvc[i].targetDistance) nearclip:(pda_zvc[i].nearclip) farclip:(pda_zvc[i].farclip) nearrange:(pda_zvc[i].nearrange) farrange:(pda_zvc[i].farrange) mpassEnabled:off mpassRenderPerPass:off pos:[0,0,0] isSelected:on name:("cam_bake_"+(pda_zvc[i].name))
		for j=pda_start to pda_end do (

			at time j $.pos = pda_zvc[i].pos
			-- at time j $.rotation =  in coordsys world pda_zvc[i].rotation 
			at time j $.fov = pda_zvc[i].fov


-- 			$.pos=pda_zvc[i].pos
-- 			$.fov=pda_zvc[i].fov
-- 			addNewKey $.pos.controller slidertime 
-- 			addNewKey $.fov.controller slidertime
-- 			sliderTime +=1
		)
	addModifier $ pda_zvc[i].modifiers[1]
	addModifier $ pda_zvc[i].modifiers[2]
)
			animate off


	sliderTime = 0
		



--- Brouillon
--------------





	