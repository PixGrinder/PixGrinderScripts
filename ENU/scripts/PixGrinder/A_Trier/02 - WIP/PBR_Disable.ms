-- PBR_Disable --

DxData = getClassInstances DirectX_9_Shader

for mtl in DxData do
(
	mtl.use_normal_map = 0.0
	mtl.use_color_map = 1.0
	mtl.use_metallic_map = 0.0
	mtl.use_roughness_map = 0.0
	mtl.use_ao_map = 0.0
)


/*

classof meditmaterials[1]



*/