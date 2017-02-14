(

	
		-- backup current max file
	--------------------------------
	global fname = MaxFilePath + MaxFileName
	global fnm = replace fname (fname.count-3) 4 "_original.max"
	saveMaxFile fnm
	
	
	-- Variables and arrays : 
	-----------------------------

	global pda_ar = #()
	global pda_std = #()
	global pda_mentalray= #()
	global pda_vray = #()
	global pda_other = #()

	global pda_error = #()

	global pda_name = ""
	
	global pda_rendersize = 256 -- size of the normal-map bitmap
	global my_mult = 0.5 -- multiplier amount of lights used to generate normal maps
	global bmp_amount = 30
	global my_var = 0
	
	
		global x1 = plane length:1024 width:1024 lengthsegs:500 widthsegs:500 name:"temp"
		global c1 = Freecamera position:[0,0,10] fov:145.253 orthoProjection:true fovtype:3 targetDistance:160 nearclip:1 farclip:1000 nearrange:0 farrange:1000 mpassEnabled:off mpassRenderPerPass:off pos:[0,0,10] isSelected:on
		global l1 = Omnilight rgb:(color 242 128 185) shadowColor:(color 0 0 0) multiplier:my_mult position:[1024,0,1024]
		global l2 = Omnilight rgb:(color 127 013 185) shadowColor:(color 0 0 0) multiplier:my_mult position:[0,-1024,1024]
		global l3 = Omnilight rgb:(color 013 128 185) shadowColor:(color 0 0 0) multiplier:my_mult position:[-1024,0,1024]
		global l4 = Omnilight rgb:(color 128 242 185) shadowColor:(color 0 0 0) multiplier:my_mult position:[0,1024,1024]
	


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
		
		-- Display all Layers !
		-------------------------------
	fn showLayers =
	(
		local i = 1
		local lxi = 1
		for i = 0 to layermanager.count-1 do (
			lxi  = layermanager.getLayer i
			lxi.on = true
		)
	)
	
	 -- manager layer for normal map generation
	-----------------------------------------------------
	fn normal_layer =
	(
		max select none
		for i = 1 to (layermanager.count-1) do 
		(
			xa = layermanager.getlayer i
			xa.on = false
		)
		
		nm_layer = layermanager.newLayerFromName "normal_gen"
		nm_layer.current = true
	)
	
		-- collect all single materials
		-----------------------------------
	fn MatCollect =
	(

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
	)

	
	-- generate rendering template for nomal bump
	-----------------------------------------------------
	fn nmap_template =
	(
-- 		global x1 = plane length:1024 width:1024 lengthsegs:500 widthsegs:500 name:"temp"
-- 		global c1 = Freecamera position:[0,0,10] fov:145.253 orthoProjection:true fovtype:3 targetDistance:160 nearclip:1 farclip:1000 nearrange:0 farrange:1000 mpassEnabled:off mpassRenderPerPass:off pos:[0,0,10] isSelected:on
-- 		global l1 = Omnilight rgb:(color 242 128 185) shadowColor:(color 0 0 0) multiplier:my_mult position:[1024,0,1024]
-- 		global l2 = Omnilight rgb:(color 127 013 185) shadowColor:(color 0 0 0) multiplier:my_mult position:[0,-1024,1024]
-- 		global l3 = Omnilight rgb:(color 013 128 185) shadowColor:(color 0 0 0) multiplier:my_mult position:[-1024,0,1024]
-- 		global l4 = Omnilight rgb:(color 128 242 185) shadowColor:(color 0 0 0) multiplier:my_mult position:[0,1024,1024]
		
		select x1
		max modify mode
		addModifier x1 (Displace())
		
		x1.material = Standardmaterial()
		x1.material.diffuse = white
		x1.material.name = "my funny material"
		x1.material.specularLevel = 20
		x1.material.glossiness = 50
		
		x1.modifiers[1].map = Bitmaptexture()
		x1.modifiers[1].map.name = "Displace Bitmap"
		x1.modifiers[1].strength = 100
		x1.modifiers[1].useMap = on
		x1.modifiers[1].blur = 0.1

		
		viewport.activeViewport = 2
		viewport.SetRenderLevel #smoothhighlights
		viewport.setCamera c1
		max safeframe toggle
		select c1
		myvar = 1
	)
	
	
	fn stdbump =
	(
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
					x1.modifiers[1].map.filename = pda_name
					x2 = x1.max.z
					x1.position.z = -x2
					
					
					pda_std[i].bumpmap = Normal_Bump ()
					pda_std[i].bumpmap.name = pda_std[i].name+" - bump"
					pda_std[i].bumpmap.normal_map = Bitmaptexture()
					pda_std[i].bumpmap.normal_map.name = pda_std[i].name+" - normal_bump"
					
					pda_name= pda_map.filename
					pda_name = replace pda_name (pda_name.count-3) 4 "_normal.jpg"
					pda_r01 = render camera:c1 vfb:false outputSize:[pda_rendersize, pda_rendersize] outputfile:pda_name
					
					pda_std[i].bumpmap.normal_map.bitmap = pda_r01
					pda_std[i].bumpMapAmount = bmp_amount
					if pda_std[i].specularLevel == 0 and pda_std[i].glossiness == 10 do 
					(
						pda_std[i].specularLevel = 50
						pda_std[i].glossiness = 20
					)
					x1.modifiers[1].map.filename = pda_name
				)
			)
		)
	)

	-------------------------------------------------------------------------------------------------------
	
	
	fn mraybump = 
	(
		-- Generate bump for Arch n Design materials 
		----------------------------------------------------
		for i = 1 to pda_mentalray.count do 
		(
			if (classof pda_mentalray[i].mapM0 == Bitmaptexture and pda_mentalray[i].mapM0.bitmap != undefined ) do
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
			
			if (classof pda_mentalray[i].mapM0 == Ambient_Reflective_Occlusion__3dsmax and classof pda_mentalray[i].mapM0.bright_shader == Bitmaptexture and pda_mentalray[i].mapM0.bright_shader.bitmap != undefined) do
			(
				print "ok 1 "
				if pda_mentalray[i].bump_map == undefined or (classof pda_mentalray[i].bump_map == Bitmaptexture and pda_mentalray[i].bump_map.bitmap == undefined) do
				(
					print "OK 2 "
					pda_map = pda_mentalray[i].mapM0.bright_shader.bitmap
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
	)
	
	fn vraybump = 
	(
		-- Generate bump for Arch n Design materials 
		----------------------------------------------------
		for i = 1 to pda_vray.count do 
		(
			if (classof pda_vray[i].diffusemap == Bitmaptexture and pda_vray[i].diffusemap.bitmap != undefined ) do
			(
				if pda_vray[i].texmap_bump == undefined or (classof pda_vray[i].texmap_bump == Bitmaptexture and pda_vray[i].texmap_bump.bitmap == undefined) do
				(
					pda_map = pda_vray[i].diffusemap.bitmap
					b1 = bitmap pda_map.width pda_map.height color:white
					b2 = bitmap pda_map.width pda_map.height color:white
					b1 = pda_map
					pastebitmap b1 b2 [0,0] [0,0] type:#function function:compfn
					pda_name= pda_map.filename
					pda_name = replace pda_name (pda_name.count-3) 4 "_bump.jpg"
					b2.filename = pda_name
					save b2
					pda_vray[i].texmap_bump = Bitmaptexture()
					pda_vray[i].texmap_bump.name = pda_vray[i].name+" - bump"
					pda_vray[i].texmap_bump.bitmap = b2
					pda_vray[i].texmap_bump_amt = ( bmp_amount/100 )
					if pda_vray[i].refl_weight == 0.6 and pda_vray[i].refl_gloss == 1 do 
					(
						pda_vray[i].refl_weight = 1
						pda_vray[i].refl_gloss = .35
						pda_vray[i].refl_interp = true
						pda_vray[i].refl_hlonly = true
					)
				)
			)
			
			if (classof pda_vray[i].diffusemap == Ambient_Reflective_Occlusion__3dsmax and classof pda_vray[i].diffusemap.bright_shader == Bitmaptexture and pda_vray[i].diffusemap.bright_shader.bitmap != undefined) do
			(
				print "ok 1 "
				if pda_vray[i].texmap_bump == undefined or (classof pda_vray[i].texmap_bump == Bitmaptexture and pda_vray[i].texmap_bump.bitmap == undefined) do
				(
					print "OK 2 "
					pda_map = pda_vray[i].diffusemap.bright_shader.bitmap
					b1 = bitmap pda_map.width pda_map.height color:white
					b2 = bitmap pda_map.width pda_map.height color:white
					b1 = pda_map
					pastebitmap b1 b2 [0,0] [0,0] type:#function function:compfn
					pda_name= pda_map.filename
					pda_name = replace pda_name (pda_name.count-3) 4 "_bump.jpg"
					b2.filename = pda_name
					save b2
					pda_vray[i].texmap_bump = Bitmaptexture()
					pda_vray[i].texmap_bump.name = pda_vray[i].name+" - bump"
					pda_vray[i].texmap_bump.bitmap = b2
					pda_vray[i].texmap_bump_amt = ( bmp_amount/100 )
					if pda_vray[i].refl_weight == 0.6 and pda_vray[i].refl_gloss == 1 do 
					(
						pda_vray[i].refl_weight = 1
						pda_vray[i].refl_gloss = .35
						pda_vray[i].refl_interp = true
						pda_vray[i].refl_hlonly = true
					)
				)
			)
		)
	)
	
	
	

	-- select object with multimaterial containing multimaterial !! (WTF !! )
	--------------------------------------------------------------------------------



	
		-- Inteface
	------------------
	
	rollout bpconfig "Bump configuration"
	(
		spinner bumper "Bump Amount" pos:[35,15] type:#float width:100 height:20 range:[-999,999,30] --controller:$cam_SharpZone.fov.controller 
		button btn "OK" width:75
		
		
		on btn pressed do
		(
			bmp_amount = bumper.value
			MatCollect()
-- 			if myvar == 0 do 
-- 			(
-- 				nmap_template()
-- 				myvar = 1
-- 			)
			stdbump()
			--pda_r01 = render camera:c1 vfb:false outputSize:[pda_rendersize, pda_rendersize]
			--mraybump()
			
			if pda_error.count !=0 do
			(
				messagebox "Objects containing recursive multimaterials are now selected"
				max select none
				select pda_error
			)
			
			destroyDialog bpconfig
			delete #(x1, c1, l1, l2, l3, l4)
			
			
			
		)
		
	)
	
-- 	(

-- 		
-- 		select x1
-- 		max modify mode
-- 		addModifier x1 (Displace())
-- 		
-- 		x1.material = Standardmaterial()
-- 		x1.material.diffuse = white
-- 		x1.material.name = "my funny material"
-- 		x1.material.specularLevel = 20
-- 		x1.material.glossiness = 50
-- 		
-- 		x1.modifiers[1].map = Bitmaptexture()
-- 		x1.modifiers[1].map.name = "Displace Bitmap"
-- 		x1.modifiers[1].strength = 100
-- 		x1.modifiers[1].useMap = on
-- 		x1.modifiers[1].blur = 0.1

-- 		
-- 		viewport.activeViewport = 2
-- 		viewport.SetRenderLevel #smoothhighlights
-- 		viewport.setCamera c1
-- 		max safeframe toggle
-- 		select c1
-- 		myvar = 1
-- 	)
	
	nmap_template()
	
	createDialog bpconfig width:150 height:75 bgcolor:white
	
	-- select none !
	-------------------------------


)




