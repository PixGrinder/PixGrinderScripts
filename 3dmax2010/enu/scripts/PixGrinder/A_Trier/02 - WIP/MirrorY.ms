-- Mirror Y
(
	(
		myO = selection[1]
		myCop = copy $ name:($.name+"_mirror")
		max modify mode
		resetXForm myCop
		collapseStack myCop
		myCop.pivot.y = 0 in coordsys world
		addmodifier myCop (Mirror())
		myCop.modifiers[myCop.modifiers.count].mirror_axis = 1
		myCop.modifiers[myCop.modifiers.count].copy = false
		select myCop
		subobjectlevel = 0
		myCop.modifiers[myCop.modifiers.count].Mirror_Center.position.y = -1.0 * myCop.center.y
		
		collapseStack myCop
		myCop.pivot = myCop.center
		myO.pivot = myO.center
		redrawViews()
		
	)
)
