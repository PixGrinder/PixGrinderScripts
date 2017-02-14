-- find material id


(
	global mySel = getcurrentselection()
	myVar = 2
	mySel = mySel[1]
	rollout find "Find Mat ID by bitmap name" 
	(
		label myLab "Search materials id containing this bitmap name :" align:#center
		edittext mySearch text:"Name" fieldWidth:200 align:#center
		button myOK "Search !" width:100 align:#center
		
		on myOK pressed do 
		(
			myVar = 2
			meditmaterials[1] = mySel.material
			for i = 1 to mySel.material.count do
			--for i = 1 to 89 do
			(
				if (mySel.material[i] != undefined) and (mySel.material[i].diffusemap) != undefined  and (mySel.material[i].diffusemap.filename != undefined) do
				(
					
					if findstring mySel.material[i].diffusemap.filename mySearch.text != undefined do 
					(
						print ((i as string) + " : " + (mySel.material[i].diffusemap.filename))
						meditmaterials[myVar] = mySel.material[i]
						if myVar <24 do myVar = myVar +1
					)
				)
			)
		)
	)

	createDialog find height:100 width:300
	
)






