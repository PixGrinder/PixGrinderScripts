-- Cable Preset v1 --
-- Cable_SplinePreset.ms --
(
	if superclassof selection[1] == shape then 
	(
		convertToSplineShape selection[1]
		selection[1].render_renderable = true
		selection[1].render_displayRenderMesh = true
		selection[1].render_mapcoords = true
		selection[1].thickness = .1
		selection[1].steps = 0
		selection[1].render_sides = 5
		selection[1].render_threshold = 80.0
		selection[1].render_auto_smooth = true
		selection[1].optimize = true
	)
	completeRedraw()
)


