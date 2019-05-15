


-- V2 --

addModifier $ (UVWMap() ) 
$.modifiers[#UVW_Mapping].maptype = 4
$.modifiers[#UVW_Mapping].length = 100
$.modifiers[#UVW_Mapping].width = 100
$.modifiers[#UVW_Mapping].height = 100

	rollout autoMap "Mapping automatique" 
	(
		spinner MapValue "Map Value" type:#float  fieldwidth:50 range:[0.1,1000,100] pos:[100,20] --align:#center
		button collapse_btn "Collapse" pos:[70,55]
		button close_btn "Close" pos:[140,55]
		button cancel_btn "Cancel" pos:[200,55]
		on MapValue changed value do 
		(
			$.modifiers[#UVW_Mapping].length = MapValue.value
			$.modifiers[#UVW_Mapping].width = MapValue.value
			$.modifiers[#UVW_Mapping].height = MapValue.value
			
		)
		on collapse_btn pressed do 
		(
			maxOps.CollapseNodeTo $ 1 off
			destroyDialog autoMap
		)
		
		on close_btn pressed do destroyDialog autoMap
			
		on cancel_btn pressed do
		(
			
			deleteModifier $ $.modifiers.count
			destroyDialog autoMap
			
		)
		
	)

	createDialog autoMap 300 100