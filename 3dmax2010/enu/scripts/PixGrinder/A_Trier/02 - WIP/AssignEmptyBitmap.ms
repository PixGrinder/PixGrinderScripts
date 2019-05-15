(
	matArray = getClassInstances StandardMaterial
	myMap = openBitMap "D:\Temp\gris128.png"

	for i = 1 to matArray.count do
	(
		if classof matArray[i].diffusemap != Bitmaptexture do matArray[i].diffusemap = Bitmaptexture()
		if matArray[i].diffusemap.bitmap == undefined do matArray[i].diffusemap.bitmap = myMap
	)
)

