(	
	clearListener()
	clearSelection()
	myWord = "fuselage"
	pda_result= #()

	pda1 = (for obj in objects where CustAttributes.count obj == 1 collect obj)

	for obj in pda1 do
	(
		for bla in obj.compLoc.Transparent do 
		(
			if matchpattern bla.node.name pattern:myWord == true then appendifUnique pda_result obj
		)

	)


	select pda_result

)



-- list hidden objects --

(	
	clearListener()
	clearSelection()
	pda_result= #()

	pda1 = (for obj in objects where CustAttributes.count obj == 1 collect obj)

 	for obj in pda1 do 
 	(
 		for bla in obj.compLoc.hidden do appendIfUnique pda_result bla.node.name
 	)


	for obj in pda_result do print obj

)