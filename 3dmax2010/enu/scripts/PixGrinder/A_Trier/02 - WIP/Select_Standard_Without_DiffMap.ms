(
	clearListener()
	x1 = for obj in objects where classof obj.material == StandardMaterial collect obj
	x2 = for obj in x1 where obj.material.diffuseMap == undefined collect obj
	x3 = for obj in x2 where matchpattern obj.name pattern:"ATA_*" == true collect obj
	select x3
)