macroScript Macro40
	category:"DragAndDrop"
	toolTip:""
(
	myTemp = selection[2]
	selection[2].name = selection[1].name
	delete selection[1]
	select myTemp
	myTemp = undefined
)
