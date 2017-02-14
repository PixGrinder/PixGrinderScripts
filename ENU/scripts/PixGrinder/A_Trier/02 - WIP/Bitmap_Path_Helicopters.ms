-- Helicopters Projects - redirect Bitmaps --

(
	pda = getclassInstances bitmaptexture
	myPath = "..\..\..\Textures_Common"+"\\"
	for i = 1 to pda.count do
	(
		if pda[i].filename != undefined and (getFilenamePath pda[i].filename != myPath) do pda[i].filename = (myPath + "\\"+filenamefrompath pda[i].filename)
	)
)

-- getFilenamePath  meditmaterials[1].diffusemap.filename