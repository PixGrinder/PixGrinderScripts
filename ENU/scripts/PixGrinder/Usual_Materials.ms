-- Usual Materials -- 

max modify mode

try(DestroyDialog UsualMat) catch()

fn pda_ID_Mod Id = 
(
	myTemp = subobjectlevel
	subobjectlevel = 0	
	$.material = meditMaterials[1]
	subobjectlevel = myTemp
	myTemp = undefined
	if 	subobjectlevel == 4 or subobjectlevel == 5 then 
	(
		selection[1].EditablePoly.setMaterialIndex Id 1
	) else (
		modPanel.addModToSelection (Materialmodifier MaterialID:Id) 
		for obj in selection do 
		(
			obj.wirecolor = (color 87 225 87)
			convertToPoly obj
		)
	)
)

Rollout UsualMat "Usual Materials"
(
	imgTag Chrome "Chrome" tooltip:"ID 4" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Chrome.jpg" iconSize:[64,64] align:#center across:3 --[iconName:<filename>] [iconSize:<point2>] opacity:1.0 transparent:(color 0 0 0)
	imgTag VisGrisOpaque "VisGrisOpaque" tooltip:"ID 202" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\VisGrisOpaque.jpg" iconSize:[64,64] 	
	imgTag PasVisChrome "PasVisChrome" tooltip:"ID 805" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\PasVisChrome.jpg" iconSize:[64,64]
	imgTag metal9 "Metal 09" tooltip:"ID 9" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\metal_09.jpg"  iconSize:[64,64] across:3
	imgTag VisChromeTransp "VisChromeTransp" tooltip:"ID 13" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\VisChromeTransp.jpg" iconSize:[64,64] 
	imgTag RedShine "RedShine" tooltip:"ID 18" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\RedShine.jpg" iconSize:[64,64]
	imgTag Laiton "Laiton" tooltip:"ID 19" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Laiton.jpg"  iconSize:[64,64] across:3
	imgTag VisCopper "VisCopper" tooltip:"ID 213" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\VisCopper.jpg" iconSize:[64,64]
	imgTag PasVisCopper "PasVisCopper" tooltip:"ID 214" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\PasVisCopper.jpg" iconSize:[64,64]
	imgTag CockpitAtlas "CockpitAtlas" tooltip:"ID 684" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\CockpitAtlas.png" iconSize:[64,64] across:3
	imgTag BlackScrew "BlackScrew" tooltip:"ID 236" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\BlackScrew.jpg" iconSize:[64,64]
	imgTag BlackScrewAlpha "BlackScrewAlpha" tooltip:"ID 14" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\BlackScrewAlpha.jpg" iconSize:[64,64]
	imgTag BlackMetal "BlackMetal" tooltip:"ID 5" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Black_Metal.jpg" iconSize:[64,64] across:3
	imgTag BlackShine "BlackShine" tooltip:"ID 7" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Black_Shine.jpg" iconSize:[64,64]
	imgTag BlackMat "BlackMat" tooltip:"ID 6" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\BlackMat.jpg" iconSize:[64,64]
	imgTag WhitePlastic "WhitePlastic" tooltip:"ID 91" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\WhitePlastic.jpg" iconSize:[64,64] across:3
	imgTag Gris "Gris" tooltip:"ID 10" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Gris.jpg" iconSize:[64,64]
	imgTag LDG_DarkBlue "LDG_DarkBlue" tooltip:"ID 209" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\LDG_DarkBlue.jpg" iconSize:[64,64]
	imgTag Atlas_Etiq "Atlas_Etiq" tooltip:"ID 613" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Atlas_Etiq.jpg" iconSize:[64,64] across:3
	imgTag MGB "MGB" tooltip:"ID 85" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\MGB.jpg" iconSize:[64,64]
	imgTag BlueBattery "BlueBattery" tooltip:"ID 812" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\BlueBattery.jpg" iconSize:[64,64]
	imgTag AtlasMab "AtlasMab" tooltip:"ID 617" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Atlas_MAB.jpg" iconSize:[64,64] across:3
	imgTag CntrChrome "CntrChrome" tooltip:"ID 201" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\CntrChrome.jpg" iconSize:[64,64] 
	imgTag Cntr_Grip "Cntr_Grip" tooltip:"ID 72" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Cntr_Grip.jpg" iconSize:[64,64] 
	imgTag CableGreen "CableGreen" tooltip:"ID 64" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\CableGreen.jpg" iconSize:[64,64] across:3
	imgTag GripStick "GripStick" tooltip:"ID 30" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\GripStick.jpg" iconSize:[64,64] 
	imgTag ACE2 "ACE2" tooltip:"ID 225" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\ACE2.jpg" iconSize:[64,64]
	imgTag Pattern "Pattern" tooltip:"ID 171" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Pattern.jpg" iconSize:[64,64] across:3
	imgTag Purple "Purple" tooltip:"ID 86" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Purple.jpg" iconSize:[64,64]
	imgTag myGrid "myGrid" tooltip:"ID 104" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\myGrid.jpg" iconSize:[64,64]
	imgTag DarkMetal "DarkMetal" tooltip:"ID 671" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\DarkMetal.jpg" iconSize:[64,64] across:3
	imgTag myHole "myHole" tooltip:"ID 702" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Hole.jpg" iconSize:[64,64]
	imgTag Yel01 "Yel01" tooltip:"ID 33" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Yel01.jpg" iconSize:[64,64]
	imgTag Yel03 "Yel03" tooltip:"ID 809" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Yel04.jpg" iconSize:[64,64] across:3
	imgTag Yel04 "Yel04" tooltip:"ID 34" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Yel02.jpg" iconSize:[64,64]
	imgTag Yel02 "Yel02" tooltip:"ID 216" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Yel03.jpg" iconSize:[64,64]
	imgTag Braid "Braid" tooltip:"ID 71" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Braid.jpg" iconSize:[64,64] across:3
	imgTag BlackGrip "BlackGrip" tooltip:"ID 231" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\BlackGrip.jpg" iconSize:[64,64]
	imgTag myWind "myWind" tooltip:"ID 620" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\myWind.jpg" iconSize:[64,64]
	imgTag BrownCntr "BrownCntr" tooltip:"ID 97" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\BrownCntr.jpg" iconSize:[64,64] across:3
	imgTag BrownVertical "BrownVertical" tooltip:"ID 807" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\BrownVertical.jpg" iconSize:[64,64]
	imgTag BrownGrip "BrownGrip" tooltip:"ID 98" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\BrownGrip.jpg" iconSize:[64,64]

	
	on BlackShine mousedown do pda_ID_Mod 7
	on BlackMetal mousedown do pda_ID_Mod 5
	on Chrome mousedown do pda_ID_Mod 4
	on VisChromeTransp mousedown do pda_ID_Mod 13
	on VisGrisOpaque mousedown do pda_ID_Mod 202
	on PasVisCopper mousedown do pda_ID_Mod 214
	on PasVisChrome mousedown do pda_ID_Mod 805
	on VisCopper mousedown do pda_ID_Mod 213
	on Gris mousedown do pda_ID_Mod 10
	on LDG_DarkBlue mousedown do pda_ID_Mod 209
	on Laiton mousedown do pda_ID_Mod 19
	on AtlasMab mousedown do pda_ID_Mod 617
	on WhitePlastic mousedown do pda_ID_Mod 91
	on MGB mousedown do pda_ID_Mod 85
	on metal9 mousedown do pda_ID_Mod 9
	on BlackMat mousedown do pda_ID_Mod 6
	on RedShine mousedown do pda_ID_Mod 18
	on Atlas_Etiq mousedown do pda_ID_Mod 613
	on BlueBattery mousedown do pda_ID_Mod 812
	on CntrChrome mousedown do pda_ID_Mod 201
	on Cntr_Grip mousedown do pda_ID_Mod 72
	on CableGreen mousedown do pda_ID_Mod 64
	on GripStick mousedown do pda_ID_Mod 30
	on ACE2 mousedown do pda_ID_Mod 225
	on Pattern mousedown do pda_ID_Mod 171
	on Purple mousedown do pda_ID_Mod 86
	on myGrid mousedown do pda_ID_Mod 104
	on DarkMetal mousedown do pda_ID_Mod 671
	on myHole mousedown do pda_ID_Mod 702
	on Yel01 mousedown do pda_ID_Mod 33
	on Yel02 mousedown do pda_ID_Mod 216
	on Yel03 mousedown do pda_ID_Mod 809
	on Yel04 mousedown do pda_ID_Mod 34
	on Braid mousedown do pda_ID_Mod 71
	on BlackGrip mousedown do pda_ID_Mod 231
	on myWind mousedown do pda_ID_Mod 620
	on BlackScrew mousedown do pda_ID_Mod 236
	on BlackScrewAlpha mousedown do pda_ID_Mod 14
	on CockpitAtlas mousedown do pda_ID_Mod 684
	on BrownCntr mousedown do pda_ID_Mod 97
	on BrownVertical mousedown do pda_ID_Mod 807
	on BrownGrip mousedown do pda_ID_Mod 98

)


