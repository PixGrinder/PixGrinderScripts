-------------------------------------------------------------------------------
-- Felipe_UV_Box.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2012/10/03
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Real_TurnToPoly
category:"Felipe Scripts"
toolTip:"Real Turn to Poly Modifier"
buttonText:"Real Turn to Poly"
-- icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true





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

