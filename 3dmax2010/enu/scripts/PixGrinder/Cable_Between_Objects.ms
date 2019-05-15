-- Cable Between Objects -- 

if selection.count != 2 then messageBox("Please select only 2 objects") else 
(
	myShape = splineShape ()
	addNewSpline myShape
	addKnot myShape 1 #corner #line selection[1].center
	addKnot myShape 1 #corner #line selection[2].center
	updateshape myShape
	myShape.render_renderable = true
	myShape.render_mapcoords = true
	myShape.render_displayRenderMesh = true
	myShape.render_thickness = 0.2
	myShape.render_sides = 5
	myShape.render_threshold = 89
	myShape.steps = 0
	myShape.pivot = myShape.center
	updateshape myShape
)