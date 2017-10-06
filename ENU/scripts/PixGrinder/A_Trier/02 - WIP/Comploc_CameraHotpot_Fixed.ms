
(
	clearListener()
	ss = StringStream ""

	for obj in selection do
	(	
		oldEuler = obj.transform.rotation as eulerAngles
		oldEuler.x = oldEuler.x + 90.0
		oldEuler.y = oldEuler.y
		oldEuler.z = oldEuler.z
		oldEuler
		quat = eulerToQuat oldEuler
		format "%;%,%,%;%,%,%,%\r" obj.name (-0.1*obj.pos.x) (0.1*obj.pos.z) (-0.1*obj.pos.y) (floor(100*quat.x)/100) (floor(-100*quat.y)/100) (floor(100*quat.z)/100) (floor(-100*quat.w)/100)
	)
-- 	if hasTarget then cam.targeted = true

	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener

)


