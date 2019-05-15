-- PBR_To_Standard.ms --

clearListener()
PhysObjects = for obj in objects where (classof obj.material == PhysicalMaterial) collect obj
myMult = for obj in objects where (classof obj.material == Multimaterial) collect obj
thePhys = getClassInstances PhysicalMaterial


for obj in thePhys do 
(
	--print obj.name
	myMat = StandardMaterial()
	for bla in PhysObjects do
	(
		if bla.material == obj do 
		(
			myMat.diffuse = obj.base_color
			myMat.diffuseMap = obj.base_color_map
			myMat.opacity = (1-obj.transparency)*100
			bla.material = myMat
		)
	)
)





for obj in thePhys do 
(
	myMat = StandardMaterial()
	for mtl in myMult do
	(
		for i = 1 to mtl.material.count do
		(
			if mtl.material[i] == obj do
			(
				myMat.diffuseMap = obj.base_color_map
				myMat.diffuse = obj.base_color
				myMat.opacity = (1-obj.transparency)*100
				mtl.material[i] = myMat
			)
		)
	)
)
