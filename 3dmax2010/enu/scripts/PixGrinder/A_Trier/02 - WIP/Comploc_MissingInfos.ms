-- Comploc Component Export Information fix --
-- v2.0 --


(
	clearListener()
-- 	i = 1
	
	myFileName = "d:\\" + "H225_ComplocInfos.csv"
	myFile = createFile myFileName

	myArray = for obj in objects where matchpattern obj.name pattern:"ATA_??-??_*" == true and custAttributes.count obj > 0 collect obj

	fn myCompare string1 string2 = 
	(
		if string1.name > string2.name then 1 else -1
	)

	qsort myArray myCompare

	for obj in myArray do 
	(
-- 		print (i as string+";"+obj.name +";" + substring obj.compLoc.hotspot.name (obj.name.count+2) obj.compLoc.hotspot.name.count)
-- 		format (i as string+";"+obj.name +";" + substring obj.compLoc.hotspot.name (obj.name.count+2) obj.compLoc.hotspot.name.count+"\n")
		--print obj.name -- a virer quand tout fonctionne !!!
		theCam = substring obj.compLoc.hotspot.name (obj.name.count+2) obj.compLoc.hotspot.name.count
		theFOV = (obj.compLoc.hotspot.fov as integer)

		theTransp = ""
		for tr in obj.compLoc.transparent do append theTransp (tr.node.name + ", ")
		theTransp = substring theTransp 1 (theTransp.count - 2)
		if theTransp.count < 4 then theTransp = ""

		theHide = ""
		for tr in obj.compLoc.hidden do append theHide (tr.node.name + ", ")
		theHide = substring theHide 1 (theHide.count - 2)
		if theHide.count < 4 then theHide = ""

		theAnim = ""
		for tr in obj.compLoc.animated do append theAnim (tr.node.name + ", ")
		theAnim = substring theAnim 1 (theAnim.count - 2)
		if theAnim.count < 4 then theAnim = ""


		format "%;%;%;%;%;%\r" obj.name theCam theFOV theTransp theHide theAnim to:myFile


-- 		i = i+1
	)
	close myFile
)

