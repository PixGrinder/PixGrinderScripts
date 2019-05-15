
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Doublon_Finder.ms --
-- Doublon_Finder --
-- Selects double names in the 3d scene--
-- V 1.2 --

---------------------------------------------------------------------
(
	clearListener()
	clearSelection()
	pda = #()
	for obj in objects do
	(
		x1 = getNodeByName obj.name exact:true ignoreCase:false all:true
		if x1.count >1 do 
		(
			for bla in x1 do append pda bla
		)
		
	)
	clearSelection()
	print pda.count
	for obj in pda do print obj.name -- added
	select pda
	if pda.count == 0 then messageBox("No Double Names in this scene")
)