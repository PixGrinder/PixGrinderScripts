---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Section Perpendiculaire --
-- Section_Perpendiculaire.ms --
-- Use "Pivot Alignator" script before --
-- Creates a section normal to an object --
-- V 1.0 --
-- Mail : dassonphil@gmail.com --

---------------------------------------------------------------------

(
	myDir = selection[1].dir
	myPos = selection[1].center
	myRot = eulerangles 0.0 90.0 0.0
	x1 = section length:0.2 width:0.2 grid:10 isSelected:on
	x1.dir = myDir
	x1.pos = myPos
	in coordsys local(rotate x1 myRot)
	forceCompleteRedraw doDisabled:true
	convertToSplineShape x1
	numSplines x1
	subobjectlevel = 3
)