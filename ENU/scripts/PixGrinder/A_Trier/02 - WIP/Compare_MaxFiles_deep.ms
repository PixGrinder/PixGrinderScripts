(
	clearListener()
	myList = #()
	for obj in geometry do if classof obj != Editable_Poly do convertToPoly obj
	for obj in geometry do 
	(
		append myList #(obj.name, obj.position, (distance obj.max obj.min),polyop.getNumVerts obj)
		
	)
	for bla in myList do print bla
)