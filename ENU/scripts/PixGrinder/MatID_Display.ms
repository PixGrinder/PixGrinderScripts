-- Material show ID number -- 

rollout matId "matId"
(
	label lbl1 "Find material ID #" offset:[0,10]
	spinner mySpinner "" range:[1,10000,1] type:#integer align:#center offset:[0,10]
	--button myBtn "OK"

	on mySpinner entered do
	(
		if meditMaterials[1][mySpinner.value] != undefined then 
		(
			meditMaterials[3] = meditMaterials[1][mySpinner.value]
			activeMeditSlot = 3
			if not MatEditor.isOpen() then
			(
				MatEditor.mode = #basic
				MatEditor.Open()
			)
		)
	)
)

try(DestroyDialog matId) catch()
CreateDialog matId height:75
if not MatEditor.isOpen() then
(
	MatEditor.mode = #basic
	MatEditor.Open()
)


/*

edittext <name> [<caption>] [text:<string>] [fieldWidth:<integer>] [height:<integer>] [bold:<boolean>] [labelOnTop:<boolean>] [readOnly:<boolean>] [toolTip:<string>]


spinner <name> [<caption>] [range:[min,max,val]] [type:<name>] [scale:<float>] [fieldWidth:<integer>] [toolTip:<string>] [indeterminate:<boolean>] [controller:(<controller>)] [setKeyBrackets:<boolean>] 	 The default alignment of spinner items is #right 


*/