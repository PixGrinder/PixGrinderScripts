-- Quick object Symetry along Y axis --

(
	clearListener()
	myMod = NormalModifier()
	myMod.flip = true
	x1 = selection[1]
	myDum = Dummy pos:[0,0,0]
	x2 = copy x1
	x2.name=x1.name+"_mirror"
	x2.wireColor = x1.wireColor
	x2.parent = myDum
	print myDum.scale
	scale myDum [1,-1,1] in coordsys world
	delete myDum
	resetXForm x2
	addmodifier x2 myMod
	select #(x1,x2)
	collapseStack x2
)

