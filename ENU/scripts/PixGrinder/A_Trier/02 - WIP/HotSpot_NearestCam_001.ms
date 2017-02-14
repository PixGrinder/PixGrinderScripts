(
	myHotspots = for cam in cameras where cam.name[1] == "H" collect cam

	select myHotspots

	myTaggedObjects = for obj in objects where custAttributes.count obj != 0 collect obj

	myTagMod = for obj in myTaggedObjects
	
)