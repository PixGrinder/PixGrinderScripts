(
	clearListener()

	fn myComp v1 v2 = 
	(
		if v1[2] > v2[2] then return 1 else return -1
	)


	myHotspots = for cam in cameras where cam.name[1] == "H" collect cam

	-- objets taggés Comploc :
	myTaggedObjects = for obj in selection where custAttributes.count obj != 0 and obj.compLoc.hotspot != undefined collect obj 

	-- Objets taggés qui ont le nom "HfreeN"
	--myTagMod = for obj in myTaggedObjects where matchpattern obj.compLoc.hotspot.name pattern:"*_HFreeN" == true collect obj

	-- 
	--myWorkObj = for obj in myTagMod where obj.compLoc.hotspot.fov == 40.0 collect obj


	myWorkObj = myTaggedObjects

	for obj in myWorkObj do
	(
		myAr = for bla in myHotspots where (distance obj bla > 8.0) collect #(bla, distance obj bla)
		qsort myAr myComp
		myCam = myAr[1][1]
		obj.compLoc.hotspot.name = obj.name+"_"+ myCam.name
		obj.compLoc.hotspot.position = myCam.position
		obj.compLoc.hotspot.fov = 80
	)
	

-- 	for obj in objects do obj.isHidden = true
-- 	for obj in myWorkObj do obj.isHidden = false

	
)


----------------------------

/*

select (for obj in objects where matchpattern obj.name pattern:"ATA_??-??_*" == true collect obj)

*/


-- Sort Cam distances


-- 	myNode = $

-- 	myAr = for obj in myHotspots collect #(obj, distance myNode obj)




-- 	qsort myAr myComp

-- 	for obj in myAr do print obj[2]

-- 	select myAr[1][1]

-- myCam = $
-- $.compLoc.hotspot.position = myCam.position
-- $.compLoc.hotspot.name = $.name+"_"+ myCam.name
