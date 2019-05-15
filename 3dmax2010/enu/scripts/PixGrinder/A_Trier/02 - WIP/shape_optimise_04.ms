
-------------------------------------------------------------------------------
-- Felipe_Shape_Optimizer.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2013/09/02
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Shape Optimizer
category:"Felipe Scripts"
toolTip:"Remove half vertices on all scene shapes"



(

	-- Step de vertex à optimiser. Ex : 1/2 - 1/3 - 1/stp
	----------------------------------------------------------
	
	global stp = 2
	global x1 = shapes as array



	-------------------
	-- Progress Bar
	-------------------
	
	
	rollout progressTest "Progress Test"

(
progressbar doit_prog color:[255,0,235]
spinner d "done:" value:0 type:#integer
--label l1 "youpla"
)



--progressTest.l1.value = "on "+x1.count as string+ " splines"

createDialog progressTest 200 60

	-----------------------
	-- Fin progress Bar
	-----------------------


	max modify mode
	
	for k = 1 to x1.count do (

		select x1[k]
		
		if (x1[k].numSplines > 1) and (x1[k].numSplines != 0)  do (

			for j=1 to x1[k].numSplines do (
				ar1 = #()
				if ((numKnots x1[k] j )> 8) do (
					for i =1 to (numKnots x1[k] j) by stp do ( append ar1 i )
					select x1[k]
					max modify mode
					subObjectLevel = 1
					setKnotSelection x1[k] j ar1
					max delete
					subObjectLevel = 0
				)
			)
		
		)
		
		if x1[k].numSplines == 1 do (
			ar1 = #()
			if ((numKnots x1[k] j )> 8) do (
				for i =1 to (numKnots x1[k] j) by stp do ( append ar1 i )
				select x1[k]
				max modify mode
				subObjectLevel = 1
				setKnotSelection x1[k] j ar1
				max delete
				subObjectLevel = 0
			)
		)
 progressTest.doit_prog.value = (k/x1.count)*100
 progressTest.d.value = k
 sleep 1
	)


)
----------------------------------