UsualMatFloater = newRolloutFloater "myMat" 260 500 lockHeight:off lockWidth:off autoLayoutOnResize:on
addRollout UsualMat UsualMatFloater


--CreateDialog UsualMat style:#(#style_resizing, #style_minimizebox, #style_toolwindow) --autoLayoutOnResize:on 260 400 1550 135

cui.RegisterDialogBar UsualMatFloater style:#(#cui_dock_all, #cui_floatable, #cui_handles) --minSize:[260,500] maxSize:[1024,1080]

cui.DockDialogBar UsualMatFloater #cui_dock_right

/*


select(for obj in geometry where obj.material != meditmaterials[1] collect obj)


cui.DockDialogBar <RolloutFloater_or_Rollout> <dockflag> 	 This method docks a registered dialog bar to the specified docking area. 

<RolloutFloater_or_Rollout> - This parameter must be a RolloutFloater created with NewRolloutFloater or a Rollout that has been installed in a dialog using CreateDialog, and has been registered using cui.RegisterDialogBar. 

<dockflag> - Specifies the area to dock the dialog bar to. 

Can be one of the following: 

#cui_dock_left - dock to the left 

#cui_dock_top - dock to the top 

#cui_dock_right - dock to the right 

#cui_dock_bottom - dock to the bottom 

NOTE:Attempting to set the <dockflag> to any other value than the listed above will cause unpredictable results. Always dock to one of the four sides. 





cui.RegisterDialogBar <RolloutFloater_or_Rollout> \ 
[minSize:<Point2>] [maxSize:<Point2>] \
[parent:<HWND>] \
[style:<Array>]



CreateDialog <Rollout> [<width> <height> <position_x> <position_y>]\ 
[pos:<Point2>] [width:<integer>] [height:<integer>] \ 
[bgcolor:<color>] [fgcolor:<color>] \ 
[bitmap:<bitmap>] {bmpstyle:<bmpstyle> \ 
[menu:<RCMenu>] [style:<array>] [modal:<boolean>] \ 
[escapeEnable:<boolean>] [lockHeight:<boolean>] [lockWidth:<boolean>] \
[autoLayoutOnResize:<boolean>] [parent:<HWND>]	 


UsualMat.pos
.setMaterialIndex 4
polyop.getFaceFlags $ 1
(getFaceSelection selection[1])
*/