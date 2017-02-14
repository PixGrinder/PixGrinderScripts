
clearListener()

pda1 = getClassInstances BitmapTexture


pda2=#()

for obj in x1 do appendifUnique pda2 obj
	
pda2.count

pda3 = for i = 24 to pda2.count collect pda2[i]
pda3.count

myCond = 1



if myCond == 1 then 
(
	print "IF n° 1"
	for i = 1 to 24 do meditMaterials[i] = pda2[i]
) else ( myCond = 2 )


if myCond == 2 do 
(
	print "IF n° 2"
	for i = 1 to 24 do meditMaterials[i] = StandardMaterial()
	for i = 1 to pda3.count do meditMaterials[i] = pda3[i]
	myCond = 1
)

print ("myCond = " + (myCond as string ))