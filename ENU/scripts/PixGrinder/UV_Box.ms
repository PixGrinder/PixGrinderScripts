-------------------------------------------------------------------------------
-- Felipe_UV_Box.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2012/10/03
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

/*

macroScript UV_Box
category:"Felipe Scripts"
toolTip:"UVW Map Box Automation"
buttonText:"Collapse Selected"
icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true

*/

(
	/*
	pda_dim = ($.max - $.min) 
	global pda_ar = #()
	for i = 1 to 3  do  append pda_ar pda_dim[i]
	pda_sort = sort pda_ar
	pda_x = pda_ar[3]
	*/
	pda_x = 2.0

	myMod = UVWMap()
	myMod.name="UV Box"
	myMod.maptype = 4
	myMod.length = pda_x
	myMod.width = pda_x
	myMod.height = pda_x

	modPanel.addModToSelection (myMod)

	rollout autoMap "Mapping automatique" 
	(
		spinner MapValue "Map Value" type:#float  fieldwidth:50 range:[0.001,1000000,pda_x] pos:[100,20] --align:#center
		button collapse_btn "Collapse" pos:[70,55]
		button close_btn "Close" pos:[140,55]
		button cancel_btn "Cancel" pos:[200,55]
		on MapValue changed value do 
		(
			/*
			$.modifiers[1].length = MapValue.value
			$.modifiers[1].width = MapValue.value
			$.modifiers[1].height = MapValue.value
			*/
			myMod.length = MapValue.value
			myMod.width = MapValue.value
			myMod.height = MapValue.value
			
		)
		on collapse_btn pressed do 
		(
			for obj in selection do maxOps.CollapseNodeTo obj 1 off
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


