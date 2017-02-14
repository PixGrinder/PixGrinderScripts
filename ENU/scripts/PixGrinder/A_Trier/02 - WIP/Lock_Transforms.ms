-- locks

for obj in selection do
(
	x1 = getTransformLockFlags obj
	if (x1 as array).count < 8 then setTransformLockFlags obj #all else setTransformLockFlags obj #none
	
)


-------------------------------

x1 = getTransformLockFlags $
(x1 as array).count


setTransformLockFlags $ #all


setTransformLockFlags $ #none