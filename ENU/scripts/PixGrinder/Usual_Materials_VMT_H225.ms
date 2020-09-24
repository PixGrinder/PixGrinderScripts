-- Usual Materials -- 

max modify mode

--try(closeRolloutFloater UsualMatFloater) catch()

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

myPath = maxfilePath + @"\Materials_Pics\"

Rollout UsualMat "Usual Materials"
(
	imgTag BlackMetal "BlackMetal" tooltip:"ID 5" style:#bmp_center bitmap:(myPath+"Black_Metal.jpg") iconSize:[64,64] across:3  --[iconName:<filename>] [iconSize:<point2>] opacity:1.0 transparent:(color 0 0 0)
	imgTag BlackShine "BlackShine" tooltip:"ID 7" style:#bmp_center bitmap:(myPath+"Black_Shine.jpg") iconSize:[64,64]
	imgTag BlackMat "BlackMat" tooltip:"ID 6" style:#bmp_center bitmap:(myPath+"BlackMat.jpg") iconSize:[64,64]
	imgTag TresseNoir "TresseNoir" tooltip:"ID 504" style:#bmp_center bitmap:(myPath+"TresseNoir.jpg") iconSize:[64,64] across:3 
	imgTag kaki_color "kaki_color" tooltip:"ID 422" style:#bmp_center bitmap:(myPath+"kaki_color.jpg") iconSize:[64,64]
	imgTag Cntr_Kaki "Cntr_Kaki" tooltip:"ID 245" style:#bmp_center bitmap:(myPath+"Cntr_Kaki.jpg") iconSize:[64,64]
	imgTag Chrome "Chrome" tooltip:"ID 4" style:#bmp_center bitmap:(myPath+"Chrome.jpg") iconSize:[64,64] across:3
	imgTag PasVisChrome "PasVisChrome" tooltip:"ID 805" style:#bmp_center bitmap:(myPath+"PasVisChrome.jpg") iconSize:[64,64]
	imgTag metal9 "Metal 09" tooltip:"ID 9" style:#bmp_center bitmap:(myPath+"metal_09.jpg")  iconSize:[64,64]
	imgTag VisChromeTransp "VisChromeTransp" tooltip:"ID 13" style:#bmp_center bitmap:(myPath+"VisChromeTransp.jpg") iconSize:[64,64] across:3
	imgTag VisChromeNoAlpha "VisChromeNoAlpha" tooltip:"ID 315" style:#bmp_center bitmap:(myPath+"VisGrisOpaque.jpg") iconSize:[64,64]
	imgTag RedShine "RedShine" tooltip:"ID 18" style:#bmp_center bitmap:(myPath+"RedShine.jpg") iconSize:[64,64]
	imgTag VisCopperTransp "VisCopperTransp" tooltip:"ID 208" style:#bmp_center bitmap:(myPath+"VisCopperTransp.jpg") iconSize:[64,64] across:3
	imgTag VisCopperNoAlpha "VisCopperNoAlpha" tooltip:"ID 317" style:#bmp_center bitmap:(myPath+"VisCopper.jpg") iconSize:[64,64]
	imgTag Laiton "Laiton" tooltip:"ID 19" style:#bmp_center bitmap:(myPath+"Laiton.jpg")  iconSize:[64,64]
	imgTag BlackScrew "BlackScrew" tooltip:"ID 14" style:#bmp_center bitmap:(myPath+"BlackScrewAlpha.jpg") iconSize:[64,64] across:3
	imgTag BlackScrewNoAlpha "BlackScrewNoAlpha" tooltip:"ID 14" style:#bmp_center bitmap:(myPath+"BlackScrew.jpg") iconSize:[64,64]
	imgTag WhitePlastic "WhitePlastic" tooltip:"ID 91" style:#bmp_center bitmap:(myPath+"WhitePlastic.jpg") iconSize:[64,64] 
	imgTag Gris "Gris" tooltip:"ID 10" style:#bmp_center bitmap:(myPath+"Gris.jpg") iconSize:[64,64] across:3
	imgTag myGrid "myGrid" tooltip:"ID 104" style:#bmp_center bitmap:(myPath+"myGrid.jpg") iconSize:[64,64] 
	imgTag Yel01 "Yel01" tooltip:"ID 33" style:#bmp_center bitmap:(myPath+"Yel01.jpg") iconSize:[64,64]
	imgTag Yel04 "Yel04" tooltip:"ID 34" style:#bmp_center bitmap:(myPath+"Yel02.jpg") iconSize:[64,64] across:3
	imgTag CntrBlack "CntrBlack" tooltip:"ID 33" style:#bmp_center bitmap:(myPath+"CntrBlack.jpg") iconSize:[64,64]
	imgTag PasVisCopper "PasVisCopper" tooltip:"ID 321" style:#bmp_center bitmap:(myPath+"PasVisCopper.jpg") iconSize:[64,64]

	
	on BlackMetal mousedown do pda_ID_Mod 5
	on BlackShine mousedown do pda_ID_Mod 7
	on BlackMat mousedown do pda_ID_Mod 6
	on TresseNoir mousedown do pda_ID_Mod 504
	on kaki_color mousedown do pda_ID_Mod 422
	on Cntr_Kaki mousedown do pda_ID_Mod 245
	on Chrome mousedown do pda_ID_Mod 4
	on PasVisChrome mousedown do pda_ID_Mod 805
	on metal9 mousedown do pda_ID_Mod 9
	on VisChromeTransp mousedown do pda_ID_Mod 13
	on VisChromeNoAlpha mousedown do pda_ID_Mod 315
	on RedShine mousedown do pda_ID_Mod 18
	on VisCopperTransp mousedown do pda_ID_Mod 208
	on VisCopperNoAlpha mousedown do pda_ID_Mod 317
	on Laiton mousedown do pda_ID_Mod 19
	on BlackScrew mousedown do pda_ID_Mod 14
	on BlackScrewNoAlpha mousedown do pda_ID_Mod 316
	on WhitePlastic mousedown do pda_ID_Mod 91
	on Gris mousedown do pda_ID_Mod 10
	on myGrid mousedown do pda_ID_Mod 104
	on Yel01 mousedown do pda_ID_Mod 33
	on Yel04 mousedown do pda_ID_Mod 34
	on CntrBlack mousedown do pda_ID_Mod 24
	on PasVisCopper mousedown do pda_ID_Mod 321

	
	

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