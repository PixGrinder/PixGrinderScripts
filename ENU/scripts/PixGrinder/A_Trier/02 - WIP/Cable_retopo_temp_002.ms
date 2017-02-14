(
	clearlistener()
	myCable = selection[1]
	maxOps.cloneNodes myCable cloneType:#copy newNodes:&nnl
	nnl = nnl[1]
	nnl.name = myCable.name+"_backup"
	nnl.isHidden = true
	myAr = #()
	select myCable
	converttopoly myCable
	myNum = 1



	subobjectlevel = 4
	global x1 = polyop.getFaceSelection myCable
	while x1.count > 0 do
	(
		select myCable
		subobjectlevel = 4
		x1 = polyop.getFaceSelection myCable
		--print x1
		polyop.detachFaces myCable x1 delete:false asnode:true name:"youpi"
		if $youpi == undefined do exit
		select $youpi
		append myAr $youpi.center
		delete $youpi
		--$youpi.name = "youpi"+(myNum as string)
		select myCable
		subobjectlevel = 4
		--for k = 1 to 3 do myCable.EditablePoly.GrowSelection ()
		myCable.EditablePoly.GrowSelection ()
		polyop.deletefaces myCable x1
		x1 = polyop.getFaceSelection myCable
		x1.count
	)
	delete myCable
	myShape = splineShape ()
	addNewSpline myShape
	for i = 1 to myAr.count do 
	(
		addKnot myShape 1 #corner #line myAr[i]
		if i > 1 do updateshape myShape
	)
	myShape.render_renderable = true
	myShape.render_thickness = 2
	myShape.render_sides = 5
	myShape.render_threshold = 89
	updateshape myShape
	
)

select myShape


-------------------------------
-- Brouillon
-------------------------------


