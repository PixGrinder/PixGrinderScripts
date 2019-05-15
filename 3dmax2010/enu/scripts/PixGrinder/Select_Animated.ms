-- Select Animated --
-- Select_Animated.ms --
-- Selects all animated objects in the scene -- 
-- v1.0 --


(
	clearListener()
	clearSelection()
	select (for obj in objects where obj.isAnimated collect obj)
)