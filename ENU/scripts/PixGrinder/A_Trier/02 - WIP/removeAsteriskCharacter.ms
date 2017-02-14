for obj in selection do 
(
	x1 = obj.name
	x1 = substring x1 3 -1
	obj.name = x1
)


for obj in selection do 
(
	x1 = obj.name
	x1 = "__"+obj.name
	obj.name = x1
)

$.name
findstring $.name "*"
$.name[33]


----------------------------------------------------------------

-- Remove Asterrisk
(
	clearListener()
	for obj in geometry do
	(
		while findstring obj.name "*" != undefined do
		(
			x1 = findstring obj.name "*"
			obj.name = replace obj.name x1 1 "_"
		)
	)
)