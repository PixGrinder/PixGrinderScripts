
-- Detect wrong controllers for animated objects

-- (
-- 	x1 = for obj in objects where (obj.isAnimated == true and (obj.pos.controller != position_XYZ ()	or obj.rotation.controller != linear_rotation ())) collect obj
-- 		
-- 	select x1
-- 		
-- 	
-- )




for obj in selection do obj.rotation.controller = linear_rotation()