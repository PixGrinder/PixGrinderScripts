(
	pda = #()
	for obj in geometry do
	(
		for i = 1 to obj.modifiers.count do
		(
			if classof obj.modifiers[i] == Unwrap_UVW do appendifunique pda obj 
		)
	)
	for obj in pda do print obj.name
	select pda
)


(
	x1 = for obj in objects where  obj.material != undefined collect obj
	x2 = for obj in x1 where (matchpattern obj.material.name pattern:"VMtl*") == true collect obj
	select x2
)