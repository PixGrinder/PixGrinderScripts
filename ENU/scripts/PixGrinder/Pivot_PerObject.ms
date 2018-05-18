-- Set Selection Pivot to Per Object

(
	tempMode = toolmode.commandmode
	tempSys = toolMode.coordsys
	max rotate
	toolMode.pivotCenter()
	toolMode.coordsys = tempSys
	max scale
	toolMode.pivotCenter()
	toolMode.coordsys = tempSys
	max move
	toolMode.pivotCenter()
	toolMode.coordsys = tempSys
	toolmode.commandmode = tempMode
)