-- Set Selection Pivot to Per Object

(
	tempMode = toolmode.commandmode
	max rotate
	toolMode.pivotCenter()
	max scale
	toolMode.pivotCenter()
	max move
	toolMode.pivotCenter()
	
	toolmode.commandmode = tempMode
)