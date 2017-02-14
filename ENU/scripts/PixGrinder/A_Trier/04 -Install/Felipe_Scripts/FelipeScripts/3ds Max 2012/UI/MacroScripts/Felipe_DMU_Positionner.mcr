-------------------------------------------------------------------------------
-- Felipe_DMU_Positionner.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2012/09/06
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript DMU_positionner
category:"Felipe Scripts"
toolTip:"DMU : Transform Selection from World Origin"
(
	dmu = selection as array
	Dummy name:"dummy_a_virer" pos:[0,0,0] isSelected:on 
	$.boxsize=[1,1,1]
	dmu.parent = $dummy_a_virer
	select $dummy_a_virer
	max scale
	max tti
)
