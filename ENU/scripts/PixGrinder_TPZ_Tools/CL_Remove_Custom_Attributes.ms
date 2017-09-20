-- CL_Remove_Custom_Attributes.ms --
-- v2 - Cam removal added --
(
	if selection.count == 0 then messageBox ("Please select comploc Tagged Components") else 
	(
		for obj in selection do custAttributes.delete obj 1
	)
)