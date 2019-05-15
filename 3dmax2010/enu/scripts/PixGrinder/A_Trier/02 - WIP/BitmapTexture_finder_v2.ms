-- BitmapTexture finder --

(
	
	fn searchItem mySearch =
	(
		x1 = getClassInstances Bitmaptexture
		
		for obj in x1 do
		(
			if matchpattern obj.name pattern:(mySearch+"*") == true do meditmaterials[1] = obj
		)
	)
	
	
	rollout myRollout "Find Bitmap by name"
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
	
	
)



