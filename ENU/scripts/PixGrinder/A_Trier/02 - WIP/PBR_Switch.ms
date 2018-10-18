-- PBR_Switch --


fn PBR_switch mtl =
(
	--mtl.useshaderfx = 2
	if mtl.use_normal_map == 0 then 
	(
		mtl.use_normal_map = 1.0
		mtl.use_color_map = 1.0
		mtl.use_metallic_map = 1.0
		mtl.use_roughness_map = 1.0
		mtl.use_ao_map = 1.0
	) else (
		mtl.use_normal_map = 0.0
		mtl.use_color_map = 1.0
		mtl.use_metallic_map = 0.0
		mtl.use_roughness_map = 0.0
		mtl.use_ao_map = 0.0
	)
)

--x1 = medit.GetActiveMtlSlot()
PBR_switch meditMaterials[medit.GetActiveMtlSlot()]