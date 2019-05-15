-------------------------------------------------------------------------------
-- Felipe_AlioCam_Baker.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2013/06/18
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript AlioCam_Baker
category:"Felipe Scripts"
toolTip:"AlioCam Baker"
buttonText:"AlioCam Baker"
--icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true

(
pda_cams = #()
pda_zvc=#()
pda_cams = cameras as array
max time end
pda_end = sliderTime.frame as integer
max time start
pda_start = sliderTime.frame as integer
sliderTime = 0
i=1

for i=1 to pda_cams.count do if findstring pda_cams[i].name "ZVC" == 1 do if findstring pda_cams[i].name "tgt" == undefined do append pda_zvc pda_cams[i]
animate on
	for i=1 to pda_zvc.count do (
		Freecamera	fov: pda_zvc[i].fov targetDistance:(pda_zvc[i].targetDistance) isSelected:on name:("cam_bake_"+(pda_zvc[i].name)) nearclip:(pda_zvc[i].nearclip) farclip:(pda_zvc[i].farclip) nearrange:(pda_zvc[i].nearrange) farrange:(pda_zvc[i].farrange) mpassEnabled:off mpassRenderPerPass:off	
			for j=pda_start to pda_end do (
				at time j $.transform = pda_zvc[i].transform
				at time j $.fov = pda_zvc[i].fov
			)
		addModifier $ pda_zvc[i].modifiers[2]
		addModifier $ pda_zvc[i].modifiers[1]
	)
animate off

sliderTime = 0

)