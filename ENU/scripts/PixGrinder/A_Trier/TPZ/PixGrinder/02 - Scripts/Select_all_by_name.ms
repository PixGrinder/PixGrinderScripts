(
	rollout find "Select objects by name" 
	(
		label myLab "Search by name" align:#center
		edittext mySearch text:"Search object name" fieldWidth:200 align:#center
		button myOK "Search !" width:100 align:#center
		
		on myOK pressed do 
		(
			pda=#()
			for obj in objects do
			(
				if findstring obj.name mySearch.text != undefined do append pda obj
			)
			
			select pda
		)
		
	)

	createDialog find height:100 width:300
	
)