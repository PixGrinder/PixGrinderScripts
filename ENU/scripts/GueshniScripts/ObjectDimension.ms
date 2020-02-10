(
local sel = #()
--GUI-------------------------------------------------------------
	
try(destroyDialog ACDimensionRollout)catch()
rollout ACDimensionRollout "Object Dimensions" width:170 height:170
(
	groupBox DimGroupBox "Dimensions" pos:[10,10] width:150 height:150
	spinner widthSpinner "" pos:[70,30] width:80 height:16 enabled:false range:[0,100000,0] scale:0.001
	spinner lengthSpinner "" pos:[70,50] width:80 height:16 enabled:false range:[0,100000,0] scale:0.001
	spinner hieghtSpinner "" pos:[70,70] width:80 height:16 enabled:false range:[0,100000,0] scale:0.001
	button InitializeButton "Initialize" pos:[20,95] width:130 height:25
	label lengthLable "Length(Y):" pos:[20,50] width:48 height:16
	label widthLable "Width(X):" pos:[20,30] width:48 height:16
	label hieghtLable "Hieght(Z):" pos:[20,70] width:48 height:16
	button removeButton "Remove" pos:[100,130] width:50 height:20
	button CStackButton "CollapseStack" pos:[20,130] width:75 height:20
	
	on InitializeButton pressed do
	(
		if selection.count == 1 do
		(
			sel = #()
			modPanel.addModToSelection (XForm ()) ui:on
			m = -((getModContextBBoxMin $ $.xform) - (getModContextBBoxMax $ $.xform))
			b = m * $.xform.gizmo.scale
			widthSpinner.enabled = true
			lengthSpinner.enabled = true
			hieghtSpinner.enabled = true
			widthSpinner.value = b[1]
			lengthSpinner.value = b[2]
			hieghtSpinner.value = b[3]
		)		
		if selection.count > 1 do
		(
			sel = $ as array
			modPanel.addModToSelection (XForm ()) ui:on
			select sel[1]
			m = -((getModContextBBoxMin $ $.xform) - (getModContextBBoxMax $ $.xform))
			b = m * $.xform.gizmo.scale
			widthSpinner.enabled = true
			lengthSpinner.enabled = true
			hieghtSpinner.enabled = true
			widthSpinner.value = b[1]
			lengthSpinner.value = b[2]
			hieghtSpinner.value = b[3]
		)
	)
	on widthSpinner changed value do
	(
		wm = -((getModContextBBoxMin $ $.xform) - (getModContextBBoxMax $ $.xform))

		wc = widthSpinner.value / wm[1]
		$.xform.gizmo.scale.x = wc
	)
	on lengthSpinner changed value do
	(
		lm = -((getModContextBBoxMin $ $.xform) - (getModContextBBoxMax $ $.xform))
		lc = lengthSpinner.value / lm[2]
		$.xform.gizmo.scale.y = lc
	)
	on hieghtSpinner changed value do
	(
		htm = -((getModContextBBoxMin $ $.xform) - (getModContextBBoxMax $ $.xform))
		htc = hieghtSpinner.value / htm[3]
		$.xform.gizmo.scale.z = htc
	)
	on CStackButton pressed do
	(
		if widthSpinner.enabled == true do
		(
			if sel.count > 0 do
			(
				select sel
				s = $
				converttopoly s
			)
			if sel.count == 0 do
			(
				s = $
				converttopoly s
			)
			widthSpinner.enabled = false
			lengthSpinner.enabled = false
			hieghtSpinner.enabled = false
		)
	)
	on removeButton pressed do
	(
		if widthSpinner.enabled == true do
		(
			if sel.count > 0 do
			(
				for i in sel do
				(
					select i
					s = $
					deleteModifier s s.XForm
				)
				select sel
			)
			if sel.count == 0 do
			(
				s = $
				deleteModifier s s.XForm
			)
			widthSpinner.enabled = false
			lengthSpinner.enabled = false
			hieghtSpinner.enabled = false
		)
	)
)
-- ACDimensionFloater = NewRolloutFloater "Object Dimensions" 190 200 140 210
-- ACDimensionFloater = NewRolloutFloater "Object Dimensions"
-- addRollout ACDimensionRollout ACDimensionFloater	
createDialog ACDimensionRollout width:170 height:170 pos:[140,210] bgcolor:(color 84 101 120) fgcolor:(color 248 113 45) 
)