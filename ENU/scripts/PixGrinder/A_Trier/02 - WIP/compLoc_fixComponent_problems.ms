

	global myHide =#()
	global myTransp =#()
	global myAnim = #()


fn fixComponents myVar= 
(
	


	pda = #()
-- 	print myVar.compLoc.hidden.count
	for i = 1 to myVar.compLoc.hidden.count do
	(
		if myVar.compLoc.hidden[i].node == undefined do 
		(
			appendIfUnique myHide myVar.name
			append pda i
		)

	) 

	for obj in pda do deleteItem myVar.compLoc.hidden obj

-- 	print myVar.compLoc.hidden.count


	pda = #()
-- 	print myVar.compLoc.transparent.count
	for i = 1 to myVar.compLoc.transparent.count do
	(
		if myVar.compLoc.transparent[i].node == undefined do 
		(
			appendIfUnique myTransp myVar.name
			append pda i
			
		)

	) 

	for obj in pda do deleteItem myVar.compLoc.transparent obj

-- 	print myVar.compLoc.transparent.count

	pda = #()
-- 	print myVar.compLoc.transparent.count
	for i = 1 to myVar.compLoc.animated.count do
	(
		if myVar.compLoc.animated[i].node == undefined do 
		(
			appendIfUnique myAnim myVar.name
			append pda i
		)

	) 

	for obj in pda do deleteItem myVar.compLoc.animated obj

)

(
	setCommandPanelTaskMode mode:#modify
	SetQuietMode true
	for obj in objects where custAttributes.count obj == 1 do fixComponents obj
	clearListener()


	print "Hidden problems : "
	print "------------------"
	print " "
	for obj in myHide do print obj
	print "Transparent problems : "
	print "------------------"
	print " "
	for obj in myTransp do print obj

	print "Animation problems : "
	print "------------------"
	print " "
	for obj in myAnim do print obj


	SetQuietMode false




)