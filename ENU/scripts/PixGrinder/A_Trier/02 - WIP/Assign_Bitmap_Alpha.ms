MatEditor.Close()
allTex = getclassinstances BitmapTexture
for obj in allTex do
(
	obj.alphaSource = 0
	obj.monoOutput = 1
)

TranspMats = for mat in (getclassinstances StandardMaterial) where matchpattern mat.name pattern:"t_*" collect mat
myMatBak = meditmaterials[24]
for obj in TranspMats do
(
	meditMaterials[24] = obj
	if meditMaterials[24].diffuseMap != undefined then meditMaterials[24].opacityMap = meditMaterials[24].diffuseMap
)
meditmaterials[24] = myMatBak
MatEditor.Open()