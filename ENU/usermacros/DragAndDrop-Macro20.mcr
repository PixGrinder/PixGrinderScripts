macroScript Macro20
	category:"DragAndDrop"
	toolTip:""
(
	(
		myO = $
		myCop = copy $ name:($.name+"_mirror")
		max modify mode
		resetXForm myCop
		collapseStack myCop
		myCop.pivot.y = 0
		addmodifier myCop (Mirror())
		myCop.modifiers[myCop.modifiers.count].mirror_axis = 1
		myCop.modifiers[myCop.modifiers.count].copy = false
		myCop.modifiers[myCop.modifiers.count][1].position.y = -myCop.center.y
		collapseStack myCop
		myCop.pivot = myCop.center
		myO.pivot = myO.center
	)
)
