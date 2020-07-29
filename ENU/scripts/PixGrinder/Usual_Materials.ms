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
	imgTag Chrome "Chrome" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Chrome.jpg" iconSize:[64,64] across:3 --[iconName:<filename>] [iconSize:<point2>] opacity:1.0 transparent:(color 0 0 0)
	imgTag VisGrisOpaque "VisGrisOpaque" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\VisGrisOpaque.jpg" iconSize:[64,64] 	
	imgTag PasVisChrome "PasVisChrome" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\PasVisChrome.jpg" iconSize:[64,64]
	imgTag metal9 "Metal 09" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\metal_09.jpg"  iconSize:[64,64]  across:3
	imgTag VisChromeTransp "VisChromeTransp" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\VisChromeTransp.jpg" iconSize:[64,64] 
	imgTag RedShine "RedShine" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\RedShine.jpg" iconSize:[64,64]
	imgTag Laiton "Laiton" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Laiton.jpg"  iconSize:[64,64]across:3
	imgTag VisCopper "VisCopper" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\VisCopper.jpg" iconSize:[64,64]
	imgTag PasVisCopper "PasVisCopper" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\PasVisCopper.jpg" iconSize:[64,64]
	imgTag BlackMetal "BlackMetal" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Black_Metal.jpg" iconSize:[64,64] across:3
	imgTag BlackShine "BlackShine" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Black_Shine.jpg" iconSize:[64,64]
	imgTag BlackMat "BlackMat" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\BlackMat.jpg" iconSize:[64,64]
	imgTag WhitePlastic "WhitePlastic" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\WhitePlastic.jpg" iconSize:[64,64] across:3
	imgTag Gris "Gris" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Gris.jpg" iconSize:[64,64]
	imgTag LDG_DarkBlue "LDG_DarkBlue" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\LDG_DarkBlue.jpg" iconSize:[64,64]
	imgTag Atlas_Etiq "Atlas_Etiq" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Atlas_Etiq.jpg" iconSize:[64,64] across:3
	imgTag MGB "MGB" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\MGB.jpg" iconSize:[64,64]
	imgTag BlueBattery "BlueBattery" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\BlueBattery.jpg" iconSize:[64,64]
	imgTag AtlasMab "AtlasMab" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Atlas_MAB.jpg" iconSize:[64,64] across:3
	imgTag CntrChrome "CntrChrome" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\CntrChrome.jpg" iconSize:[64,64] 
	imgTag Cntr_Grip "Cntr_Grip" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Cntr_Grip.jpg" iconSize:[64,64] 
	imgTag CableGreen "CableGreen" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\CableGreen.jpg" iconSize:[64,64] across:3
	imgTag GripStick "GripStick" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\GripStick.jpg" iconSize:[64,64] 
	imgTag ACE2 "ACE2" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\ACE2.jpg" iconSize:[64,64] 
	

	
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

)


CreateDialog UsualMat 260 600 1550 135


/*
UsualMat.pos
.setMaterialIndex 4
polyop.getFaceFlags $ 1
(getFaceSelection selection[1])
*/