---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Normal - Quick Flip Shortcut --
-- Normals_QuickFlip.ms --
-- Assign to Shift+N key to quickly flip one objects normals
-- V 0.1 --

---------------------------------------------------------------------

(
	myMod = Normalmodifier()
	myMod.flip = on
	for obj in selection where superclassof obj == GeometryClass do 
	(
		addModifier obj myMod
		collapseStack obj
	)
)

