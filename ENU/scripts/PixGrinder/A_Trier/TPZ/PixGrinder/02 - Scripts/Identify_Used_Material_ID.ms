
clearListener()
(
	myObj = getcurrentSelection()
	myObj = myObj[1]
	
	max modify mode
	subobjectLevel = 4
	if classof myObj.material == Multimaterial do
	(
		for i = 1 to myObj.material.count do
		(
			$.EditablePoly.selectByMaterial i
			x = polyop.getFaceSelection $
			x = x as array
			if x.count != 0 do print ((i as string) + " : " + ( x.count as string) )

		)
	)
	subobjectLevel = 0
)

