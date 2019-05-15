-- CoordSys_World -- 



(
	tempMode = toolmode.commandmode
	theSys = #world
	max rotate
	toolMode.coordsys theSys
	max scale
	toolMode.coordsys theSys
	max move
	toolMode.coordsys theSys
	toolmode.commandmode = tempMode
)