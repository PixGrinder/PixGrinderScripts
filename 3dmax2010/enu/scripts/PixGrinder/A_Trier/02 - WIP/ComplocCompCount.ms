	-- comploc components count --
	-- ComplocCompCount.ms -- 

	(
		myComploc = for obj in objects where custAttributes.count obj > 0 collect obj
		messagebox ("Recorded cams : "+ (myComploc.count as string))
	)