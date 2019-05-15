-- Assets_Finder --

(
	
	fn searchBitmapTex mySearch =
	(
		x1 = getClassInstances Bitmaptexture
		
		for obj in x1 do
		(
			if matchpattern obj.name pattern:(mySearch+"*") == true do meditmaterials[1] = obj
		)
	)
	
	
	fn searchObject mySearch =
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
	
	
	
	rollout myRollout "Find Bitmap by name"
	(
		radiobuttons radBtn "test" labels:#("Texture File","BitmapTexture Name","object(s)") default:1 columns:2 align:#center
		edittext myText "" pos:[20,50]
		button myClr "Clear" across:2 pos:[50,100]
		button myBtn "Search" pos:[200,100]
		
		
		on myBtn pressed do 
		(
			if radBtn.state == 3 do searchObject myText.text 
			if radBtn.state == 2 do searchBitmapTex myText.text 
			
		)
		on myClr pressed do 
		(
			myText.text = ""
			max select none
		)
		
	)
	
	createDialog myRollout width:300 height:150
	
	
)


-- radiobuttons <name> [ <caption> ] labels:<array_of_strings> [default:<number>] [columns:<number>]
-- #("Youpi","Youlpa")