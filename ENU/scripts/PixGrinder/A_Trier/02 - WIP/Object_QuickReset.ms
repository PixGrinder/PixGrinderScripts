-- Object Quick Reset -- 
-- obj = selection[1]
for obj in selection do
(
	myTemp = obj.parent
	obj.parent = undefined
	--obj.pivot = obj.center
	objRot = obj.rotation -- as eulerAngles
	obj.rotation = (quat 0.0 0.0 0.0 0.0)
	resetXform obj
	collapseStack obj
	rotate obj objRot
	myTemp = obj.parent
)
