(
	clearlistener()
	pda = #()
	for obj in selection do
	(
		if matchPattern  obj.name pattern:"ATA_??-*" == true do append pda obj
	)
	max select none
	select pda	
)



-- matchPattern  $.name pattern:"ATA_??-*"