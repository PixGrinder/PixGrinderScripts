-- CoordSys_Local -- 



(
	tempMode = toolmode.commandmode
	theSys = #local
	max rotate
	toolMode.coordsys theSys
	max scale
	toolMode.coordsys theSys
	max move
	toolMode.coordsys theSys
	toolmode.commandmode = tempMode
)