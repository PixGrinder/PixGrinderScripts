-- Transfer Comploc Custom Attributes


(

	clearListener()
	if selection.count != 2 then messagebox("Please select only 2 objects") else 
	(
		if custAttributes.count selection[2] > 0 do custAttributes.delete selection[2] 1 baseObject:true
		custAttributes.add selection[2] _cl.compLocCA BaseObject:true
		selection[2].compLoc.hotspot = selection[1].compLoc.hotspot
		selection[2].compLoc.fov = selection[1].compLoc.fov
		selection[2].compLoc.hidden = selection[1].compLoc.hidden
		selection[2].compLoc.transparent = selection[1].compLoc.transparent
		selection[2].compLoc.animated = selection[1].compLoc.animated
		custAttributes.delete selection[1] 1 baseObject:true
		selection[2].name = selection[1].name 
		delete selection[1]
	)

)
