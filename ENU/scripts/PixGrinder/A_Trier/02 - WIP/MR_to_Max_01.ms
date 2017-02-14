global pda = getclassInstances Arch___Design__mi

for obj in geometry do
(
	if finditem x1 obj.material !=undefined do --print obj.name
	(
		
	)
)


-------------------------------


meditmaterials[1] = pda[1]

for obj in geometry do if obj.material == meditmaterials[1] do print obj.name



	for obj in geometry do 
	(
		if classof obj.material == multimaterial do
		(
			for i = 1 to obj.material.count do 
			(
				if obj.material[i] == meditmaterials[1] do print obj.name
			)
		)
		
		if obj.material == meditmaterials[1] do print obj.name
		
	)

	

	