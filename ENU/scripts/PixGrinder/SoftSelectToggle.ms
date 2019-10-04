-- SoftSelection Enable -- 


	if classof selection[1] == Editable_Poly then
	(
		if  selection[1].useSoftSel == off then 
		(
			selection[1].ssEdgeDist = 50
			selection[1].ssUseEdgeDist = on
			selection[1].falloff = 0.50
			$.useSoftSel = on
			--macros.run "Editable Polygon Object" "EPoly_SoftSel_Toggle"
			update selection[1]
		) else (
			selection[1].useSoftSel = off
		)
	)




