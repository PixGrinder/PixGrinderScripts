-- Layers Hierarchy Check -- 


(
	clearListener()
	myAr = #()
	myHierChildren = for obj in objects where obj.parent != undefined collect obj
	--select (for obj in myHierChildren where obj.layer.name != obj.parent.layer.name collect obj)
	for obj in myHierChildren where obj.layer.name != obj.parent.layer.name do
	(
		append myAr obj
		appendIfUnique myAr obj.parent
	)
	clearSelection()
	select myAr
)
