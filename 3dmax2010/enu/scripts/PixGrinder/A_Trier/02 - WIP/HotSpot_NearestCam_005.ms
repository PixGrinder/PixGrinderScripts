(
	clearListener()

	fn myComp v1 v2 = 
	(
		if v1[2] > v2[2] then return 1 else return -1
	)


	myHotspots = for cam in cameras where cam.name[1] == "H" collect cam

	myTaggedObjects = for obj in objects where custAttributes.count obj != 0 and obj.compLoc.hotspot != undefined collect obj
	myTagMod = for obj in myTaggedObjects where matchpattern obj.compLoc.hotspot.name pattern:"*_HFreeN" == true collect obj
	myWorkObj = for obj in myTagMod where obj.compLoc.hotspot.fov == 40.0 collect obj

	for obj in myWorkObj do
	(
		myAr = for bla in myHotspots collect #(bla, distance obj bla)
		qsort myAr myComp
		myCam = myAr[1][1]
		obj.compLoc.hotspot.name = obj.name+"_"+ myCam.name
		obj.compLoc.hotspot.position = myCam.position
	)
	

-- 	for obj in objects do obj.isHidden = true
-- 	for obj in myWorkObj do obj.isHidden = false

	
)


----------------------------

-- Sort Cam distances


-- 	myNode = $

-- 	myAr = for obj in myHotspots collect #(obj, distance myNode obj)




-- 	qsort myAr myComp

-- 	for obj in myAr do print obj[2]

-- 	select myAr[1][1]

-- myCam = $
-- $.compLoc.hotspot.position = myCam.position
-- $.compLoc.hotspot.name = $.name+"_"+ myCam.name
