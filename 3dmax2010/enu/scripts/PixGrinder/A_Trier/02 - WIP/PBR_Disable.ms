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

selection[1].material[2].TEX_global_diffuse_cube = undefined
selection[1].material[2].TEX_global_specular_cube = undefined
selection[1].material[2].TEX_brdf_lut = undefined
show selection[1].material[1]


D:\PBR_Tests\Users\Guest1239\AppData\Local\Autodesk\3dsMax\2019 - 64bit\ENU\plugcfg_ln\ShaderFX\Images\PBS\midday


*/