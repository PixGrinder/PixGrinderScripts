
-------------------------------------------------------------------------------
-- Felipe_Bitmap_Search.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2012 :  Install in : 3ds Max 2012\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2014/12/02
-- v6
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------



(	
	pda = getclassinstances bitmaptexture
	pda2 = #()
	pda3 = #()
	
	try (destroyDialog searchBmp) catch ()
	
	
	for i = 1 to pda.count do 
	(
		if pda[i].bitmap != undefined do appendifunique pda3 pda[i]
	)
	
	rollout searchBmp "Search bitmap in scene materials" 
	(
		edittext bmpname "Search for this Bitmap in scene materials:" fieldWidth:200 labelOnTop:true
		button searchbtn "Search !" toolTip:"Search !" border:true
		on searchbtn pressed do
		(
			macros.run "Medit Tools" "clear_medit_slots"
			--bmpsearch (bmpname.text)
			--testy (bmpname.text)
			for i = 1 to pda3.count do
			(
				if findstring pda3[i].bitmap.filename bmpname.text != undefined do appendifunique pda2 pda3[i]
			)
			
			for i = 1 to pda2.count do
			(
				if i == 24 then return "end" else
				(
					meditmaterials[i] = pda2[i]
				)
			)
			DestroyDialog searchBmp
		)	
	)

	createDialog searchBmp 300 100

)



