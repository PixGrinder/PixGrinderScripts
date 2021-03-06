macroScript KillMaterial category:"- Gueshni -" Icon:#("g9_killmaterial", 1) tooltip:"Kill Material"
 (
 (
-- Globals

global kill_mat_from_all

-- Functions

fn kill_mat_from_all = 
	(
	undo "KillMaterial" on
		(
		for i in selection do
			(
			i.material = undefined
			)
		)
	)

-- The Script

if selection.count == 0 then 
		(MessageBox "Please select at least one object" title:"KillMaterial")
	else
		(
		if (queryBox "Remove all materials from selected objects?" title:"KillMaterial") == true then kill_mat_from_all()
		)
)
)