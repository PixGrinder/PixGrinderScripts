macroScript BBoxMaker category:"- Gueshni -" Icon:#("g9_bboxmaker", 1) tooltip:"BBox Maker"
 (
	 on execute do
	(
undo "BBoxMaker" on
	(
	for i in selection do
		(
		l = (i.max.y - i.min.y)
		w = (i.max.x - i.min.x)
		h = (i.max.z - i.min.z)
		c = i.center - [0, 0, (h/2)]		
		the_box = Box lengthsegs:1 widthsegs:1 heightsegs:1 length:l width:w height:h pos:c
		the_box.name = i.name + "_box"
		)
	)
)
	)