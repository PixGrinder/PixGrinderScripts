---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Selected --
-- ListSelected.ms --
-- Outputs selected objects names in MaxScript listener --
-- added alphabetical sorting --
-- Improvement to come : Output in a text file ...   --
-- V 2.0 --

---------------------------------------------------------------------



(
	selNames = for obj in selection collect obj.name
	sort selNames
	actionMan.executeAction 0 "40472"
	clearListener()
-- 	for obj in selNames do format "%\r" obj
	for obj in selNames do format "%%" obj ", "
)

/*

$PArray001.Total_Number = 5000
$PArray001.Total_Number = 20000

for mtl in (getclassInstances PhysicalMaterial) do mtl.material_mode = 1



(
	x1 = getClassInstances PhysicalMaterial
	for obj in x1 do 
	(
		meditmaterials[1] = obj
		meditmaterials[1].material_mode = 1
		meditmaterials[1].roughness_inv = off
		meditmaterials[1].roughness = 0.8
		meditmaterials[1].reflectivity = 0.1
	)
)




meditMaterials[8].material1.material_mode = 1




*/


