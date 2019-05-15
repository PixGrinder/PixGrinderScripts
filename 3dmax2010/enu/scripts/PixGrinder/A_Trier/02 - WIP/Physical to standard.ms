-- Physical to standard --

clearListener()


mySimple = for obj in geometry where classof obj.material == PhysicalMaterial collect obj

-- for obj in mySimple do print obj.name
for obj in mySimple do 
(
	tmp1 = obj.material.base_color_map
	if tmp1 != undefined do 
	(
		obj.material = Standardmaterial diffuseMap:tmp1
	)
)



myMult = for obj in geometry where classof obj.material == Multimaterial collect obj

for obj in myMult do 
(
	for i = 1 to obj.material.count do
	(
		if classof obj.material[i] == PhysicalMaterial then
		(
			if obj.material[i].base_color_map != undefined do 
			(
				print obj.name
				print obj.material[i].name
				tmp2 = obj.material[i].base_color_map
				obj.material[i] = Standardmaterial diffuseMap:tmp2
			)
		)
	)
)

-- $.material = Standardmaterial diffuseMap:meditMaterials[1]
-- $.material.count