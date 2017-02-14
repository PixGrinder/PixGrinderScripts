-- Script : One click Change wire Color on selection
(
	(
		for obj in selection do 
		(
			try (obj.wirecolor = color (random 0 255) (random 0 255) (random 0 255)) catch (print (obj.name + " isn't from Geometry Class"))
			--obj.material = undefined
		)
		redrawViews()
	)
)
