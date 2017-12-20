-------------------------------------------------------------------------------
-- Felipe_CrossSurface.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( ph_dassonville@yahoo.fr)
-- 2013/12/17
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
/*
macroScript CrossSurface
category:"Felipe Scripts"
toolTip:"CrossSurface"
*/


(
	if classof selection[1] == SplineShape then
	( 
		addModifier selection[1] (CrossSection () ) 
		addModifier selection[1] (Surface () ) 
		selection[1].modifiers[#Surface].threshold  = 0
		selection[1].modifiers[#Surface].steps  = 0
		addModifier selection[1] (SmoothModifier() ) 
		addModifier selection[1] (Cap_Holes() ) 
		addModifier selection[1] (Edit_Poly() ) 
		selection[1].material = undefined
		Include "$userScripts/PixGrinder/WireColorChanger_v2.ms"
		collapseStack selection[1]
	) else (messageBox("Only Works on splines"))
	-- maxOps.CollapseNode $ true
)
