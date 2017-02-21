
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Select Small Objects (Geometry) --
-- Select_Small_Objects.ms --
-- Selects all small objects based on bbox min/max distance with a threshold--
-- V 1.0 --

---------------------------------------------------------------------


(
	clearListener()
	clearSelection()
	myValue = 0.2
	pda = #()
	for obj in geometry do
	(
		if ((distance obj.max obj.min) < myValue) == true do appendifunique pda obj
	)

	select pda
)

