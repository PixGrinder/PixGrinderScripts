--check for negative scale



NScale = #()
max select all
for obj in selection do
(
	if obj.isHiddenInVpt != true then(
	if obj.scale.x < 0 or obj.scale.y < 0 or obj.scale.z < 0 then appendIfUnique NScale obj.name
	)
)
clearSelection()




Rollout NegativeScale "Check for negative scale" width: 350 height:(NScale.count * 18 + 30)
(
button btn_reload "RELOAD" 
listbox NObjects items:Nscale height: NScale.count

	
fn TestScale = 
(
	NScale = #()
	max select all
	for obj in selection do
	(
		if obj.isHiddenInVpt != true then(
		if obj.scale.x < 0 or obj.scale.y < 0 or obj.scale.z < 0 then appendIfUnique NScale obj.name
		)
	)
	clearSelection()
)

	
on NegativeScale open do TestScale()

	
on NObjects selected i do 
(
	select (getNodeByName NObjects.selected all:true)
	for obj in selection do if obj.isHiddenInVpt == true then deselect obj
)	
	

on btn_reload pressed do 
(
	local Pos = getdialogPos NegativeScale
	try (destroyDialog NegativeScale) catch()
	TestScale()
	createDialog NegativeScale style:#(#style_toolwindow, #style_sysmenu) pos: Pos height:(NScale.count * 18 + 30)
)

)
createDialog NegativeScale style:#(#style_toolwindow, #style_sysmenu)
	