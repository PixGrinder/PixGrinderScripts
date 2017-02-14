-------------------------------------------------------------------------------
-- Felipe_CrossSurface.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( ph_dassonville@yahoo.fr)
-- 2013/12/17
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript CrossSurface
category:"Felipe Scripts"
toolTip:"CrossSurface"



(
	addModifier $ (CrossSection () ) 
	addModifier $ (Surface () ) 
	$.modifiers[#Surface].threshold  = 0
	$.modifiers[#Surface].steps  = 0
	addModifier $ (Edit_Poly() ) 
	-- maxOps.CollapseNode $ true
)
