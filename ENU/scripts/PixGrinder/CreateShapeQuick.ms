if (polyop.getEdgeSelection selection[1]) != #{} then 
(
	polyop.createShape selection[1] (polyop.getEdgeSelection selection[1]) smooth:false name:(selection[1].name +"_Shape_")
	subobjectLevel = 0
	select (getNodeByName (selection[1].name +"_Shape_"))
	subObjectLevel = 1
)
