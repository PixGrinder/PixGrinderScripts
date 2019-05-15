macroScript WirecolorByLayer category:"- Gueshni -" Icon:#("g9_wirecolorbylayer", 1) tooltip:"Wirecolor by Layer"
 (
	for o in selection do
	(
		o.colorByLayer = on ; o.wirecolor = o.layer.wirecolor
		o.displaybylayer = on
		o.renderbylayer = on
		o.motionbylayer = on
	)
)