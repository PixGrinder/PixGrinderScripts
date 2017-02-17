-- Bitmap Mat Instancier -- 


x1 = getClassInstances standardMaterial -- x1 = tous les matériaux standards de la scene

x2 = for obj in x1 where classof obj.diffusemap == BitmapTexture and obj.diffusemap.filename != undefined collect obj    -- x2 = tous les materiaux standards qui ont une image en diffuseMap


-- pda =  liste de tous les fichiers textures utilisés dans la scène

pda = #()
for obj in x2 do appendifunique pda (filenameFromPath obj.diffusemap.filename)
clearListener()
for obj in pda do print obj 





--- find all materials with pda[1] (1st bitmap) -- SORT BY SPECULAR LATER

print pda[1]




-- SORT BY SPECULAR LATER
-- fn sortBySpecu v1 v2=
-- (
-- 	if v1.specularLevel > v2.specularLevel then 1 else -1
-- )
-- SORT BY SPECULAR LATER


myTemp = for obj in x2 where (filenamefrompath obj.diffusemap.filename) == pda[1] collect obj -- myTemp = tous les matériaux qui ont la texture pda[1]

-- put all materials in material editor slots
for i = 1 to myTemp.count do meditmaterials[i] = myTemp[i]

clearListener() 					-- afficher tous les matériaux de myTemp
for obj in myTemp do print obj		-- afficher tous les matériaux de myTemp



-- myRef = myTemp[1]  -- myRef = le 1er matériau de la liste myTemp -- SORT BY SPECULAR LATER

myObjStd = for obj in objects where classof obj.material == StandardMaterial and classof obj.material.diffusemap == BitmapTexture and obj.material.diffusemap.filename != undefined collect obj -- myObjStd = tous les objets de la scene qui ont un matériau standard avec texture en diffuse
myObjMult = for obj in objects where classof obj.material == Multimaterial collect obj -- myObjMult = tous les objets de la scene qui ont un multi matériaux



-- traitement des objets à matériau simple
for obj in myObjStd where (filenamefrompath obj.material.diffuseMap.filename) == pda[1] do obj.material = myTemp[1]


-- traitement des objets à matériau multiple

for obj in myObjMult do 
(
	for i = 1 to obj.material.count do
	(
		if classof obj.material[i].diffusemap == BitmapTexture and obj.material[i].diffusemap.filename != undefined and (filenamefrompath obj.material[i].diffuseMap.filename) == pda[1] do obj.material[i] = myTemp[1]
	)
)

for obj in myTemp do print obj		-- afficher tous les matériaux de myTemp
