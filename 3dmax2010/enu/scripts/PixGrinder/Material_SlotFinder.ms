---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Material Slot Finder --
-- Finds 1st standard material usinf the BitmapTexture in the current Medit Slot --
-- V 1.0 --


---------------------------------------------------------------------


(
	myCondition = true
	activeSlot = medit.GetActiveMtlSlot()
	x1 = getClassInstances StandardMaterial
	x2 = for obj in x1 where classof obj.diffuseMap == Bitmaptexture collect obj

	if (classof (meditMaterials[activeSlot]) != BitmapTexture) then myCondition = false
	
	if myCondition == true then 
	(
		myResult = for obj in x2 where (obj.diffuseMap == meditMaterials[activeSlot]) collect obj
		meditMaterials[activeSlot] = myResult[1]
	) else (
		format "\rActive Slot doesn't contain a BitmapTexture\r"

	)
)


