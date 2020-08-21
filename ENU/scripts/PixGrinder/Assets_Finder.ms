
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Assets Finder --
-- Finds things in 3dsmax scene (objects/textures/materials/...) --
-- V 4.2 --
-- Cameras excluded from search --

---------------------------------------------------------------------


clearListener()



try(DestroyDialog myRollout) catch()	
(	
	fn searchBitmapTex mySearch =
	(
		x1 = getClassInstances Bitmaptexture
		
		for obj in x1 do
		(
			if matchpattern obj.name pattern:("*"+mySearch+"*") == true do meditmaterials[1] = obj
		)
	)
	
	
	fn searchObject mySearch IsolState =
	(
-- 		mySearch = "strut" -- String to search
		pda = #()
		max select none
		for obj in objects where superclassof obj != camera and classof obj != Targetobject do -- modified in v4.2
		(
			if matchpattern obj.name pattern:("*"+mySearch+"*") == true do appendifunique pda obj
		)
		select pda
		-------------------
		if pda.count > 0 and IsolState == on then FileIn("$userScripts/PixGrinder/Focus_Selected.ms")
		--------------------

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
	
	fn pde_getMat theName=
	(
		theMats = getClassInstances StandardMaterial
		theResult = for obj in theMats where matchpattern obj.name pattern:("*"+theName+"*") == true and obj.diffusemap == undefined collect obj
		MatEditor.Open()
		for i = 1 to 24 do try (meditMaterials[i] = theResult[i]) catch()
	)
	
	rollout myRollout "Asset Finder"
	(
		radiobuttons radBtn "Asset to search : " labels:#("Map Filename","BitmapTexture Name","Object(s)","Color Material") default:3 columns:2 align:#center
		label lbl "------------------------" align:#center
		label lbl1 "Isolate object found : "align:#center
		radiobuttons ItemFocus "" labels:#("On","Off") default:2 align:#center
		button myUnhide "Revert Hide" align:#center
		edittext myText "" offset:[0,7]
		button myClr "Clear" across:3 offset:[0,7]
		button myPaste "Paste" offset:[0,7]
		button myBtn "Search" offset:[0,7]

	
		on myBtn pressed do
		(
			if radBtn.state == 4 do pde_getMat myText.text
			if radBtn.state == 3 then
			(
				myVis = (for obj in objects where obj.isHidden == false collect obj)
				if ItemFocus.state == 1 then searchObject myText.text True else searchObject myText.text False
			)
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
			if radBtn.state == 4 do pde_getMat myText.text
			if radBtn.state == 3 then
			(
				myVis = (for obj in objects where obj.isHidden == false collect obj)
				if ItemFocus.state == 1 then searchObject myText.text True else searchObject myText.text False
			)
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
			MatEditor.Close()
			for i = 1 to 24 do meditMaterials[i] = standardMaterial()
		)
		
		
		on myPaste pressed do 
		(
			myText.text = getclipboardText()
			if radBtn.state == 4 do pde_getMat myText.text
			if radBtn.state == 3 then
			(
				myVis = (for obj in objects where obj.isHidden == false collect obj)
				if ItemFocus.state == 1 then searchObject myText.text True else searchObject myText.text False
			)
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


		on myUnhide pressed do myVis.isHidden = off
		
		
	)

)

createDialog myRollout width:300 height:215
setFocus myRollout.myText
	



-- myVis = (for obj in objects where obj.isHidden == false collect obj)