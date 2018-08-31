-- DetachQuick --
-- DetachQuick.ms --



if subObjectLevel == 4 or subObjectLevel == 5 then 
(
	convertToPoly selection[1]
	myObj = copy selection[1]
	myObj.name = selection[1].name + "_Detached"
	polyop.deleteFaces selection[1] (polyOp.getFaceSelection selection[1])
	--convertToPoly myObj
	select myObj
	subObjectLevel = 4
	max select invert
	polyop.deleteFaces myObj (polyOp.getFaceSelection myObj)
	update myObj
	subObjectLevel = 0
	select myObj
)

