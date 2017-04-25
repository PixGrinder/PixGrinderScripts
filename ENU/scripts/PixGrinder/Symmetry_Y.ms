---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Symmetry_Y.ms --
-- Quick object Symetry along Y axis --
-- V 1.0 --

---------------------------------------------------------------------




(
	clearListener()
	myMod = NormalModifier()
	myMod.flip = true
	myAR = #()

	for obj in selection do
	(
		--x1 = selection[1]
		myDum = Dummy pos:[0,0,0]
		x2 = copy obj
		x2.name=obj.name+"_mirror"
		x2.wireColor = obj.wireColor
		append myAR x2
		print myDum.scale
		in coordsys world scale myDum [1,-1,1] 
		delete myDum
		resetXForm x2
		addmodifier x2 myMod
		select #(obj,x2)
		collapseStack x2
		select x2
		max zoomext sel all 
	)
	x2.parent = myDum
)

