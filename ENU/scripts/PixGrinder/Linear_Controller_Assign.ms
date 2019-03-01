-- Linear Controller Assign -- 

for obj in selection do
(
	obj.pos.controller = linear_position ()
	obj.rotation.controller = linear_rotation ()
)