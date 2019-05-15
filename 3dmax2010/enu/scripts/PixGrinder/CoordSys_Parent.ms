-- CoordSys_Screen -- 



(
	tempMode = toolmode.commandmode
	theSys = #parent
	max rotate
	toolMode.coordsys theSys
	max scale
	toolMode.coordsys theSys
	max move
	toolMode.coordsys theSys
	toolmode.commandmode = tempMode
)