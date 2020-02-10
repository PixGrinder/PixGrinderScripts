-- Search_by_name


(
	
	fn searchItem mySearch =
	(
-- 		mySearch = "strut" -- String to search
		pda = #()
		max select none
		for obj in objects do
		(
			if matchpattern obj.name pattern:("*"+mySearch+"*") == true do appendifunique pda obj
			
		)

		select pda
	)




	rollout myRollout "Search by Name"
	(
		edittext myText "" pos:[20,50]
		button myClr "Clear" across:2 pos:[50,100]
		button myBtn "Search" pos:[200,100]
		
		on myBtn pressed do searchItem myText.text 
		on myClr pressed do 
		(
			myText.text = ""
			max select none
		)
		
	)
	
	createDialog myRollout width:300 height:150
	setFocus myRollout.myText
	
)