-------------------------------------------------------------------------------
-- Felipe_VA_A350_Cacher_Items_a_etat.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( dassonphil@gmail.com )
-- 2014/08/28
-- V 1.0
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript VA_Hide_States
category:"Felipe Scripts"
toolTip:"VA Cacher Items a Etats"
buttonText:"VA Hide States"
icon:#("Felipe Scripts",5)
silentErrors:true
autoUndoEnabled:false

(
	max select none
	pda_etat = #()
	for obj in objects do
	(
		if findstring obj.name "*1" != undefined then append pda_etat obj
		if findstring obj.name "*2" != undefined then append pda_etat obj
		if findstring obj.name "*3" != undefined then append pda_etat obj
		if findstring obj.name "*4" != undefined then append pda_etat obj
		if findstring obj.name "*5" != undefined then append pda_etat obj
		if findstring obj.name "*6" != undefined then append pda_etat obj
		if findstring obj.name "*7" != undefined then append pda_etat obj
		if findstring obj.name "*8" != undefined then append pda_etat obj
		if findstring obj.name "*9" != undefined then append pda_etat obj
		if findstring obj.name "*10" != undefined then append pda_etat obj
		if findstring obj.name "_hole" != undefined then append pda_etat obj
		if findstring obj.name "_opened" != undefined then append pda_etat obj
	)
	select pda_etat
)