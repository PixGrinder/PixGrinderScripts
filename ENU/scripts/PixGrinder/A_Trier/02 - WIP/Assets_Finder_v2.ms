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
		radiobuttons radBtn "Asset to search : " labels:#("Texture File","BitmapTexture Name","Object(s)") default:3 columns:2 align:#center
		edittext myText "" pos:[20,75]
		button myClr "Clear" across:2 pos:[50,100]
		button myBtn "Search" pos:[200,100]
		
		
		on myBtn pressed do 
		(
			if radBtn.state == 3 do searchObject myText.text 
			if radBtn.state == 2 do 
			(
				searchBitmapTex myText.text 
				MatEditor.Open()
			)
			--if radBtn.state == 2 do searchFile myText.text 
			setFocus myRollout.myText
			
		)
		on myClr pressed do 
		(
			myText.text = ""
			max select none
			setFocus myRollout.myText
		)
		
	)
	
	createDialog myRollout width:300 height:150
	setFocus myRollout.myText
	
)


-- radiobuttons <name> [ <caption> ] labels:<array_of_strings> [default:<number>] [columns:<number>]
-- #("Youpi","Youlpa")