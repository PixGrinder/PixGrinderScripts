
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Doublon_Finder_VisibleObjects.ms --
-- Doublon_Finder on Visible Objects--
-- Selects double names in the 3d scene, only on visible objects (to check an export )--
-- V 1.3 --

---------------------------------------------------------------------
(
	clearListener()
	clearSelection()
	global pda = #()
	function myCompare v1 v2 = 
	(
		if v1[1] > v2[1] then 1 else -1
	)

	myVisible = for obj in objects where not obj.isHidden collect #(obj.name,obj)

	qsort myVisible myCompare

	--for obj in myVisible do print obj[1]

	i=1
	while i < myVisible.count do
	(
			if myVisible[i][1] == myVisible[i+1][1] then 
			(
				append pda (myVisible[i][2])
				append pda (myVisible[i+1][2])
			)
			i = i+1
	)

	clearSelection()
	select pda

)
