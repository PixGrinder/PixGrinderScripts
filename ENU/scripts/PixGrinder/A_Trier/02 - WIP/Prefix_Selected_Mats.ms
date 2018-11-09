-- Prefix_Selected_Mats --

(
	myPrefix = "AS365_Window" + "_"
	matAr = #()

	for obj in selection do 
	(
		if classof obj.material == standardMaterial then appendifUnique matAr obj.material

		if classof obj.material == MultiMaterial then
		(
			for i = 1 to obj.material.count do
			(
				if obj.material[i]!= undefined then appendifUnique matAr obj.material[i]
			)
		)

	)

	for mat in matAr do mat.name = myPrefix + mat.name

)


/*

	$.material[1].name

*/