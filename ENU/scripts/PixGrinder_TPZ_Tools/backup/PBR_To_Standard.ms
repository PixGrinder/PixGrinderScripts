-- PBR_To_Standard.ms --

clearListener()
x1 = for obj in objects where classof obj.material == PhysicalMaterial collect obj
myMult = for obj in objects where classof obj.material == Multimaterial collect obj
thePhys = getClassInstances PhysicalMaterial


for obj in thePhys do
(
	if obj.base_color_map == undefined then 
	(
		myMat = Standardmaterial()
		myMat.diffuse = obj.Material.base_color
-- 		for bla in x1 where bla.material == obj do bla.material = myMat
		for bla in x1 where bla.material == obj do format "%    %" bla.material obj
	) 
)


/*
for obj in x1 do 
(
	myMat = Standardmaterial()
	if obj.Material.base_color_map == undefned then 
	(
		myMat.diffuse = obj.Material.base_color
	) else (
		myMat.diffuseMap = obj.Material.base_color_map
		obj.material = myMat
	)
)
*/
/*
for obj in MyMult do
(	
	for i = 1 to obj.material.count do
	(
		if classof obj.material[i] == PhysicalMaterial then
		(
			myMat = Standardmaterial()
			if obj.Material[i].base_color_map == undefned then 
			(
				myMat.diffuse = obj.Material[i].base_color
				obj.material[i] = myMat
			) else (
				myMat.diffuseMap = obj.Material[i].base_color_map
				obj.material[i] = myMat
			)
		)
	)
)


for bla in x1 do print bla.material

*/