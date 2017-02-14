macroScript ResetTransform category:"- Gueshni -" Icon:#("g9_resettransform", 1) tooltip:"Reset Spline/Mesh Transform"
 (
	 on execute do
	(
		if selection.count ==0 then
			messageBox "Sélection vide"
		else
		(
			currentSel = selection as array
			for obj in currentSel do
			(
				if superclassof obj == GeometryClass then
				(
					convertToPoly obj
					obj.SetSelection #Face #{}
					boxtmp = box name:obj.name position:obj.pos height:1
					convertToPoly boxtmp
					tmp_layer = layermanager.getLayerFromName (obj.layer.name)
					tmp_layer.addNode boxtmp
					boxtmp.wirecolor = obj.wirecolor
					boxtmp.SetSelection #Face #{1..6}
					boxtmp.attach obj boxtmp
					boxtmp.delete #Face
					convertToMesh boxtmp
					convertToPoly boxtmp
				)
				else if superclassof obj == shape then
					(
						splinetmp = line name:obj.name position:obj.pos 
						convertToSplineShape splinetmp
						convertToSplineShape obj
						addAndWeld splinetmp obj -1
					)
			)
		)
	)
)