-- matRenamer -- 
clearListener()

fn readAsPoint3 v1 = 
(
	v1 = v1 as string
	a = (substring v1 1 3) as integer
	b = (substring v1 4 3) as integer
	c = (substring v1 9 3) as integer
	[a,b,c]
)

x1 = getClassInstances Bitmaptexture

for obj in x1 do obj.name = (getFilenameFile obj.bitmap.filename) + "_bitmap"


x1 = getClassInstances StandardMaterial
x1 = for obj in x1 where obj.diffusemap != undefined and (classof obj.diffuseMap) == Bitmaptexture collect obj

for obj in x1 do obj.name = (getFilenameFile obj.diffuseMap.bitmap.filename) + "_mtl"


x1 = getClassInstances StandardMaterial
x1 = for obj in x1 where obj.diffusemap == undefined collect obj
for obj in x1 do 
(
	myConv = obj.diffuse as ponit

	obj.name = "MatColor_" + ((obj.diffuse as point3) as string)
)

actionMan.executeAction 0 "40472"

/*

show x1[1]
getFilenameFile x1[1].bitmap.filename

for obj in x1 do print (getFilenameFile obj.bitmap.filename)
(readAsPoint3 ($.material.diffuse))
x1 = ($.material.diffuse as Point3)
x1 = (color 255 255 255)
x1 = x1 as string
readAsPoint3 v1
v1 = undefined

a = (substring x1 8 3) as integer



*/