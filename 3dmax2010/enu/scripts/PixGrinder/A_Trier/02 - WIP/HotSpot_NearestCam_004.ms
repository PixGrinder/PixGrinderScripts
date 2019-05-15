(
	clearListener()

	myHotspots = for cam in cameras where cam.name[1] == "H" collect cam

	myTaggedObjects = for obj in objects where custAttributes.count obj != 0 and obj.compLoc.hotspot != undefined collect obj
	myTagMod = for obj in myTaggedObjects where matchpattern obj.compLoc.hotspot.name pattern:"*_HFreeN" == true collect obj
	myWorkObj = for obj in myTagMod where obj.compLoc.hotspot.fov == 40.0 collect obj

	

	for obj in objects do obj.isHidden = true
	for obj in myWorkObj do obj.isHidden = false

	
)


----------------------------

-- Sort Cam distances


	myNode = $

	myAr = for obj in myHotspots collect #(obj, distance myNode obj)


	fn myComp v1 v2 = 
	(
		if v1[2] > v2[2] then return 1 else return -1
	)

	qsort myAr myComp