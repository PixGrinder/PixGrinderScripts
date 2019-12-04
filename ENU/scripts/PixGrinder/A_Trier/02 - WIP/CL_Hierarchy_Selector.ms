-- CL_Hierarchy_Selector --
-- V0.2 --

clearListener()

function selectHierarchy =
(
    for p in selection do
    (
	    if p.children != undefined do selectmore p.children
    )
)



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







-- U212A3430113_--A_DEF01_AIR_DISTRIBUTOR





