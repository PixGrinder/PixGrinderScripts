pda_cams = #()
pda_zvc=#()
pda_cams = cameras as array
max time end
pda_end = sliderTime.frame as integer
max time start
pda_start = sliderTime.frame as integer
sliderTime = 0

for i=1 to pda_cams.count do if findstring pda_cams[i].name "ZVC" == 1 do if findstring pda_cams[i].name "tgt" == undefined do append pda_zvc pda_cams[i]
	

-- for i=1 to pda_zvc.count do print pda_zvc[i].name

for i=1 to pda_zvc.count do (
	Freecamera fov:(pda_zvc[i].fov) targetDistance:(pda_zvc[i].targetDistance) nearclip:(pda_zvc[i].nearclip) farclip:(pda_zvc[i].farclip) nearrange:(pda_zvc[i].nearrange) farrange:(pda_zvc[i].farrange) mpassEnabled:off mpassRenderPerPass:off pos:[0,0,0] isSelected:on name:("cam_bake_"+(pda_zvc[i].name))
	-- $.pos.controller = Position_Constraint()
	-- $.pos.controller.appendTarget pda_zvc[i] 100
	-- $.rotation.controller = Orientation_Constraint()
	-- $.rotation.controller .appendTarget pda_zvc[i] 100
	addModifier $ pda_zvc[i].modifiers[1]
	addModifier $ pda_zvc[i].modifiers[2]
	set animate on
		for j=pda_start to pda_end do (
			$.pos=pda_zvc[i].pos
			-- $.rotation.controller.x_rotation=pda_zvc[i].rotation.controller.x_rotation
			-- $.rotation.controller.y_rotation=pda_zvc[i].rotation.controller.y_rotation
			-- $.rotation.controller.z_rotation=pda_zvc[i].rotation.controller.z_rotation
			$.fov=pda_zvc[i].fov
			sliderTime +=1
			-- sleep 1
		)
	set animate off
	sliderTime = 0
)



--- Brouillon
--------------


addModifier $  $ZVC_36487186_subCam_Cam008.modifiers[1]


$.targetDistance



j=5
j=j as string

Freecamera fov:60 targetDistance:1 nearclip:1 farclip:1000 nearrange:0 farrange:1000 mpassEnabled:off mpassRenderPerPass:off pos:[0,0,0] isSelected:on name:("youpi"+j)
	
$.pos.controller = Position_Constraint()
$.pos.controller.appendTarget $sphere01 100
$.rotation.controller = Orientation_Constraint()
$.rotation.controller .appendTarget $sphere01 100