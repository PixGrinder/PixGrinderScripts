---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Select Prev --
-- Select_Prev.ms --
-- Selects previous object --
-- V 7.0  --
-- Interface Rollout Added with choice to zoom on selected object (or not) --
-- Requires "PixGrinderStartup.ms"  v 1.1 to Work !!! --


---------------------------------------------------------------------


(
	if objects.count == 0 then messageBox("No objects in scene !!") else
	(
		if pda_mySelectorFloater == undefined then pda_myBoxOpen = false
		if pda_mySelectorFloater != undefined and pda_mySelectorFloater.open == false then pda_myBoxOpen = false
	
		if pda_myBoxOpen == false then
		(
			pda_mySelectorFloater = newRolloutFloater "SelectNext" 200 60 150 150
			addRollout pda_mySelector pda_mySelectorFloater
			pda_myBoxOpen = true
		)
	
		-- Total reBuild --
		---------------------------------------------------------------------------
		if selection.count == 0 then (x1 = objects.count) else (x1 = finditem (objects as array) selection[1])
		if x1 > 2  then select objects[x1-1] else select objects[objects.count]
		if pda_mySelector.myRad.state == 1 then max zoomext sel all
		---------------------------------------------------------------------------
	)
)


