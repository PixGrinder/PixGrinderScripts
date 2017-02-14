macroScript Macro1
	category:"DragAndDrop"
	toolTip:""
(
	(
		for obj in selection do (
			if superclassof obj == GeometryClass do (
				addModifier obj (Turn_To_Poly())
				obj.Turn_To_Poly.requirePlanar=true
				addModifier obj (Turn_To_Poly())
				addModifier obj (Smooth())
				obj.modifiers[#Smooth].autosmooth = on
			)
		)
	)
)
