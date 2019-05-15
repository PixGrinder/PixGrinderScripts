(


	-- Variables and arrays : 
	-----------------------------

	global pda_ar = #()
	global pda_std = #()
	global pda_mentalray= #()
	global pda_vray = #()
	global pda_other = #()

	global pda_error = #()

	global pda_name = ""
	
	
	global bmp_amount = 100


	-- function to generate bump map from diffuse map :
	-----------------------------------------------------------
	fn compfn c1 p1 c2 p2 = 
	(
		--res = (c1*0.5 + c2*0.5)
		res = c2
		res.r = (c1.r+c1.g+c1.b)/3
		res.g = res.r
		res.b = res.r
		res
	)



	-- select none !
	-------------------------------
	max select none


	-- Display all Layers !
	-------------------------------
	(
		local i = 1
		local lxi = 1
		for i = 0 to layermanager.count-1 do (
			lxi  = layermanager.getLayer i
			lxi.on = true
		)
	)


	-- collect all single materials
	-----------------------------------
	for obj in geometry do 
	(
		if classof obj.material == multimaterial then
		(
			for i = 1 to obj.material.count do 
			(
				if classof obj.material[i] != multimaterial then appendifunique pda_ar obj.material[i] else appendifunique pda_error obj
			)
		)
		else
		(
			appendifunique pda_ar obj.material
		)
	)
	--for i = 1 to pda_ar.count do print (classof pda_ar[i])



	-- collect materials by class
	---------------------------------
	for i = 1 to pda_ar.count do
	(
		if classof pda_ar[i] == standardmaterial do appendifunique pda_std pda_ar[i]
		if classof pda_ar[i] == Arch___Design__mi do appendifunique pda_mentalray pda_ar[i]
		if classof pda_ar[i] == VRayMtl do appendifunique pda_vray pda_ar[i]
	)


	-- Generate bump for standard materials 
	----------------------------------------------
	for i = 1 to pda_std.count do 
	(
		if (pda_std[i].diffusemap != undefined) or (classof pda_std[i].diffusemap == Bitmaptexture and pda_std[i].diffusemap.bitmap == undefined ) do
		(
			if pda_std[i].bumpmap == undefined or (classof pda_std[i].bumpmap == Bitmaptexture and pda_std[i].bumpmap.bitmap == undefined) do
			(
				pda_map = pda_std[i].diffusemap.bitmap
				b1 = bitmap pda_map.width pda_map.height color:white
				b2 = bitmap pda_map.width pda_map.height color:white
				b1 = pda_map
				pastebitmap b1 b2 [0,0] [0,0] type:#function function:compfn
				pda_name= pda_map.filename
				pda_name = replace pda_name (pda_name.count-3) 4 "_bump.jpg"
				b2.filename = pda_name
				save b2
				pda_std[i].bumpmap = Bitmaptexture()
				pda_std[i].bumpmap.name = pda_std[i].name+" - bump"
				pda_std[i].bumpmap.bitmap = b2
				pda_std[i].bumpMapAmount = bmp_amount
				if pda_std[i].specularLevel == 0 and pda_std[i].glossiness == 10 do 
				(
					pda_std[i].specularLevel = 50
					pda_std[i].glossiness = 20
				)
			)
		)
	)


	-- Generate bump for Arch n Design materials 
	----------------------------------------------------
	for i = 1 to pda_mentalray.count do 
	(
		if (pda_mentalray[i].mapM0 != undefined) or (classof pda_mentalray[i].mapM0 == Bitmaptexture and pda_mentalray[i].mapM0.bitmap == undefined ) or (classof pda_mentalray[i].mapM0 == Bitmaptexture and pda_mentalray[i].mapM0.bitmap == undefined ) do
		(
			if pda_mentalray[i].bump_map == undefined or (classof pda_mentalray[i].bump_map == Bitmaptexture and pda_mentalray[i].bump_map.bitmap == undefined) do
			(
				pda_map = pda_mentalray[i].mapM0.bitmap
				b1 = bitmap pda_map.width pda_map.height color:white
				b2 = bitmap pda_map.width pda_map.height color:white
				b1 = pda_map
				pastebitmap b1 b2 [0,0] [0,0] type:#function function:compfn
				pda_name= pda_map.filename
				pda_name = replace pda_name (pda_name.count-3) 4 "_bump.jpg"
				b2.filename = pda_name
				save b2
				pda_mentalray[i].bump_map = Bitmaptexture()
				pda_mentalray[i].bump_map.name = pda_mentalray[i].name+" - bump"
				pda_mentalray[i].bump_map.bitmap = b2
				pda_mentalray[i].bump_map_amt = ( bmp_amount/100 )
				if pda_mentalray[i].refl_weight == 0.6 and pda_mentalray[i].refl_gloss == 1 do 
				(
					pda_mentalray[i].refl_weight = 1
					pda_mentalray[i].refl_gloss = .35
					pda_mentalray[i].refl_interp = true
					pda_mentalray[i].refl_hlonly = true
				)
			)
		)
	)
	
	
	
	

	-- select object with multimaterial containing multimaterial !! (WTF !! )
	--------------------------------------------------------------------------------
	if pda_error.count !=0 do
	(
		messagebox "Objects containing recursive multimaterials are now selected"
		select pda_error
	)



)




