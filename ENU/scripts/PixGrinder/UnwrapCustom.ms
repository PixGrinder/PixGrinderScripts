-- UnwrapCustom -- 


if classof selection[1].material == MultiMaterial then 
(
	--myMatBackup = selection[1].material
	meditMaterials[1] = selection[1].material
	convertToPoly selection[1]
	myId = getFaceSelection selection[1] as array
	myId = selection[1].getFaceMaterial myId[1]
	meditmaterials[2] = copy selection[1].material[myId]
	selection[1].material = meditMaterials[2]
	addModifier selection[1]  (Unwrap_UVW())
	medit.SetActiveMtlSlot 1 on
	selection[1].modifiers[1].edit()
) else (
	addModifier selection[1]  (Unwrap_UVW())
)