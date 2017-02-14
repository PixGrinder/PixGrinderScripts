-- Exploder ver 0.01
-- Ilies Sarrab, march 2010

-- Arrays
-- Array of the objects who will explode
myObjects = #()

-- Array of the ground zero object, should contain only one object
myBomb = #()

rollout myExploder "My Exploder"
	(
		group "Selection" (
			--myObjects _ MO
					
			button _EmptyMO "Empty" align:#left across: 2
			on _EmptyMO pressed do
			(
				myObjects = #()
				myBomb = #()
				-- test -- print myObjects
			)
			
			button _AddMO "Add selection" align:#right
			on _AddMO pressed do
			(
				join myObjects (selection as array)
				initialMyObjects = myObjects
			)
			
			-- myBomb _ MB
			
			button _AddMB "Add bomb" align:#right
			on _AddMB pressed do
			(
				if selection.count == 1 then (
															(myBomb = selection as array)
															(print myBomb)
														)
					else messagebox "Please select one object as bomb."
			)
		)
		
		group "Forces" (
			spinner _Distance "Distance" range:[1,1000,10]
			-- Execution
			
			button _Push "Push" align:#left across: 2
			on _Push pressed do
			(
				for i in myObjects do
				(
					myVector = normalize(i.pos - myBomb[1].pos)
					i.pos = (i.pos + (myVector * _Distance.value))
					--test -- print i.pos
				)
			)
			
			button _Pull "Pull" align:#right
			on _Pull pressed do
			(			
				for i in myObjects do
				(				
					if i.pos == myBomb[1].pos then
					(
						messagebox "One or more objects have the same positions as the bomb."
					)
					else 
					(
						myVector = normalize(i.pos - myBomb[1].pos) -- /2
						if (distance i.pos myBomb[1].pos) > _Distance.value then
							(
								i.pos = (i.pos - (myVector * _Distance.value))
							)
						else i.pos = (myBomb[1].pos + myVector)
					)
					-- test -- print i.pos
				)
			)
		)	

		
		-- Various
		button _Help "Help"
		on _Help pressed do
			(
			messagebox "Autor: Iliès Sarrab\nmarch 2010\nver 0.01"
			)
		
	)

createdialog MyExploder width:200
