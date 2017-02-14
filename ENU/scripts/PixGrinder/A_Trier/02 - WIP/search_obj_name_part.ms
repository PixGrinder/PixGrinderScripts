(
	
	mySearch = "SAL" -- String to search
	pda = #()

	max select none
	for obj in objects do
	(
		if matchpattern obj.name pattern:("*"+mySearch+"*") == true do appendifunique pda obj
		
	)

	select pda
)