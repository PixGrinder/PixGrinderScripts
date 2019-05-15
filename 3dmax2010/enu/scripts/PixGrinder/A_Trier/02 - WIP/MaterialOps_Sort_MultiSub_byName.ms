--- Sort MultiMAts ---

/*
Road Map : 

Sort Materials alphabetically

*/



clearListener()
myTarget = selection[1]
myStartMat = myTarget.material
meshIds = #()

if classof myStartMat != Multimaterial then messageBox("Wrong Mat type")

--polyop.getFaceMatID myTarget 1

for i = 1 to (getNumFaces myTarget) do appendifunique meshIds (polyop.getFaceMatID myTarget i)
sort meshIds

for id in meshIds do print id


actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener



allMats = getClassInstances StandardMaterial

fn nameCompare v1 v2 = 
(
	if v1.name > v2.name then 1 else -1
)

qsort allMats nameCompare

MegaMat = multiMaterial numsubs:(allMats.count-24)

for i = 1 to (allMats.count-24) do MegaMat[i] = allMats[i+24]

meditMaterials[1] = MegaMat
-- meditMaterials[2] = allMats[23]


--for obj in allmats do print obj.name


-- Select faces by Material ID  --

obj = selection[1]
newFaceSel = #() 
max modify mode
select obj
subobjectlevel
for f = 1 to obj.numfaces do
if polyop.getFaceMatID obj f== 3 do append newFaceSel f
polyop.setFaceSelection obj newFaceSel
redrawViews()


/*
polyop.getFaceMatID <Poly poly> <int face>

polyop.setFaceMatID <Poly poly> <facelist> <int MatID>
*/

