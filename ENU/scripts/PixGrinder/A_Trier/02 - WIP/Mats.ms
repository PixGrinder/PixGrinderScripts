-- MAts.ms

clearListener()

fn mySort v1 v2 =
(
	if v1.name > v2.name then 1 else -1
)



x1 = getClassInstances standardMaterial
WithMaps = for obj in x1 where obj.diffuseMap != undefined collect obj
NoMaps = for obj in x1 where obj.diffuseMap == undefined collect obj

qsort WithMaps mySort
qsort NoMaps mySort

allMats = WithMaps + NoMaps

actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener


for obj in WithMaps do format "%;%\r" obj.name (filenameFromPath obj.diffuseMap.bitmap.filename)
for obj in NoMaps do format "%;%\r" obj.name obj.diffuse


-- Materials Render --

for i = 1 to allMats.count do 
(
	$Sphere001.material = allMats[i]
	myMap = bitmap 256 256 filename:("D:/Work/AS365CompLoc/Thumbs/0"+ i as string + "_" + allMats[i].name+".png")
	render to:myMap vfb:true
	save myMap
	close myMap
)

-- select $Sphere001
