(
	pda01 = getCurrentSelection()

	
	
	if pda01.count < 1 then messagebox "Please select at least one object" else (
		pda_mymap = bitmap
		if maxfilename == "" then messagebox "Your scene must be saved !" else (
			pda_mypath = maxfilepath+(replace maxfilename (maxfilename.count-3) 4 "")+"_preset.rps"
			pda_mysave = meditmaterials[1]

			pda_lights = lights as array
			pda_lt_on = #()
			pda_path = ""
			select pda01
			pda_ratio = (distance objects.min objects.max)/(distance $.max $.min)
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
			meditMaterials[1].diffusemap.max_distance = pda_ratio
			meditMaterials[1].diffusemap.samples = 256

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
			
			renderpresets.LoadAll 0 pda_mypath
			
			deletefile pda_mypath
		
		)
	)

)


-----------------------------






