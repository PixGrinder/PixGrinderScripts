-- List 1 object by final Hotspot -- 

-- DO A "SELECT TAGGED OBJECTS" BEFORE USING THIS SCTIPT --



(
	HSList = #()
	ResList = #()

	fn listcomps oneName = 
	(
		myTemp = for obj in selection where obj.compLoc.hotspot != undefined and matchPattern obj.compLoc.hotspot.name pattern:("*_"+oneName) == true collect obj.name
		return myTemp[1]
	)

	for obj in selection where CustAttributes.count obj == 1 do try (appendifUnique HSList (replace (obj.compLoc.hotspot.name) 1 ((obj.name).count+1) "")) catch ()

-- 	clearListener()
-- 	print HSList.count
	for obj in HSList do append ResList (listcomps obj)

	clearListener()

-- 	print ResList.count 

	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	print("List of nodes covering all used hotposts :")
	for txt in ResList do format "%\r" txt

-- 	for obj in ResList do 
-- 	(
-- 		x1 = getNodebyName obj 
-- 		print x1.compLoc.hotspot.name
-- 	)	

)





