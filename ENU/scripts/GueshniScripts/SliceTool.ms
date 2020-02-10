
try(destroyDialog SliceToolRollout)catch()
rollout SliceToolRollout "Slice Tool" width:248 height:152
(
	local mySliceModifiers = #()
	local SliceAxis = #X
	
	spinner 'NumberOfSlices' "Slices" pos:[145,16] width:62 height:16 range:[1,100,3] type:#integer align:#left
	GroupBox 'OptionsBox' "Options" pos:[8,8] width:115 height:136 align:#left
	button 'X_Button' "X" pos:[16,32] width:23 height:21 toolTip:"Slices along the X axis" align:#left
	button 'Y_Button' "Y" pos:[48,32] width:23 height:21 toolTip:"Slices along the Y axis" align:#left
	button 'Z_Button' "Z" pos:[80,32] width:23 height:21 toolTip:"Slices along the Z axis" align:#left
	checkbutton 'preview' "Preview" pos:[144,48] width:90 height:30 align:#left
	button 'Accept' "Accept" pos:[144,88] width:90 height:30 enabled:false align:#left
	checkbox 'Split_Mesh' "Split mesh" pos:[16,69] width:72 height:15 toolTip:"Check the \"Split Mesh\" option in every slice modifier." align:#left
	checkbox 'Collapse_Stack' "Collapse stack" pos:[16,93] width:93 height:15 checked:false toolTip:"Collapse the modifier stack after accepting." align:#left
	checkbox 'ResetXFormCheckbox' "Reset XForm before slicing" pos:[16,112] width:93 height:27 checked:false toolTip:"Useful when your object's local pivot is not aligned with the world." align:#left

	fn SliceMesh Axis:#X =
	(
		if Axis == #X do
		(
			if ResetXFormCheckbox.checked do
			(
				ResetXForm $
				ConvertTo $ Editable_Poly
			)
			
			objTM = $.objectTransform
			TotalDistance = $.max.x - $.min.x
			DistanceX = TotalDistance / (NumberOfSlices.value + 1)
			
			for i = 1 to NumberOfSlices.value do
			(
				mySlice = SliceModifier()
				addmodifier $ mySlice --ui:off
				modTM = getModContextTM $ mySlice
				mySlice.Slice_Plane.position = (([$.min.x,$.pos.y,$.pos.z] + i * [DistanceX,1,1]) * modTM * (inverse objTM))
				--mySlice.Slice_Plane.position = ([$.min.x,0,0] * modTM * (inverse objTM))
				mySlice.Slice_Plane.rotation.y_rotation = 90
				append mySliceModifiers mySlice
			)
		)
		if Axis == #Y do
		(
			if ResetXFormCheckbox.checked do
			(
				ResetXForm $
				ConvertTo $ Editable_Poly
			)
			
			objTM = $.objectTransform
			TotalDistance = $.max.y - $.min.y
			DistanceY = TotalDistance / (NumberOfSlices.value + 1)
			
			for i = 1 to NumberOfSlices.value do
			(
				mySlice = SliceModifier()
				addmodifier $ mySlice --ui:off
				modTM = getModContextTM $ mySlice
				mySlice.Slice_Plane.position = (([$.pos.x,$.min.y,$.pos.z] + i * [1,DistanceY,1]) * modTM * (inverse objTM))
				--mySlice.Slice_Plane.position = ([$.min.x,0,0] * modTM * (inverse objTM))
				mySlice.Slice_Plane.rotation.x_rotation = 90
				append mySliceModifiers mySlice
			)
		)
		if Axis == #Z do
		(
			if ResetXFormCheckbox.checked do
			(
				ResetXForm $
				ConvertTo $ Editable_Poly
			)
			
			objTM = $.objectTransform
			TotalDistance = $.max.z - $.min.z
			DistanceZ = TotalDistance / (NumberOfSlices.value + 1)
			
			for i = 1 to NumberOfSlices.value do
			(
				mySlice = SliceModifier()
				addmodifier $ mySlice --ui:off
				modTM = getModContextTM $ mySlice
				mySlice.Slice_Plane.position = (([$.pos.x,$.pos.y,$.min.z] + i * [1,1,DistanceZ]) * modTM * (inverse objTM))
				--mySlice.Slice_Plane.position = ([$.min.x,0,0] * modTM * (inverse objTM))
				--mySlice.Slice_Plane.rotation.y_rotation = 90
				append mySliceModifiers mySlice
			)
		)
	)
	
	fn DeleteSlices =
	(
		for i in mySliceModifiers do
		(
			try(deleteModifier $ i)catch()
		)
		free mySliceModifiers
	)

	on SliceToolRollout close do
	(
		DeleteSlices()
	)
	on NumberOfSlices changed NewValue do
	(
		if selection.count == 1 then
		(
			if Preview.state == on do
			(
				DeleteSlices()
				SliceMesh Axis:SliceAxis
				completeRedraw()
			)
		)
	)
	on X_Button pressed do
	(
		SliceAxis = #X
		if Preview.state == on do
		(
			DeleteSlices()
			SliceMesh Axis:SliceAxis
		)
	)
	on Y_Button pressed do
	(
		SliceAxis = #Y
		if Preview.state == on do
		(
			DeleteSlices()
			SliceMesh Axis:SliceAxis
		)
	)
	on Z_Button pressed do
	(
		SliceAxis = #Z
		if Preview.state == on do
		(
			DeleteSlices()
			SliceMesh Axis:SliceAxis
		)
	)
	on preview changed PreviewState do
	(
		if PreviewState == on then
		(
			if selection.count == 1 then
			(
				SliceMesh Axis:SliceAxis
				completeRedraw()
				Accept.enabled = true
			)
			else
			(
				if selection.count == 0 then
				(
					MessageBox "Selection is empty ! :o"
					Preview.state = off
				)
				else
				(
					MessageBox "Please select only one object ;)"
					Preview.state = off
				)
			)
		)
		else
		(
			DeleteSlices()
			Accept.enabled = false
		)
	)
	on Accept pressed do
	(
		if selection.count == 1 then
		(
			if Split_Mesh.checked do
			(
				for i in mySliceModifiers do
				(
					i.Slice_Type = 1
				)
			)
			if Collapse_Stack.checked then
			(
				free mySliceModifiers
				collapseStack $
				Preview.state = off
				Accept.enabled = false
			)
			else
			(
				free mySliceModifiers
				addmodifier $ (Edit_Poly())
				Preview.state = off
				Accept.enabled = false
			)
		)
		else
		(
			MessageBox "Selection is empty ! :o"
		)
	)
	
)
CreateDialog SliceToolRollout style:#(#style_titlebar, #style_sysmenu, #style_toolwindow) pos:[140,210] bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)