-- DetachQuick --
-- DetachQuick.ms --
-- v1.2 --


(
	selection[1].layer.current = true

	fn theObjSort v1 v2 = 
	(
		if v1.name > v2.name then 1 else -1
	)


	if subObjectLevel == 4 or subObjectLevel == 5 then 
	(
		convertToPoly selection[1]
		myTemp = selection[1]
		myfcSel = polyop.getFaceSelection selection[1]
		polyop.detachFaces selection[1] myfcSel delete:true asNode:true name:(selection[1].name + "_detached")
		tempAr = (for obj in geometry where matchpattern obj.name pattern:(myTemp.name + "_detached*") == true collect obj)
		qsort tempAr theObjSort
		for obj in tempAr do print obj
		select tempAr[tempAr.count]
		$.pivot=$.center
	)

)