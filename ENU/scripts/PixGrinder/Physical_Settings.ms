-- Physical_Settings --

(
	x1 = getClassInstances PhysicalMaterial
	for obj in x1 do 
	(
		meditmaterials[1] = obj
		with quiet true (meditmaterials[1].material_mode = 0)
		meditmaterials[1].roughness_inv = off
		meditmaterials[1].roughness = 0.8
		meditmaterials[1].reflectivity = 0.1
		meditmaterials[1].name
	)
)


/*
obj = x1[2]


rootScene[#SME][#View2][#H225_BitMapMat_atlas_nlg____Physical_Material].Properties.reference.material_mode = 1
rootScene[#SME][#View2][#H225_BitMapMat_atlas_nlg____Physical_Material].Properties.reference.reflectivity = 1
rootScene[#SME][#View2][#H225_BitMapMat_atlas_nlg____Physical_Material].Properties.reference.refl_color = color 255 255 255 255
rootScene[#SME][#View2][#H225_BitMapMat_atlas_nlg____Physical_Material].Properties.reference.brdf_mode = on
rootScene[#SME][#View2][#H225_BitMapMat_atlas_nlg____Physical_Material].Properties.reference.diff_roughness = 0
rootScene[#SME][#View2][#H225_BitMapMat_atlas_nlg____Physical_Material].Properties.reference.reflectivity_map = undefined
rootScene[#SME][#View2][#H225_BitMapMat_atlas_nlg____Physical_Material].Properties.reference.refl_color_map = undefined
rootScene[#SME][#View2][#H225_BitMapMat_atlas_nlg____Physical_Material].Properties.reference.material_mode = 0



tpzviewer.exe D:\03_RnD\OSGB_Export\test.OSGB


*/