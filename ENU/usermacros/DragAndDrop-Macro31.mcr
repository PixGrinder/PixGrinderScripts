macroScript Macro31
	category:"DragAndDrop"
	toolTip:""
(
	-- OneShotOptim Smoothing
	(
			obj = selection[1]
			
			(
				-- welding
				max modify mode
				addModifier obj (ProOptimizer())
				obj.modifiers[obj.modifiers.count].MergePoints = true
				obj.modifiers[obj.modifiers.count].MergePointsThreshold = 0.1
				obj.modifiers[obj.modifiers.count].Calculate = true
				collapseStack obj
				convertToPoly obj
				-- // welding
			)
				
			(
			-- normals reset
			obj.pivot = obj.center
			resetXform obj
			addModifier obj (SmoothModifier ())
			obj.modifiers[1].smoothingBits = 1
			addModifier obj (SmoothModifier ())
			collapseStack obj
			-- // normals reset
			)
				
			(
			-- smoothing
			addModifier obj (SmoothModifier ())
			obj.modifiers[1].autoSmooth = true
			obj.modifiers[1].threshold = 45
			-- collapseStack obj
			-- // smoothing
			)
			
	)
)
