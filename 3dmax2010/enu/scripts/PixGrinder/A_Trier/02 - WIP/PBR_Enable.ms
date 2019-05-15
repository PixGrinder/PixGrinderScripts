-- PBR_Enable --

	DxData = getClassInstances DirectX_9_Shader

	for mtl in DxData do
	(
		if mtl.TEX_color_map == undefined then mtl.use_color_map = 0.0 else mtl.use_color_map = 1.0
		if mtl.TEX_metallic_map == undefined then mtl.use_metallic_map = 0.0 else mtl.use_metallic_map = 1.0
		if mtl.TEX_normal_map == undefined then mtl.use_normal_map = 0.0 else mtl.use_normal_map = 1.0
		if mtl.TEX_roughness_map == undefined then mtl.use_roughness_map = 0.0 else mtl.use_roughness_map = 1.0
		if mtl.TEX_ao_map == undefined then mtl.use_ao_map = 0.0 else mtl.use_ao_map = 1.0
	)