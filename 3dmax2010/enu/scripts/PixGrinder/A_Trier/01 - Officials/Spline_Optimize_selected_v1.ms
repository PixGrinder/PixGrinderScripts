

(

	-- Step de vertex à optimiser. Ex : 1/2 - 1/3 - 1/stp
	----------------------------------------------------------
	
	global stp = 2
	
	-- obj=1
	--------

	max modify mode
	

	mySelec = selection[1]
	
	for j=1 to mySelec.numSplines do (
		ar1 = #()
		for i =1 to (numKnots mySelec j) by stp do ( append ar1 i )
		select mySelec
		subObjectLevel = 1
		setKnotSelection mySelec j ar1
		max delete
		subObjectLevel = 0
	)
	
)



