(
	-- Link Transfert -- 
	-- Assigns the hierarchy of one object to another -- 

	-- 1 - Select object with the source Hierarchy --
	-- 2 - Select object who receives the hierarchy --
	-- 3 - Run this script --

	if selection.count == 2 then 
	(
		myGraph = for obj in selection[1].children collect obj
		for obj in myGraph do obj.parent = selection[2]
	)
	select selection[2]
)