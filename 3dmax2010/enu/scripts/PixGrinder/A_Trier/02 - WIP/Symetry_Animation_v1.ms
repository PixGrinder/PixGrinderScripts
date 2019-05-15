(
	clearListener()
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
	
	print "delete helpers"
	
)

