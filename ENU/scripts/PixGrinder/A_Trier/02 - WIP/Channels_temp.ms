-- Channels temp -- 

myPostFix  = "_AO"

x1 = getClassInstances standardMaterial

x2 = for mat in x1 where mat.diffuseMap != undefined and classof mat.diffuseMap == Bitmaptexture collect mat

for obj in x2 do
(
	meditMaterials[1] = obj
	myMap = copy obj.diffuseMap
	myMap.filename = "maps/"+ (getFilenameFile myMap.filename) + myPostFix + (getFilenameType myMap.filename)
-- 	meditMaterials[1].specularMap = myMap -- specu
-- 	meditMaterials[1].glossinessMap = myMap -- metalness
-- 	meditMaterials[1].bumpMap = myMap -- normalMap
	meditMaterials[1].selfillumMap = myMap -- AO

)

-------

/*

for i = 1 to x2.count do format "% - %\r" i x2[i].name

obj = x2[14]

classof meditmaterials[2].diffuseMap

*/