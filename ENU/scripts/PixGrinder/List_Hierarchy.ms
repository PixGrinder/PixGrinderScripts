

---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Hierarchy --
-- List_Hierarchy.ms --
-- Lists selected hierarchy in the Listener --
-- V 2.0 --
-- Mail : pixgrinder@gmail.com --

---------------------------------------------------------------------


(
clearListener()

fn sortByName v1 v2= 
(
	if v1.name > v2.name then 1 else -1
)

fn testHier node level=
(
	x1=""
	for i = 1 to level do x1 = x1+"\t"
	format "%%%" x1 node.name "\r"
	theLevel = level
	if node.children.count != 0 do 
	(
		theArray = for obj in node.children collect obj
		qsort theArray sortByName
		theLevel = theLevel+1
		for bla in theArray do testHier bla theLevel
	)

)

theStart = for obj in selection where obj.parent == undefined collect obj

for obj in theStart do testHier obj 1
)