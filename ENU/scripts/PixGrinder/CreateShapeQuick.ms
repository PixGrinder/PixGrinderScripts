(


	if (polyop.getEdgeSelection selection[1]) != #{} then 
	(
		polyop.createShape selection[1] (polyop.getEdgeSelection selection[1]) smooth:false name:(selection[1].name +"_Shape_")
		subobjectLevel = 0
		myAr = for obj in shapes where MatchPattern obj.name pattern:((selection[1].name +"_Shape_")+"*") == true collect obj
		qsort myAr myShpSort
		select myAr[myAr.count]
		subObjectLevel = 1
	)
)