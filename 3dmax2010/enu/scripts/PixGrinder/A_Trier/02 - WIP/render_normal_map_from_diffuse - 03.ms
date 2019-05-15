(
	
	-- backup current max file
	--------------------------------
	fname = MaxFilePath + MaxFileName
	fnm = replace fname (fname.count-3) 4 "_original.max"
	saveMaxFile fnm
	
	-- variables
	--------------
	
	pda_rendersize = 256 -- size of the normal-map bitmap
	my_mult = 0.5 -- multiplier amount of lights used to generate normal maps


	-- hide layers
	---------------
	
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

	
	
	
	x1 = plane length:1024 width:1024 lengthsegs:500 widthsegs:500 name:"temp"
	c1 = Freecamera position:[0,0,10] fov:145.253 orthoProjection:true fovtype:3 targetDistance:160 nearclip:1 farclip:1000 nearrange:0 farrange:1000 mpassEnabled:off mpassRenderPerPass:off pos:[0,0,10] isSelected:on
	l1 = Omnilight rgb:(color 242 128 185) shadowColor:(color 0 0 0) multiplier:my_mult position:[1024,0,1024]
	l2 = Omnilight rgb:(color 127 013 185) shadowColor:(color 0 0 0) multiplier:my_mult position:[0,-1024,1024]
	l3 = Omnilight rgb:(color 013 128 185) shadowColor:(color 0 0 0) multiplier:my_mult position:[-1024,0,1024]
	l4 = Omnilight rgb:(color 128 242 185) shadowColor:(color 0 0 0) multiplier:my_mult position:[0,1024,1024]
	

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
	x2 = x1.max.z
	x1.position.z = -x2
	
	-- x1.modifiers[1].map.filename = "C:\Users\Public\Pictures\Sample Pictures\Chrysanthemum_bump.jpg"
	
	
		
	viewport.activeViewport = 2
	viewport.SetRenderLevel #smoothhighlights
	viewport.setCamera c1
	max safeframe toggle
	select c1
		
	select l1
		
	pda_r01 = render camera:c1 vfb:false outputSize:[pda_rendersize, pda_rendersize]

	-- display pda_r01
	
)



