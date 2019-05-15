(
	pda_ar = getcurrentselection()

	if pda_ar.count ==1 then
	(
		global x = pda_ar[1]
		while x.parent != undefined do 
		(
			x = x.parent
		)
		select x
		actionMan.executeAction 0 "40180"  -- Selection: Select Children
	) else 
	(
			messagebox "Please select only one single object"
	)


)


