-- Locks Toggler V1

(
	for obj in selection do
	(
		x1 = getTransformLockFlags obj
		if (x1 as array).count < 9 then setTransformLockFlags obj #all else setTransformLockFlags obj #none
		
	)
)
