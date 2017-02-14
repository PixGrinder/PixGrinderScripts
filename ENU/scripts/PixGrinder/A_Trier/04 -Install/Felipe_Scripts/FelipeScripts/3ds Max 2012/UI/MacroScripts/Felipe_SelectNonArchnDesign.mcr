-------------------------------------------------------------------------------
-- SelectNonArchnDesign
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2013/01/08
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript SelectNonArchnDesign
category:"Felipe Scripts"
toolTip:"Select Objects With Non Archn&Design Material"

(
	pda_array=#()
	for obj in geometry do (
		if classOf obj.material != Arch___Design__mi do	append pda_array obj
	)
	select pda_array
)