-- Object Quick Reset -- 
-- obj = selection[1]
for obj in selection do
(
	myTemp = obj.parent
	obj.parent = undefined
	objRot = obj.rotation
	obj.rotation = (quat 0.0 0.0 0.0 0.0)
	resetXform obj
	collapseStack obj
	rotate obj objRot
	obj.parent = myTemp
)
