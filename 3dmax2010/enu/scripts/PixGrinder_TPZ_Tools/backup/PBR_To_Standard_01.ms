-- PBR_To_Standard.ms --

clearListener()
colorMats = for obj in objects where classof obj.material == PhysicalMaterial and obj.material.base_color_map == undefined collect obj
BitmapMats = for obj in objects where classof obj.material == PhysicalMaterial and obj.material.base_color_map != undefined collect obj
myMult = for obj in objects where classof obj.material == Multimaterial collect obj
thePhys = getClassInstances PhysicalMaterial


for obj in thePhys do 
(
	--print obj.name
	myMat = StandardMaterial()
	for bla in colorMats do
	(
		if bla.material == obj do 
		(
			myMat.diffuse = obj.base_color
			bla.material = myMat
		)
	)
)


for obj in thePhys do 
(
	--print obj.name
	myMat = StandardMaterial()
	for bla in BitmapMats do
	(
		if bla.material == obj do 
		(
			myMat.diffuseMap = obj.base_color_map
			bla.material = myMat
		)
	)
)


for obj in thePhys do 
(
	myMat = StandardMaterial()
	for mtl in myMult do
	(
		for i = 1 to mtl.count do
		(
			if mtl[i] == obj do
			(
				myMat.diffuseMap = obj.base_color_map
				myMat.diffuseMap = obj.base_color_map
			)
		)
	)
)

