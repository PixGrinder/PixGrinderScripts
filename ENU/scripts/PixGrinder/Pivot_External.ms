-- Set Selection center to external

(
	tempMode = toolmode.commandmode
	max rotate
	toolMode.transformCenter()
	max scale
	toolMode.transformCenter()
	max move
	toolMode.transformCenter()
	toolmode.commandmode = tempMode
)

