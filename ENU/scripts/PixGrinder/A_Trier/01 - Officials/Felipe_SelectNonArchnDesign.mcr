-------------------------------------------------------------------------------
-- SelectNonArchnDesign
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2013/01/08
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript SelectNonArchnDesign
category:"Felipe Scripts"
toolTip:"Select Objects With Non Archn&Design Material"
buttonText:"MR-A&D Select Inv"
--icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true

(
	pda_array=#()
	for obj in geometry do (
		if classOf obj.material != Arch___Design__mi do	append pda_array obj
	)
	select pda_array
)