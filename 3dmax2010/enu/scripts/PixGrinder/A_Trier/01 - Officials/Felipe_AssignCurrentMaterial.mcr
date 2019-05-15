-------------------------------------------------------------------------------
-- Felipe_AssignCurrentMaterial.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2013/06/18
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript AssignCurrentMaterial
category:"Felipe Scripts"
toolTip:"AssignCurrentMaterial"
buttonText:"Assign Current Mat"
--icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true

(
$.material = meditMaterials[activeMeditSlot]

)