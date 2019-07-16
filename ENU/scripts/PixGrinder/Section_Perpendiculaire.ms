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
	selection[1].layer.current = true -- Set selected object layer as current
	tempObject = selection[1] -- memorize selected object
	mySize = distance selection[1].min selection[1].max -- get object size to set the section object size later
	myDir = polyop.getFaceNormal selection[1] ((polyop.getFaceSelection selection[1]) as array)[1] -- get selected face normal as orientation for the section object
	myPos = polyop.getFaceCenter selection[1] ((polyop.getFaceSelection selection[1]) as array)[1] -- get selected face center as position for the section object
	myRot = eulerangles 0.0 90.0 90.0 -- Rotation to apply to the section object after creation
	x1 = section length:mySize width:mySize grid:10 isSelected:on -- create section object
	x1.dir = myDir -- set section orientation using vector
	x1.pos = myPos -- set section position
	select tempObject -- set subobject level of initial object 
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