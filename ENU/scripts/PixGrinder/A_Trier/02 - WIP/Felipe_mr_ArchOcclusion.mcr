-------------------------------------------------------------------------------
-- mrArchOcclusion
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2013/01/08
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

-- En Cours --
-- $.material.diff_color_map.falloff


macroScript mrArchOcclusion
category:"Felipe Scripts"
toolTip:"Control Arch&Design Material"

(
	pda_hasmr=#()
	for obj in geometry do (
		if classOf obj.material == Arch___Design__mi do	append pda_hasmr obj
	)
	select pda_array
)

--for obj in geometry do (
--	if obj.material.diffuseMap != undefined do (
--		pda01 = obj.material.diffuseMap as array
--		classOf obj.material == Arch___Design__mi
--		obj.material.diff_color_map = pda01[1]
		--pda01 = #()
	--)
--)