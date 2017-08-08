-- 
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- GetMatByName --
-- GetMatByName.ms --
-- search material name and open it in material editor --
-- V 0.1 --

---------------------------------------------------------------------
(
	myString = "white"
	theMats = getClassInstances StandardMaterial
	theResult = for obj in theMats where matchpattern obj.name pattern:("*"+myString+"*") == true and obj.diffusemap == undefined collect obj
	MatEditor.Open()
	for i = 1 to 24 do try (meditMaterials[i] = theResult[i]) catch()
)