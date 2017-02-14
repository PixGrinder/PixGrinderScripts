macroScript Macro18
	category:"DragAndDrop"
	toolTip:""
(
	(
		selection[1].pivot.y = 0
		addmodifier $ (Mirror())
		$.modifiers[$.modifiers.count].mirror_axis = 1
		collapseStack $
	)
)
