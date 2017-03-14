
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Assets Finder --
-- Finds things in 3dsmax scene (objects/textures/materials/...) --
-- V 4.0 --

---------------------------------------------------------------------


(
	clearListener()
	
	fn searchBitmapTex mySearch =
	(
		x1 = getClassInstances Bitmaptexture
		
		for obj in x1 do
		(
			if matchpattern obj.name pattern:("*"+mySearch+"*") == true do meditmaterials[1] = obj
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
	
	
	fn searchFile mySearch =
	(
		pda = getclassinstances bitmaptexture
		pda3 = for obj in pda where obj.bitmap != undefined collect obj
		macros.run "Medit Tools" "clear_medit_slots"
		pda2 = for obj in pda3 where findstring obj.bitmap.filename mySearch != undefined collect obj
		for i = 1 to pda2.count do
		(
			if i == 24 then return "end" else
			(
				meditmaterials[i] = pda2[i]
			)
		)
		
	)
	
	
	
	rollout myRollout "Find Bitmap by name"
	(
		radiobuttons radBtn "Asset to search : " labels:#("Filename","BitmapTexture Name","Object(s)") default:3 columns:2 align:#center
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
			if radBtn.state == 1 do 
			(
				searchFile myText.text 
				MatEditor.Open()
			)
			--if radBtn.state == 2 do searchFile myText.text 
			setFocus myRollout.myText
		)
		
		
		on myText entered txTemp do
		(
			if radBtn.state == 3 do searchObject myText.text 
			if radBtn.state == 2 do 
			(
				searchBitmapTex txTemp
				MatEditor.Open()
			)
			if radBtn.state == 1 do 
			(
				searchFile txTemp
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


