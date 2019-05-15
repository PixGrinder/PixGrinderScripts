-- Hierarchy_Add_Dummy_Parent.ms --
-- v 2.0 --

(
	myTemp = geometry as array
	for obj in myTemp do
	(
		theTemp = dummy name:(obj.name) pos:(obj.pos) boxsize:[((distance obj.max obj.min)*0.3),((distance obj.max obj.min)*0.3),((distance obj.max obj.min)*0.3)]
		theTemp.parent = obj.parent
		obj.parent = theTemp
	)
)
