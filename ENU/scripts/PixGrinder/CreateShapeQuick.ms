
-- CreateShapeQuick --
-- Creates shape from selected edges, and selects the created shape and go to edit vertex mode -- 
-- v2.1 --


(
	fn  myShpSort v1 v2= 
	(
		if v1.name > v2.name then 1 else -1
	)

	if (polyop.getEdgeSelection selection[1]) != #{} then 
	(
		selection[1].layer.current = true
		polyop.createShape selection[1] (polyop.getEdgeSelection selection[1]) smooth:false name:(selection[1].name +"_Shape_")
		subobjectLevel = 0
		myAr = for obj in shapes where MatchPattern obj.name pattern:((selection[1].name +"_Shape_")+"*") == true collect obj
		qsort myAr myShpSort
		select myAr[myAr.count]
		subObjectLevel = 1
	)
)