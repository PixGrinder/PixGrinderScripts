
(
rollout boxCreator "resetObjState"

(
	
button button_reset "RESET" width:100 height:30

checkbox chkbx1 "reset Xform" checked: on
checkbox chkbx2 "center Pivot" checked: on
checkbox chkbx3 "smoothinGrp"
spinner spinner1 "" pos:[95,80] fieldwidth: 30 range:[0,90,45]
checkbox chkbx4 "reParent"	
radiobuttons radiobtn1 labels:#("Edit Mesh","Edit Poly") default: 2

	--If button_reset is pressed ...
	
	on button_reset pressed do
	(	
		for oggetto in selection do	
			(
			--unparent
			parent = oggetto.parent
			if (parent != undefined and chkbx4.checked == on) then
				( 
				oggetto.parent = undefined
				)
			--smothing group
			if (chkbx3.checked == on) then
				(
				addModifier oggetto (smooth())
				oggetto.smooth.threshold = spinner1.value	
				oggetto.smooth.autosmooth = on
				)
			--convert to reset
			if (radiobtn1.state == 1 ) then
				(convertToMesh oggetto)
			else if (radiobtn1.state == 2) then
				(convertToPoly oggetto)
			--center pivot
			if (chkbx2.checked == on) then
				(CenterPivot oggetto)
			--reset xform
			if (chkbx1.checked == on) then
				(ResetXForm oggetto)
			--convert to reset
			if (radiobtn1.state == 1 ) then
				(convertToMesh oggetto)
			else if (radiobtn1.state == 2) then
				(convertToPoly oggetto)
			--reparent
			if (parent != undefined and chkbx4.checked == on) then
				(
				oggetto.parent = parent
				)
			)
	)
)

createDialog boxCreator 145 160 --create a Dialog from the rollout
)