-- Set Selection Pivot to Center

(
	tempMode = toolmode.commandmode
	max rotate
	toolMode.selectionCenter()
	max scale
	toolMode.selectionCenter()
	max move
	toolMode.selectionCenter()
	toolmode.commandmode = tempMode
)