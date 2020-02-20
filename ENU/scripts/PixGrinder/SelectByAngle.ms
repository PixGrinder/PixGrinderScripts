--------------------------
-- SelectByAngle 		-- 
-- by PixGrinder 		-- 
-- dassonphil@gmail.com --
-- v1.0					--
--------------------------

try (DestroyDialog selByAngle) catch()


rollout selByAngle "selByAngle"
(
	Spinner mySpin "Angle" range:[1,80,20] type:#integer
	button my20 "20" across:3
	button my45 "45"
	button my80 "80"

	on mySpin changed state do selection[1].selectAngle = mySpin.value

	on my20 pressed do 
	(
		selection[1].selectAngle = 20.0
		mySpin.value = 20.0
	)
	on my45 pressed do 
	(
		selection[1].selectAngle = 45.0
		mySpin.value = 45.0
	)

	on my80 pressed do 
	(
		selection[1].selectAngle = 80.0
		mySpin.value = 80.0
	)

)



(
	

	if subobjectlevel == 4 and (selection[1].SelectByAngle == off) then
	(
		selection[1].ignoreBackfacing = on
		selection[1].SelectByAngle = on
		selection[1].selectAngle = 20
		createDialog selByAngle 300 50 1900 500
	) else (
		selection[1].ignoreBackfacing = off
		selection[1].SelectByAngle = off
		DestroyDialog selByAngle
	)
)