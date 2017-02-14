macroScript SelectEmptyObject category:"- Gueshni -" Icon:#("g9_selectemptyobject", 1) tooltip:"Select Empty Object"

-- Selectionner tous les objets de la scène et cliquer sur le script: Seuls les objets vides restent sélectionnés. --

 (
	TRY (
	tab_a_effacer = #()
	a_effacer = 0
	for obj in selection do if (superclassof obj == geometryclass) and	(polyop.getnumfaces obj < 1) then tab_a_effacer[a_effacer+=1]=obj
	clearselection()
	for obj in tab_a_effacer do	selectmore obj
	)
catch()
)