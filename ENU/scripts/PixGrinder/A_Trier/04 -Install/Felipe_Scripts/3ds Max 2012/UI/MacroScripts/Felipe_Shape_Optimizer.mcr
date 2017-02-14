
-------------------------------------------------------------------------------
-- Felipe_Shape_Optimizer.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2013/09/02
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Shape_Optimizer
category:"Felipe Scripts"
toolTip:"Remove half vertices on all scene shapes"



(

	-- Step de vertex à optimiser. Ex : 1/2 - 1/3 - 1/stp
	----------------------------------------------------------
	
	global stp = 2
	-- obj=1
	--------

	max modify mode
	
	for k = 1 to shapes.count do (
		
		select shapes[k]
		
		for j=1 to shapes[k].numSplines do (
			ar1 = #()
			print shapes[k].name
			for i =1 to (numKnots shapes[k] j) by stp do ( append ar1 i )
			select shapes[k]
			subObjectLevel = 1
			setKnotSelection shapes[k] j ar1
			max delete
			subObjectLevel = 0
		)
	)
)



