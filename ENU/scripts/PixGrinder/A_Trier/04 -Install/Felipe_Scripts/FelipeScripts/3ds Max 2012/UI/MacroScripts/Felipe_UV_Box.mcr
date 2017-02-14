-------------------------------------------------------------------------------
-- Felipe_UV_Box.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2012/10/03
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript UV_Box
category:"Felipe Scripts"
toolTip:"UVW Map Box Automation"

(

	pda_dim = ($.max - $.min) 
	global pda_ar = #()
	for i = 1 to 3  do  append pda_ar pda_dim[i]
	pda_sort = sort pda_ar
	pda_x = pda_ar[3]

addModifier $ (UVWMap() ) 
$.modifiers[#UVW_Mapping].maptype = 4
$.modifiers[#UVW_Mapping].length = pda_x
$.modifiers[#UVW_Mapping].width = pda_x
$.modifiers[#UVW_Mapping].height = pda_x



	rollout autoMap "Mapping automatique" 
	(
		spinner MapValue "Map Value" type:#float  fieldwidth:50 range:[0.1,1000000,pda_x] pos:[100,20] --align:#center
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
	
	
)


