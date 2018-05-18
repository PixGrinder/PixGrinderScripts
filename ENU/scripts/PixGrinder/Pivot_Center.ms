-- Set Selection Pivot to Center

(
	tempMode = toolmode.commandmode
	tempSys = toolMode.coordsys
	max rotate
	toolMode.selectionCenter()
	toolMode.coordsys = tempSys
	max scale
	toolMode.selectionCenter()
	toolMode.coordsys = tempSys
	max move
	toolMode.selectionCenter()
	toolMode.coordsys = tempSys
	toolmode.commandmode = tempMode
)