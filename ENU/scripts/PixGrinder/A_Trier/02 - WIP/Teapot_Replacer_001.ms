-- start --
(
	
	clearListener()
	
	-- variables

	pda = #()
	pdageo = #()
	myProg = 0
	timeBeg = #()
	timeEnd = #()
	print "variables ok"
	


	-- open all groups

	for i = 1 to 100 do 
	(
		max select all
		max group open
	)
	print "open all groups ok"



	-- filer selected geometry

	pda = getcurrentselection()
	for i = 1 to pda.count do if superclassof pda[i] == GeometryClass do appendifunique pdageo pda[i]
	print "filter OK"
	

	-- replace all geometries by boxes
	timeBeg = getLocalTime()
	timeBeg = [timeBeg[5], timeBeg[6], timeBeg[7]]
	progressStart "Working..."

	for i = 1 to pdageo.count do
	(
		
		if (100*(i as float)/pdageo.count) > (myProg as float) do
		(
			myProg = myProg+1
			progressUpdate myProg
		)
		
		myObj = pdageo[i]
		--myTemp = Teapot radius:10 name:myObj.name
		--myTemp.radius = (distance myObj.max myObj.min) / 3
		myX = myObj.max.x - myObj.min.x
		myY = myObj.max.y - myObj.min.y
		myZ = myObj.max.z - myObj.min.z
		myTemp = Box name:myObj.name width:myX length:myY height:myZ 
		myTemp.parent = myObj.parent
		myTemp.transform = myObj.transform
		myTemp.center = myObj.center
		myTemp.pivot = myObj.pivot
		myTemp.position.controller = myObj.position.controller
		myTemp.rotation.controller = myObj.rotation.controller
		myTemp.scale.controller = myObj.scale.controller
		myTemp.material = myObj.material
		if myObj.children.count != 0 do
		(
			for j = 1 to myObj.children.count do
			(
				x1 = myObj.children[j]
				if x1 != undefined do x1.parent = myTemp
			)
		)
		
		delete myObj
		
	)
	timeEnd = getLocalTime()
	timeEnd = [timeEnd[5],timeEnd[6],timeEnd[7]]
	TimeRes = TimeEnd - TimeBeg
	print ("Time Elapsed : " + TimeRes[1] as string + " Hours " + timeRes[2] as string + " Minutes" +timeRes[3] as string + " Secondes" )
	progressEnd()
	print "End"
)
-- end --




