-------------------------------------------------------------------------------
-- Hair_Basic.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2015/11/29
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Hair_Basic
category:"Felipe Scripts"
toolTip:"Hair Basic"
buttonText:"Hair Basic"
--icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true


(
	modPanel.addModToSelection (HairMod ()) ui:on 
	$.modifiers[#Hair_and_Fur].MaterialRootColor = color 10 10 0
	$.modifiers[#Hair_and_Fur].MaterialSpecular = 10
	$.modifiers[#Hair_and_Fur].HairCount = 5000
	$.modifiers[#Hair_and_Fur].HairSegments = 20
	$.modifiers[#Hair_and_Fur].HairRootThickness = 6
	$.modifiers[#Hair_and_Fur].HairTipThickness = 3
	$.modifiers[#Hair_and_Fur].MultiStrandCount = 3
	$.modifiers[#Hair_and_Fur].MultiStrandRootSplay = 1
	$.modifiers[#Hair_and_Fur].MultiStrandTipSplay = 0.1
	$.modifiers[#Hair_and_Fur].DisplayHairPercent = 10
)
