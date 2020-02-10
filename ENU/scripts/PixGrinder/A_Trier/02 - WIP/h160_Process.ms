-- h160_Process --
(
	for obj in objects do obj.parent = undefined
	delete helpers
	delete cameras
	with redraw off
	(
		myDummy = dummy pos:[0,0,0]
		--try myDummy.name = (substring maxFileName 1 4) catch ()

		myTempAr = for obj in objects where obj.parent == undefined and obj != myDummy collect obj
		for obj in myTempAr do obj.parent = myDummy
			
		myDummy.pos = myDummy.pos + [-0.1,0.0,-1.61]
		myDummy.scale *= 10.0
		myRot = (eulerAngles 0.0 3.0 0.0)
		myDummy.rotation = myRot
		delete myDummy
	)
	forceCompleteRedraw 

	for obj in objects do ResetXForm obj
	-- for obj in objects do convertToPoly obj
)

/*
scale x10
rotation y = 3°
position z = -1.61
position x = -0.1
*/

