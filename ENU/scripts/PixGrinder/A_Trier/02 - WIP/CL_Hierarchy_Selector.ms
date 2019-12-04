-- CL_Hierarchy_Selector --
-- V0.3 --

clearListener()

function selectHierarchy =
(
    for p in selection do
    (
	    if p.children != undefined do selectmore p.children
    )
)

allComponents = #()

-- for i = 1 to myTable.count do
-- (

-- )

pda = #()
clearSelection()
mySearch = myTable[7][2][1]
for obj in helpers do -- modified in v4.2
(
	if matchpattern obj.name pattern:("*"+mySearch+"*") == true do appendifunique pda obj
)

select pda

selectHierarchy()

myComp = for obj in selection where superclassof obj == GeometryClass collect obj

select myComp
myComp1 = #()
for obj in myComp do append myComp1 (copy obj)
for obj in myComp1 do obj.material = undefined
for obj in myComp1 do obj.parent = undefined


select myComp1
Include "$userScripts/PixGrinder/AttachSelected.ms"
myResult = selection[1]
myResult.name = myTable[7][1]
myResult.wireColor = (color 128 128 128)
update myResult

ForceCompleteRedraw()
append allComponents myResult
myResult = undefined



-- U212A3430113_--A_DEF01_AIR_DISTRIBUTOR





