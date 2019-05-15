--------------------------
-- SelectByAngle 		-- 
-- by PixGrinder 		-- 
-- dassonphil@gmail.com --
-- v1.0					--
--------------------------


(
	if subobjectlevel == 4 and (selection[1].SelectByAngle == off) then
	(
		selection[1].ignoreBackfacing = on
		selection[1].SelectByAngle = on
		selection[1].selectAngle = 20
	) else (
		selection[1].ignoreBackfacing = off
		selection[1].SelectByAngle = off
	)
)