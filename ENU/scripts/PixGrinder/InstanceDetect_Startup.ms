-- Instance Detector -- 

rollout myInst "Instances"
(
	label lbl1 "Object has instances !!"
	button myBtn "OK"

	on myBtn pressed do (try (DestroyDialog myInst ) catch ())
)


fn myInstTest =
(
	if (selection.count > 0) and (InstanceMgr.GetInstances selection[1] &instances > 1) then 
	(
		try (DestroyDialog myInst ) catch ()
		CreateDialog myInst 150 50 1700 250
	) else (
		try (DestroyDialog myInst ) catch ()
	)
)

callbacks.addScript #selectionSetChanged "myInstTest()" id:#pixGrinder_InstTest  persistent:false


/*
callbacks.removeScripts #selectionSetChanged id:#pixGrinder_InstTest

*/