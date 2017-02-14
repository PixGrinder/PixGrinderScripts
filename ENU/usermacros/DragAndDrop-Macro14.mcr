macroScript Macro14
	category:"DragAndDrop"
	toolTip:""
(
	(
		pda_num = numsplines $


		for i = 1 to pda_num do (
			



		pda1 = getKnotSelection $ i

		pda2= #()
		for j = 1 to pda1.count by 2 do append pda2 pda1[j]


		-- for i=1 to pda2.count do deleteKnot $ 1 pda2[i]


		setKnotSelection $ i pda2

		)

		max delete
	)
)
