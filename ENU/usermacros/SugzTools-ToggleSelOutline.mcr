macroScript ToggleSelOutline
	category:"SugzTools"
	toolTip:"Toggle Selection Outline"
	Icon:#("SugzTools",2)
	
(
	-- Predefine the extend max struct
	global _sgz
	
	-- Execute the Selection Outline ActionMan 
	on execute do actionMan.executeAction 0 "63565"
	
	-- Get the current Selection Outline state from the Extend 3ds Max Struct
	on isChecked return (if _sgz != undefined then _sgz._extMxs.GetActionManState "Main UI" 63565 else false)
	
)
