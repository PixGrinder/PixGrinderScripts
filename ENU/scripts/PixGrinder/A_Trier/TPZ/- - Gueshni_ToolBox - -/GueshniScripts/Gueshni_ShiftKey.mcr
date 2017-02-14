macroScript ShiftKey category:"- Gueshni -" Icon:#("g9_shiftkey", 1) tooltip:"Shift Key"
 (
	DoShift

if (Shift_Keys != null) then DestroyDialog Shift_Keys

rollout Shift_Keys "Shift Keys" width:152 height:97
(
	checkbox Chk_Pos "Position" pos:[10,30] width:65 height:15 checked:true
	spinner spn1 "Shift:   " pos:[20,10] width:81 height:16 enabled:true range:[-1000,1000,1] type:#integer scale:1
	checkbox Chk_Rot "Rotation" pos:[10,48] width:65 height:15 checked:true
	checkbox Chk_Scale "Scale" pos:[85,30] width:65 height:15 checked:true
	checkbox Chk_Vis "Visibility" pos:[85,48] width:65 height:15 checked:false
	label lbl2 "frames" pos:[106,10] width:51 height:16
	button btn1 "Shift Keys" pos:[10,70] width:132 height:16 toolTip:""
	
	on btn1 pressed do
		DoShift spn1.value Chk_Pos.state Chk_Rot.state Chk_Scale.state Chk_Vis.state
)
CreateDialog Shift_Keys

fn filterName _obj =
(
	str = substring _obj.name (_obj.name.count-2) -1
	str = trimleft str "abcdefghijklmnopqrstuvwxyz_-+.é ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	return str as integer
)

fn DoShift _increment _Pos _Rot _Scale _Visible =
(
	if selection.count == 0 then
		messageBox "Sélection vide"
	else
	(
		counter = 0
		for obj in selection do
		(
			--find the value to shift in object name
			--shiftValue = ((filterName obj)-1)*_increment
			
			--Pour décaler les clés en fonction de l'ordre de sélection
			shiftValue = _increment*counter
			-- move all keys from asked amount
			if _Pos do
				movekeys obj.pos.controller shiftValue
			if _Rot do
				movekeys obj.rotation.controller shiftValue
			if _Scale do
				movekeys obj.scale.controller shiftValue
			if _Visible AND obj[1].controller != undefined do
				movekeys obj.visibility.controller shiftValue
			counter += 1
		)
	)
	)
)