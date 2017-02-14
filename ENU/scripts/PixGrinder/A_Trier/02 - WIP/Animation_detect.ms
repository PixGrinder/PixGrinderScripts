(
	clearListener()
	max select none
	
	pda=#()

	for i = 1  to objects.count do
	(
		if objects[i].isAnimated == true do appendifunique pda objects[i]
-- 		if objects[i].rotation.controller.isAnimated == true do appendifunique pda objects[i]
		
		--if objects[i].position.controller.keys.count !=0 do appendifunique pda objects[i]

	)
	
	for obj in objects do 
	(
		for i = 1 to obj.children.count do appendifunique pda obj.children[i]
	)
	
	select pda
	
)



