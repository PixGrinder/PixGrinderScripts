-- CL_Hierarchy_Selector --
-- V0.4 --


-- enableSceneRedraw() 

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
myComp = #()
clearSelection()

for i = 1 to myTable[15][2].count do
(
	--if (myTable[15][2][i] as string).count > 12 then mySearch = (FilterString (myTable[15][2][i]) "--")[2] else mySearch = (myTable[15][2][i])
	mySearch = (myTable[15][2][i] as string)
	pda = for obj in helpers where matchpattern obj.name pattern:("*"+ mySearch +"*") == true collect obj
	select pda
	selectHierarchy()
	-- myComp = for obj in selection where superclassof obj == GeometryClass collect obj
	for obj in selection do appendifunique myComp obj
)

	myComp = for obj in myComp where superclassof obj == GeometryClass collect obj
	select myComp
	myComp1 = #()
	for obj in myComp do append myComp1 (copy obj)
	for obj in myComp1 do
	(
		obj.material = undefined
		obj.parent = undefined
		obj.wireColor = (color 128 128 128)
	)



	select myComp1
	FileIn "$userScripts/PixGrinder/AttachSelected.ms"
	myResult = selection[1]
	myResult.name = myTable[15][1]
	myResult.pivot = myResult.center
	update myResult



ForceCompleteRedraw()

append allComponents myResult
myResult = undefined



-- U212A3430113_--A_DEF01_AIR_DISTRIBUTOR



/*

for obj in myTable[15][2] do print obj


-- WORKING TRIMMED VERSION --
-------------------------------
for i = 1 to myTable[15][2][i].count do
(
	if (myTable[15][2][i] as string).count > 12 then mySearch = (FilterString (myTable[15][2][i]) "--")[2] else mySearch = (myTable[15][2][i])
	pda = for obj in helpers where matchpattern obj.name pattern:("*"+ (mySearch as string) +"*") == true collect obj
	select pda
	selectHierarchy()
	-- myComp = for obj in selection where superclassof obj == GeometryClass collect obj
	for obj in selection do appendifunique myComp obj
)




OLD VERSION
---------------
	for i = 1 to myTable[27][2][i].count do
	(
		for obj in helpers do
		(
			if matchpattern obj.name pattern:("*"+ (myTable[27][2][i] as string) +"*") == true do appendifunique pda obj
		)
		select pda
		selectHierarchy()
		-- myComp = for obj in selection where superclassof obj == GeometryClass collect obj
		for obj in selection do appendifunique myComp obj
	)
--------------------
*/

