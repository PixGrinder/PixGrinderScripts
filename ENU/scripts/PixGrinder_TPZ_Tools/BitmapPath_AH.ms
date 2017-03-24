-- Helicopters Projects - redirect Bitmaps --
-- v2.0 --



(
	pda = getclassInstances bitmaptexture
	
	fn assignPath myPath =
	(
		for i = 1 to pda.count do
		(
			if pda[i].filename != undefined and (getFilenamePath pda[i].filename != myPath) do pda[i].filename = (myPath + "\\"+filenamefrompath pda[i].filename)
		)

	)

	rollout myCustPath "Choose Path"
	(
		label theLabel "Choose path to commit bitmaps to" offset:[0,5] align:#center
		edittext thePath text:("..\..\..\Textures_Common"+"\\") fieldWidth:250 align:#center offset:[0,5]
		button comitPath "OK" offset:[0,5] width:75
		on comitPath pressed do assignPath thePath.text 
	)

	createDialog myCustPath 350 100 1024 256
)

-- getFilenamePath  meditmaterials[1].diffusemap.filename


-- edittext <name> [ <caption> ] [text:<string>] [fieldWidth:<integer>] [height:<integer>] [bold:<boolean>] [labelOnTop:<boolean>] [readOnly:<boolean>]