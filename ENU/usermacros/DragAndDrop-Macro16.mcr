macroScript Macro16
	category:"DragAndDrop"
	toolTip:""
(
	selection[1].pivot.y = 0
	addmodifier $ (Mirror())
	$.modifiers[$.modifiers.count].mirror_axis = 1
	$.modifiers[$.modifiers.count].copy = true
	$.modifiers[$.modifiers.count][1].position.y = -$.center.y
	collapseStack $
)
