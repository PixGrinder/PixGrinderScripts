-- ShapeFromPoly --
fn  myShpSort v1 v2= 
(
	if v1.name > v2.name then 1 else -1
)

if subObjectLevel == 4 then 
(
	myObj = copy selection[1]
	myObj.name = selection[1].name + "_Detached"
	convertToPoly myObj
	select myObj
	subObjectLevel = 4
	max select invert
	polyop.deleteFaces myObj (polyOp.getFaceSelection myObj)
	update myObj
	subObjectLevel = 0
	select myObj
	subObjectLevel = 3
	max select all
	polyop.createShape myObj (polyop.getEdgeSelection myObj) smooth:false name:(selection[1].name +"_Shape_")
	redrawViews()
	subobjectLevel = 0
	myAr = for obj in shapes where MatchPattern obj.name pattern:((myObj.name +"_Shape_")+"*") == true collect obj
	qsort myAr myShpSort
	delete myObj
	select myAr[myAr.count]
	subObjectLevel = 2

)

