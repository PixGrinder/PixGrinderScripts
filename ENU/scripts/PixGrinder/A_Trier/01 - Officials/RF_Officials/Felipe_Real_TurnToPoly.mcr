-------------------------------------------------------------------------------
-- Felipe_Real_TurnToPoly.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2013/03/14
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Real_TurnToPoly
category:"Felipe Scripts"
toolTip:"Real Turn to Poly Modifier"


(
addModifier $ (Turn_To_Poly())
$.Turn_To_Poly.requirePlanar=true
addModifier $ (Turn_To_Poly())
addModifier $ (Smooth())
$.modifiers[#Smooth].autosmooth = on
)


	
	
