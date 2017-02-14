
(
	for obj in selection do
	(
		if classof obj == SplineShape  and obj.render_thickness < 0.03 do
		(
			obj.render_sides = 3
			obj.render_threshold = 120
		)
	)
)

