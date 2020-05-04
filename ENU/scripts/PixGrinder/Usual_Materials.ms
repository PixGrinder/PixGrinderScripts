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
	imgTag Chrome "Chrome" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Chrome.jpg"  iconSize:[64,64] --[iconName:<filename>] [iconSize:<point2>] opacity:1.0 transparent:(color 0 0 0)
	imgTag Laiton "Laiton" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Laiton.jpg"  iconSize:[64,64] --[iconName:<filename>] [iconSize:<point2>] opacity:1.0 transparent:(color 0 0 0)
	--imgTag White "White" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\White.jpg"  iconSize:[64,64] --[iconName:<filename>] [iconSize:<point2>] opacity:1.0 transparent:(color 0 0 0)
	imgTag WhitePlastic "WhitePlastic" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\WhitePlastic.jpg"  iconSize:[64,64] --[iconName:<filename>] [iconSize:<point2>] opacity:1.0 transparent:(color 0 0 0)
	imgTag Gris "Gris" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Gris.jpg"  iconSize:[64,64] --[iconName:<filename>] [iconSize:<point2>] opacity:1.0 transparent:(color 0 0 0)
	imgTag BlackShine "BlackShine" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Black_Shine.jpg"  iconSize:[64,64] --[iconName:<filename>] [iconSize:<point2>] opacity:1.0 transparent:(color 0 0 0)
	imgTag GrisDark "GrisDark" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\GrisDark.jpg"  iconSize:[64,64] --[iconName:<filename>] [iconSize:<point2>] opacity:1.0 transparent:(color 0 0 0)
	imgTag MGB "MGB" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\MGB.jpg"  iconSize:[64,64]
	imgTag Stickers "Stickers" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Stickers.jpg"  iconSize:[64,64] --[iconName:<filename>] [iconSize:<point2>] opacity:1.0 transparent:(color 0 0 0)
	imgTag Unkown "Unkown" style:#bmp_center bitmap:@"D:\Travail\SVN3D_H160\H160_Comploc\MAX\COMPLOC_FILES\Materials Screenshots\Unkown.jpg"  iconSize:[64,64] --[iconName:<filename>] [iconSize:<point2>] opacity:1.0 transparent:(color 0 0 0)
	

	
	on BlackShine mousedown do pda_ID_Mod 7
	on Chrome mousedown do pda_ID_Mod 4
	-- on Grille mousedown do pda_ID_Mod 305
	on Gris mousedown do pda_ID_Mod 10
	on GrisDark mousedown do pda_ID_Mod 43
	on Laiton mousedown do pda_ID_Mod 19
	on Stickers mousedown do pda_ID_Mod 173
	-- on Livery mousedown do pda_ID_Mod 1
	on WhitePlastic mousedown do pda_ID_Mod 91
	on MGB mousedown do pda_ID_Mod 85
	on Unkown mousedown do pda_ID_Mod 999

)


CreateDialog UsualMat 100 700 1550 135


/*
UsualMat.pos
.setMaterialIndex 4
polyop.getFaceFlags $ 1
(getFaceSelection selection[1])
*/