macroScript CloneAlignFace category:"- Gueshni -" Icon:#("g9_clonealignface", 1) tooltip:"Clone Align Face"
 (
try(destroyDialog ::bgaRoll)catch()
rollout bgaRoll "Clone&AlignOnFace"
(
	local target, source, clonenodes = maxops.clonenodes
	fn filtSel obj = not obj.isSelected
	fn cloneAndAlignToFaces target source faces mode:#clone = 
	(
		local used = #{}, first = on, getFaceCenter = meshop.getFaceCenter, getPuF = meshop.getPolysUsingFace, groups = #(), state = off
		local modeOp = case mode of
		(
			#copy: copy
			#instance: instance
			#reference: reference
		)
		fn averageFacePosNormal mesh faces gfc:getFaceCenter = 
		(
			local n = [0,0,0], c = [0,0,0], gfc = meshop.getFaceCenter
			for f in faces do n += (getFaceNormal mesh f)
			for f in faces do c += (gfc mesh f)
			dataPair normal:(normalize (n/2)) center:(c/2)
		)
		with redraw off for f in faces where not used[f] collect
		(
			polys = getPuF target f ; used += polys
			dp = averageFacePosNormal target polys
			face = (polys as array)[1]
			vv = getFace target face
			dir = normalize ((getVert target vv[2]) - (getVert target vv[1]))
			side = normalize (cross dir dp.normal)
			front = normalize (cross dp.normal side)
			tm = matrix3 front side dp.normal dp.center
			if first then (source.transform = tm ; first = off) else 
			(
				clonenodes #(source) expandHierarchy:on cloneType:mode newNodes:&nodes #nodialog
				source.transform = tm
			)
			if isGroupHead source do setGroupOpen source off
		)
	)
	fn rotateNode objs mode: axis: ang: = if objs.count == 0 then (return messageBox "Pick Some Objects First" beep:off) else
	(
		ang = if mode != #ccw then -ang else ang
		ang = case axis of
		(
			1: (EulerAngles ang 0 0)
			2: (EulerAngles 0 ang 0)
			3: (EulerAngles 0 0 ang)
		)
		in coordsys local rotate selection ang
	)
	group "Clone && Align:"
	(
		label lbl1 "  Select Faces On Target Object\n   And Then Pick Source Object" pos:[10,20] width:160 height:30 style_sunkenedge:on
		radiobuttons rb_clone labels:#("copy", "instance", "reference") pos:[10,55] default:2
		checkbutton pb_source "Pick Source" pos:[80,55] width:90 height:43 highlightColor:[30,30,30]
		--checkbutton pb_group "Pick Source" pos:[80,55] width:90 height:43 highlightColor:[30,30,30]
	)
	group "Twick Local Rotation:"
	(
		radiobuttons rb_axis labels:#("X", "Y", "Z") pos:[10,125] default:3
		spinner spn_angle "" pos:[100,125] range:[0,360,90] fieldwidth:58
		button btn_ccw "CCW" pos:[10,145] width:78
		button btn_cw "CW" pos:[92,145] width:78
	)
	on pb_source changed state do if state do 
	(
		if selection.count == 0 then (pb_source.checked = off ; messageBox "Select Target Object First" beep:off) else
		(
			if not (canConvertTo selection[1] Editable_Mesh) then (pb_source.checked = off ; messageBox "Target Object Must Be Geomety" beep:off) else
			(
				local obj = selection[1]
				local target = snapshotAsMesh obj
				if (faces = target.selectedfaces as bitarray).isEmpty then 
				(
					pb_source.checked = off
					messageBox "Select Some Faces On Target Object" beep:off
				) 
				else
				(
					if isValidNode (source = pickObject count:1 select:off prompt:"Pick Source Object" filter:filtSel) do
					(
						max create mode
						with undo "Clone&Align" on (cloneAndAlignToFaces target source faces mode:(#(#copy,#instance,#reference)[rb_clone.state]))
						free faces ; free nodes ; delete target ; pb_source.checked = off ; CompleteRedraw()
					)
				)
			)
		)
	)
	on btn_ccw pressed do rotateNode selection mode:#ccw axis:rb_axis.state ang:spn_angle.value
	on btn_cw pressed do rotateNode selection mode:#cw axis:rb_axis.state ang:spn_angle.value
)
createDialog bgaRoll 180 176 style:#(#style_titlebar, #style_sysmenu, #style_toolwindow) ; ok
)