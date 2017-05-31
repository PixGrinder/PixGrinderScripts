---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Select Next --
-- Select_Next.ms --
-- Selects next object --
-- V 7.0  --
-- Interface Rollout Added with choice to zoom on selected object (or not) --
-- Requires "PixGrinderStartup.ms"  v 1.1 to Work !!! --


---------------------------------------------------------------------


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
	if selection.count == 0 then (x1 = 1) else (x1 = finditem (objects as array) selection[1])
	if x1 < objects.count then select objects[x1+1] else select objects[1]
	if pda_mySelector.myRad.state == 1 then max zoomext sel all
	---------------------------------------------------------------------------
)


