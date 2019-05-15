-- CoordSys_View -- 



(
	tempMode = toolmode.commandmode
	theSys = #view
	max rotate
	toolMode.coordsys theSys
	max scale
	toolMode.coordsys theSys
	max move
	toolMode.coordsys theSys
	toolmode.commandmode = tempMode
)