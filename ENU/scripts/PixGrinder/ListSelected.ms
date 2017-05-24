---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Selected --
-- ListSelected.ms --
-- Outputs selected objects names in MaxScript listener --
-- Improvement to come : Output in a text file ...   --
-- V 1.1 --

---------------------------------------------------------------------



(
	clearListener()
	myTempAr = #()
	myTempAr = for obj in selection collect obj.name
	sort myTempAr
	for obj in myTempAr do format "%\r" obj
	-- format "% - % - %\r" obj.name obj.position obj.rotation

)



fn testHier node level=
(
	x1=""
	for i = 1 to level do x1 = x1+"\t"
	print (x1+node.name)
	if node.children.count != 0 do 
	(
		level = level+1
		for obj in node.children do test obj level
	)

)

theStart = for obj in selection where obj.parent == undefined collect obj

for obj in theStart do testHier obj 1



