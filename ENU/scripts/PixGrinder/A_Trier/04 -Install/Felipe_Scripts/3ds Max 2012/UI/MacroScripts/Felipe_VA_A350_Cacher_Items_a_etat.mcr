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
	for obj in objects do
	(
		if findstring obj.name "*1" != undefined then obj.ishidden = true
		if findstring obj.name "*2" != undefined then obj.ishidden = true
		if findstring obj.name "*3" != undefined then obj.ishidden = true
		if findstring obj.name "*4" != undefined then obj.ishidden = true
		if findstring obj.name "*5" != undefined then obj.ishidden = true
		if findstring obj.name "*6" != undefined then obj.ishidden = true
		if findstring obj.name "*7" != undefined then obj.ishidden = true
		if findstring obj.name "*8" != undefined then obj.ishidden = true
		if findstring obj.name "*9" != undefined then obj.ishidden = true
		if findstring obj.name "*10" != undefined then obj.ishidden = true
	)
)