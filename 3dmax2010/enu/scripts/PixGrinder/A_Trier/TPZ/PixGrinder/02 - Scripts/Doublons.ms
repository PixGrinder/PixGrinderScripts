-- find doubles


(
	clearlistener()
	
	global pda_list = #()

	global temp = geometry as array

	for i = 1 to temp.count do 
	(
		x1 = temp[i].name
		pda1 = #()
		append pda1 temp[i]
		for j = 1 to temp.count do
		(
			if temp[j].name == x1 do appendifunique pda1 temp[j]
			
		)
		if pda1.count >= 2 do appendifunique pda_list pda1
	)


	print pda_list.count
	print ("Job Done")

)



