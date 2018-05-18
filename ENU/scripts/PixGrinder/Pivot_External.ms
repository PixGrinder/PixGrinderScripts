-- Set Selection center to external

(
	tempMode = toolmode.commandmode
	tempSys = toolMode.coordsys
	max rotate
	toolMode.transformCenter()
	toolMode.coordsys = tempSys
	max scale
	toolMode.transformCenter()
	toolMode.coordsys = tempSys
	max move
	toolMode.transformCenter()
	toolMode.coordsys = tempSys
	toolmode.commandmode = tempMode
)

