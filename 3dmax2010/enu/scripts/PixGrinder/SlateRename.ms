-- SlateRename -- 

clearListener()

theMat = ((sme.getview 1).GetSelectedNodes())[1].reference


if classof theMat == Bitmaptexture and classof theMat.bitmap == Bitmap then theMat.name = (getFileNameFile theMat.bitmap.filename) + "_Bitmap"

if classof theMat == StandardMaterial then
(
	if theMat.diffuseMap != undefined and classof theMat.diffuseMap == Bitmaptexture and theMat.diffuseMap.bitmap != undefined then
	(
		theMat.name = getFileNameFile (theMat.diffuseMap.bitmap.filename) + "_Mtl"
	)	
)

if classof theMat == MultiMaterial then
(
	pda_matName = #()
	theMat.name = "Multi_" + theMat[1].name
	for i = 1 to theMat.count do
	(
		append pda_matName theMat[i].name
	)
	theMat.names = pda_matName
)


/* 
.names 

*/