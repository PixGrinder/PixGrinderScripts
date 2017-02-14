-- CAO Normals Cleaner
(
	myObj = selection[1]
	myObj.pivot = myObj.center
	resetXform myObj
	addModifier myObj (SmoothModifier ())
	myObj.modifiers[1].smoothingBits = 1
	addModifier myObj (SmoothModifier ())
	collapseStack myObj
)