(
	clearListener()
	mySelec=getCurrentSelection()
	nodeAnim = for obj in selection where obj.isAnimated collect obj
	theDums = #()
	theArray = #()
	for obj in nodeAnim do
	(
		myTemp = distance obj.max obj.min/4
		myDum = dummy name:obj.name boxSize:[myTemp,myTemp,myTemp]
		myDum.transform = obj.transform
		append theDums myDum
		append theArray #(obj, myDum)
	)
	
	for obj in theArray do 
	(
		if obj[1].parent != undefined do
		(
			for bla in theDums do
			(
				if bla.name == obj[1].parent.name do obj[2].parent = bla
			)
		)
		
	)
	
	for obj in theDums do
	(
		for bla in nodeAnim do
		(
			try (if obj.name == bla.name do obj.pos.controller = copy bla.pos.controller) catch (print (obj.name+" : bad position copy"))
			try (if obj.name == bla.name do obj.rotation.controller = copy bla.rotation.controller) catch (print (obj.name+" : bad rotation copy"))
		)
	)
	
	for obj in nodeAnim do deleteKeys obj
		
	for obj in theDums do
	(
		for bla in nodeAnim do
		(
			try (if obj.name == bla.name do bla.parent = obj) catch()
		)
	)

	for obj in theDums do obj.name = obj.name+"_dummy"
	x1 = mySelec+theDums
	select x1
	maxOps.CloneNodes x1 expandHierarchy:true newnodes:&x2

	print "clone OK"
	myOrigin = dummy pos:[0,0,0] name:"SymNode"
	print "dummy ok"
	for obj in x2 where obj.parent == undefined do obj.parent = myOrigin
	print "for loop ok"

	select myOrigin
	print "myOrigin selection ok"
	scale myOrigin [1,-1,1]
	delete myOrigin
	for obj in x2 where superclassof obj == geometry do
	(
		x1 = obj.parent
		obj.parent = undefined
		resetXform obj
		obj.parent = x1
	)
)

