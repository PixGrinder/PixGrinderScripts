(
	global pda_mymap = bitmap
	global pda_mypath = maxfilepath+(replace maxfilename (maxfilename.count-3) 4 "")+"_preset.rps"
	global pda_mysave = meditmaterials[1]

	global pda_lights = lights as array
	global pda_lt_on = #()
	global pda_path = ""

	-- save lights on status + disable all lights
	for i = 1 to pda_lights.count do append pda_lt_on pda_lights[i].enabled
	pda_lt_on
	for i = 1 to pda_lights.count do pda_lights[i].enabled = false
	max views redraw

	renderpresets.SaveAll 0 pda_mypath

	renderers.current = mental_ray_renderer() 

	meditmaterials[1] = standardMaterial()
	meditmaterials[1].name = "Override_Mtl"
	meditMaterials[1].selfIllumAmount = 100
	meditMaterials[1].diffusemap = Ambient_Reflective_Occlusion__3dsmax ()

	renderers.current.Enable_Material_Override = true
	renderers.current.Override_Material = meditmaterials[1]
	renderers.current.Conserve_Memory = true
	renderers.current.FinalGatherEnable2 = false

	pda_path = selectSaveBitMap()

	render frame:#current outputSize:[1024,1024] outputfile:pda_path

	
	meditmaterials[2] = Bitmaptexture()
	meditmaterials[2].filename = pda_path


	------------------------------------------


	meditmaterials[1] = pda_mysave
	
	-- reset original lights status
	for j = 1 to pda_lights.count do pda_lights[j].enabled = pda_lt_on[j]


	deletefile pda_mypath
)


-----------------------------





