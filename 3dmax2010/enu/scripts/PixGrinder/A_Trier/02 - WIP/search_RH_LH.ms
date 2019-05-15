(
	clearListener()
	pda = #()
	for obj in geometry do 
	(
		if matchpattern obj.name pattern:"ATA_??-??_*" == true do append pda obj.name
	)

	for obj in pda do print obj
)


