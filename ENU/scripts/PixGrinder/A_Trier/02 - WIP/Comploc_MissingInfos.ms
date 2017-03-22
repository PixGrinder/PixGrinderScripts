-- Comploc Component Export Information fix --


(
	clearListener()
-- 	i = 1
	for obj in objects where custAttributes.count obj == 1 do 
	(
-- 		print (i as string+";"+obj.name +";" + substring obj.compLoc.hotspot.name (obj.name.count+2) obj.compLoc.hotspot.name.count)
-- 		format (i as string+";"+obj.name +";" + substring obj.compLoc.hotspot.name (obj.name.count+2) obj.compLoc.hotspot.name.count+"\n")
		theCam = substring obj.compLoc.hotspot.name (obj.name.count+2) obj.compLoc.hotspot.name.count
		theFOV = (obj.comploc.hotspot.fov as integer)

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


		format "%;%;%;%;%;%\n" obj.name theCam theFOV theTransp theHide theAnim

-- 		i = i+1
	)
)


--------- WIP ----------------------

-- clearListener()
-- if doesFileExist "d:/AS365.csv" == false then 
-- (
-- 	global HelicoList = createFile "d:/AS365.csv"
-- 	print "File Created"
-- ) else (
-- 	global HelicoList = openFile "d:/AS365.csv"
-- 	print "File Opened"
-- )

-- filePos()


-- print "Youpi" to "d:/AS365.csv"

-- close HelicoList



-- JUST ON SELECTION : --


-- (
-- 	clearListener()

-- 	for obj in selection do 
-- 	(

-- 		theCam = substring obj.compLoc.hotspot.name (obj.name.count+2) obj.compLoc.hotspot.name.count
-- 		theFOV = (obj.comploc.hotspot.fov as integer)

-- 		theTransp = ""
-- 		for tr in obj.compLoc.transparent do append theTransp (tr.node.name + ", ")
-- 		theTransp = substring theTransp 1 (theTransp.count - 2)
-- 		if theTransp.count < 4 then theTransp = ""

-- 		theHide = ""
-- 		for tr in obj.compLoc.hidden do append theHide (tr.node.name + ", ")
-- 		theHide = substring theHide 1 (theHide.count - 2)
-- 		if theHide.count < 4 then theHide = ""

-- 		theAnim = ""
-- 		for tr in obj.compLoc.animated do append theAnim (tr.node.name + ", ")
-- 		theAnim = substring theAnim 1 (theAnim.count - 2)
-- 		if theAnim.count < 4 then theAnim = ""


-- 		format "%;%;%;%;%;%\n" obj.name theCam theFOV theTransp theHide theAnim

-- 	)
-- )
