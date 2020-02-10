

---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Hierarchy --
-- List_Hierarchy.ms --
-- Lists selected hierarchy in the Listener --
-- V 3.1 --
-- Mail : pixgrinder@gmail.com --

---------------------------------------------------------------------

(
	clearListener()
	--theCondition = false


	fn sortByName v1 v2= 
	(
		if v1.name > v2.name then 1 else -1
	)

	fn testHier node level  =
	(
		x1=""
		for i = 1 to level do x1 = x1+"    "
		--format "%%%" x1 node.name "\r"
		format "%%  -  %%" (x1 as string) node.name node.layer.name"\r" --to:extFile
		theLevel = level
		if node.children.count != 0 do 
		(
			theArray = for obj in node.children collect obj
			qsort theArray sortByName
			theLevel = theLevel+1
			for bla in theArray do testHier bla theLevel --extFile
		)

	)

	theStart = for obj in helpers where finditem (helpers as array) obj.parent == 0 collect obj
	qsort theStart sortByName

	for obj in theStart do testHier obj 1 --theFile

	actionMan.executeAction 0 "40472"
)