
(
	clearListener()
	myItems = for obj in geometry where matchpattern obj.name pattern:"ATA_??-??_*"== true collect obj.name
-- 	for obj in myItems do print obj.name
	files = getFiles "C:\Users\guest1182\Pictures\HotSpots_Backup\*.jpg"
-- 	filenamefrompath files[1]
	max select none
	for obj in files do 
	(
		for pda in myItems do
		(
			if matchpattern pda pattern:(getfilenamefile obj) == true do 
			(
				print ("Deleting : "+pda)
				x1 = getNodeByName pda
				delete x1
-- 				_ca.RemoveCA #compLoc nodeList:x1
			)
		)
	)
)



