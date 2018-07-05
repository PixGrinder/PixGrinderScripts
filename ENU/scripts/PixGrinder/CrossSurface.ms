-------------------------------------------------------------------------------
-- Felipe_CrossSurface.ms
-- MacroScripts File
-- By Philippe DASSONVILLE ( dassonphil@gmail.com)
-- 2018/07/05
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
/*
macroScript CrossSurface
category:"Felipe Scripts"
toolTip:"CrossSurface"
*/


(
	if classof selection[1] == SplineShape or classof selection[1] == line then
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
