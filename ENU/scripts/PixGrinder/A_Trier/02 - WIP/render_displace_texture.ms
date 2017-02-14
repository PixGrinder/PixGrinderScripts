(
	pda_rendersize = 256


	x1 = plane length:1024 width:1024 lengthsegs:500 widthsegs:500 name:"temp"
	c1 = Freecamera position:[0,0,10] fov:145.253 orthoProjection:true fovtype:3 targetDistance:160 nearclip:1 farclip:1000 nearrange:0 farrange:1000 mpassEnabled:off mpassRenderPerPass:off pos:[0,0,10] isSelected:on
	l1 = Omnilight rgb:(color 255 255 255) shadowColor:(color 0 0 0) multiplier:1 position:[1024,0,1024]
	l1.pivot = [0,0,1024]

	--c1.position.z = 10
	render
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
	x1.modifiers[1].map.filename = "C:\Users\Public\Pictures\Sample Pictures\Chrysanthemum_bump.jpg"
	x1.modifiers[1].strength = 100
	x1.modifiers[1].useMap = on
	x1.modifiers[1].blur = 0.1
		
	viewport.activeViewport = 2
	viewport.SetRenderLevel #smoothhighlights
	viewport.setCamera c1
	max safeframe toggle
	select c1
		
select l1
		
	
	-- meditmaterials[1].diffusemap.bitmap

	-- $.material = undefined
	
	
	
	pda_right = render camera:c1 vfb:false outputSize:[pda_rendersize, pda_rendersize]
	rotate l1 (eulerangles 0 0 -90)
	pda_below = render camera:c1 vfb:false outputSize:[pda_rendersize, pda_rendersize]
	rotate l1 (eulerangles 0 0 -90)
	pda_left = render camera:c1 vfb:false outputSize:[pda_rendersize, pda_rendersize]
	rotate l1 (eulerangles 0 0 -90)
	pda_above = render camera:c1 vfb:false outputSize:[pda_rendersize, pda_rendersize]
	rotate l1 (eulerangles 0 0 -90)
	b5 = bitmap pda_rendersize pda_rendersize color:white
	
		fn compfn c1 p1 c2 p2 = 
	(
		--res = (c1*0.5 + c2*0.5)
		res = c2
		res.g = c1.g
		res.b = 0
		res
	)
	

	pastebitmap pda_above pda_left [0,0] [0,0] type:#function function:compfn
	
	display pda_left
	
--x1 = gw.getViewportDib()
)