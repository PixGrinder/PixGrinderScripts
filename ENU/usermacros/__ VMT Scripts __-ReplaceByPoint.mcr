macroScript ReplaceByPoint
category:"-- VMT Scripts --"
toolTip:"ReplaceByPoint"
buttonText:"ReplaceByPoint"
icon:#("Helpers",2)
silentErrors:off
autoUndoEnabled:off

(
	myAr = geometry as array
	if myAr.count > 0 then
	(
		for obj in myAr do 
		(
			myDist = distance obj.min obj.max
			myPoint = Point size:myDist box:on transform:obj.transform name:obj.name pos:obj.center
			if obj.isAnimated then 
			(
				addNewKey myPoint.position.controller 0f
				addNewKey myPoint.position.controller 1f
			)
			delete obj
		)
	)

	ForceCompleteRedraw()
)