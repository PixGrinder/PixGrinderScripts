
-- attach Poly without material condense
(
	clearListener()
	myTemp = getCurrentSelection()
	convertToPoly myTemp[1]
	convertToPoly myTemp[2]
	select myTemp[1]
	myTemp[1].EditablePoly.attach myTemp[2] myTemp[1]
)
