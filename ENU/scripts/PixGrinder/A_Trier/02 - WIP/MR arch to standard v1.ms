global pda = getclassInstances Arch___Design__mi


------------------------------------

for i = 1 to pda.count do 
(
		for obj in geometry do
		(
			if finditem pda[i] obj != undefined do print ( pda[i] obj.name)
		)
	
)

meditmaterials[2] = pda[1]

m1 = meditmaterials[1]

classof m1[1]


classof $.material[1]

select geometry[2]

$.name
-------------------------------
finditem pda $.material
-------------------------------