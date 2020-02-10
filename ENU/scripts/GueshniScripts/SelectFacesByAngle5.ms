
(
	subobjectLevel = 4
	if $.ignoreBackfacing == off then (
		$.ignoreBackfacing = on
		$.SelectByAngle = on
		$.selectAngle = 5
		)
	else (
		$.ignoreBackfacing = off
		$.SelectByAngle = off
		$.selectAngle = 45
		)
	
)