


-------------------------------

-- Hidden Problem : 
-------------------


(
	myPb = #()


	-- collecte des objets avec CustomAttribute dans myAttribs
	myAttribs = for obj in objects where custAttributes.count obj == 1 collect obj
	myAttribs.count

	-- collecte des objets qui ont des entrées en Hidden
	myHid = for obj in myAttribs where obj.compLoc.hidden.count > 0 collect obj
	myHid.count

	for obj in myHid do
	(
		for i = 1 to obj.compLoc.hidden.count do 
		(
			if obj.compLoc.hidden[i].node == undefined do appendifUnique myPb obj
		)
	)


	clearSelection()

	select myPb

)



-------------------------------

-- Transparent Problem : 
-------------------------


(
	myPb = #()


	-- collecte des objets avec CustomAttribute dans myAttribs
	myAttribs = for obj in objects where custAttributes.count obj == 1 collect obj
	myAttribs.count

	-- collecte des objets qui ont des entrées en Transparent
	myHid = for obj in myAttribs where obj.compLoc.transparent.count > 0 collect obj
	myHid.count

	for obj in myHid do
	(
		for i = 1 to obj.compLoc.transparent.count do 
		(
			if obj.compLoc.transparent[i].node == undefined do appendifUnique myPb obj
		)
	)


	clearSelection()

	select myPb

)






-------------------------------

-- Animation Problem : 
----------------------


(
	myPb = #()


	-- collecte des objets avec CustomAttribute dans myAttribs
	myAttribs = for obj in objects where custAttributes.count obj == 1 collect obj
	myAttribs.count

	-- collecte des objets qui ont des entrées en Animated
	myHid = for obj in myAttribs where obj.compLoc.animated.count > 0 collect obj
	myHid.count

	for obj in myHid do
	(
		for i = 1 to obj.compLoc.animated.count do 
		(
			if obj.compLoc.animated[i].node == undefined do appendifUnique myPb obj
		)
	)


	clearSelection()

	select myPb

)


-------------------------------
show $.compLoc

show $.compLoc.hidden

$.compLoc.hotspot
$.compLoc.fov
$.compLoc.hidden
show $.compLoc.hidden[1]
$.compLoc.hidden[1].node
$.compLoc.hidden.count

$.comploc


myHid[1].compLoc.hidden[1].node
