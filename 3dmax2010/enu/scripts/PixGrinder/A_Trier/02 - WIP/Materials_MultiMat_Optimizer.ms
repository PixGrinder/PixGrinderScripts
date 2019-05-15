 -- Multimat Instacier --


clearListener()

-- (getClassInstances multimaterial).count
-- (getClassInstances Standardmaterial).count

fn listMats mat= 
(
	myStringTemp = ""
	for i = 1 to mat.count do 
	(
		myStringTemp = myStringTemp + mat[i].name
	)	
	myStringTemp
)

 objMulti = for obj in objects where classof obj.material == MultiMaterial collect #(obj,obj.material,obj.material.count,listMats obj.material)
objMulti.count 

multiMatLibTemp = #()
for obj in objMulti do appendifUnique multiMatLibTemp obj[4]
for obj in multiMatLibTemp do print obj

multiMatLib = #()
for obj in multiMatLibTemp do
(
	theTempList = for bla in objMulti where bla[4] == obj collect bla[2]
	append multiMatLib theTempList[1]
)

multiMatLibTemp.count
for obj in multiMatLib do print obj.name

-- listMats multiMatLib[1]

progressStart "Processing MultiMat Instances..."
myProg = 0

for i = 1 to objMulti.count do
(
	for obj in multiMatLib do
	(
		if objMulti[i][4] == listMats obj then objMulti[i][1].material = obj
	)
	if (100*(i as float)/objMulti.count > (myProg as float)) do
	(
		myProg = myProg+1
		progressUpdate myProg
	)
)

progressEnd()

