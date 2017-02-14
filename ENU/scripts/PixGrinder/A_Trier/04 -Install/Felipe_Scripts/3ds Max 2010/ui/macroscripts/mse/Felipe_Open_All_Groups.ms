macroScript Open_All_Groups
category:"Felipe Scripts"
toolTip:"Open All Groups"

(
	if helpers.count < 1 then 
	(
		messageBox "Aborted: No groups in scene"
	) else 
	(
		for i = 1 to 100 do 
		(
			select helpers
			max group open
		)
	)
)


