


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

	-- fixxx : 

	for obj in myPb where obj.compLoc.hidden.count == 1 do obj.compLoc.hidden.count = 0



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



-- Transparent fixxx

x1 = for obj in $.compLoc.transparent where obj.node != undefined collect obj.node
$.compLoc.transparent.count = x1.count
for i = 1 to x1.count do $.compLoc.transparent[i].node = x1[i]
$.compLoc.transparent.count





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

$.comploc.animated.count

$.comploc.animated[1].node


myHid[1].compLoc.hidden[1].node


$.comploc.animated.count
$.comploc.animated.count = 0



$.compLoc.hidden.count


for i = 1 to $.compLoc.hidden.count where $.compLoc.hidden[i].node != undefined do print $.compLoc.hidden[i].node


for i = 1 to $.compLoc.transparent.count where $.compLoc.transparent[i].node != undefined do print (i as string + "  "+$.compLoc.transparent[i].node.name)





for obj in selection do obj.compLoc.hidden.count = 0


$.comploc.transparent.count