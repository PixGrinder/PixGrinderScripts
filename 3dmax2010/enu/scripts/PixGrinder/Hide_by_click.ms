

---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Hide by Click --
-- Hide_by_click.ms --
-- Toggles "Hide by click" mode - Every hidden object is placed in a selection set - Right click to leave the "Hide by click" mode --
-- V 1.1 --

---------------------------------------------------------------------

(
	rollout pda_SelcSet_UI "Hide By Click"
	(
		label theTxt "SelectionSet Name :" align:#center offset:[0,15]
		edittext theBla "" text:"zz_Temp_zz" fieldWidth:250 align:#center offset:[0,5]
		button myBtn "Hide by Click !" align:#center offset:[0,5]

		on myBtn pressed do
		(		
			x=1
			pda1 = #()
			pda2 = #()

			if SelectionSets[theBla.text] == undefined then
			(
				SelectionSets[theBla.text] = #()
			) else
			(
				select SelectionSets[theBla.text]
				pda2 = getCurrentSelection()
				
			)
			
			clearSelection()
			
			while x != 100 do 
			(
				pda1 =  pickObject()
				if pda1 == undefined then exit
				append pda2 pda1
				SelectionSets[theBla.text] = pda2
				hide pda1
				x = x+1
			) 
		)
	)
	createDialog pda_SelcSet_UI 350 125 (gw.getWinSizeX()-350) 300
)