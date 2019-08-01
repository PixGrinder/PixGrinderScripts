---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Symmetry_Y.ms --
-- Quick object Symetry along Y axis --
-- V 1.2 --
-- Acts on a selection of objects --

---------------------------------------------------------------------




(
	clearListener()
	selection[1].layer.current = true
	myMod = NormalModifier()
	myMod.flip = true
	myAR = #()
	myDum = Dummy pos:[0,0,0]

	for obj in selection do
	(
		x2 = copy obj
		x2.name=obj.name+"_mirror"
		x2.wireColor = obj.wireColor
		append myAR x2
	)
	for obj in myAR do obj.parent = myDum
	in coordsys world scale myDum [1,-1,1] 
	delete myDum
	for obj in myAR do
	(	
		resetXForm obj
		addmodifier obj myMod
		collapseStack obj
	)
	select myAR
	max zoomext sel all 
)

