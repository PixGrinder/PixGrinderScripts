---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Section Perpendiculaire --
-- Section_Perpendiculaire.ms --
-- Use "Pivot Alignator" script before --
-- Creates a section normal to an object --
-- V 1.2 --
-- Mail : dassonphil@gmail.com --

---------------------------------------------------------------------

(
	clearListener()
	selection[1].layer.current = true -- 
	tempObject = selection[1]
	mySize = distance selection[1].min selection[1].max
	myDir = polyop.getFaceNormal selection[1] ((polyop.getFaceSelection selection[1]) as array)[1]
	myPos = polyop.getFaceCenter selection[1] ((polyop.getFaceSelection selection[1]) as array)[1]
	myRot = eulerangles 0.0 90.0 90.0
	x1 = section length:mySize width:mySize grid:10 isSelected:on
	x1.dir = myDir
	x1.pos = myPos
	select tempObject
	subobjectlevel = 0
	select x1
	in coordsys local(rotate x1 myRot)
	theSys = #local
	max rotate
	toolMode.coordsys theSys
	forceCompleteRedraw doDisabled:true


	/*
	convertToSplineShape x1
	numSplines x1
	subobjectlevel = 3





	*/

)