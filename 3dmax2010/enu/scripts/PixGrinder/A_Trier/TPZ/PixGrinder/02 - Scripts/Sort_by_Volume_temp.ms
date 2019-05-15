fn CalculateVolumeAndCenterOfMass obj =
(
local Volume= 0.0
local Center= [0.0, 0.0, 0.0]
local theMesh = snapshotasmesh obj
local numFaces = theMesh.numfaces
for i = 1 to numFaces do
(
  local Face= getFace theMesh i
  local vert2 = getVert theMesh Face.z
  local vert1 = getVert theMesh Face.y
  local vert0 = getVert theMesh Face.x
  local dV = Dot (Cross (vert1 - vert0) (vert2 - vert0)) vert0
  Volume+= dV
  Center+= (vert0 + vert1 + vert2) * dV
)
delete theMesh
Volume /= 6
Center /= 24
Center /= Volume
--#(Volume,Center)
Volume
)

pda = #()

for obj in geometry do append pda (abs(CalculateVolumeAndCenterOfMass obj))
sort pda
for i = 1 to pda.count do print pda[i]


-----------------------------------------------

-- Diagonal method

(
	global mySmall = "small"
	global myMed = "medium"
	global myHigh = "high"
	pda = #()
	pdasmall = #()
	pdamed = #()
	pdahigh = #()


	for obj in geometry do append pda (distance obj.max obj.min)
	myMoy = (amax pda + amin pda)/2
	mySeuil = (amax pda - amin pda)/3
	for obj in geometry do
	(
		if (distance obj.max obj.min) < ( (amin pda) + mySeuil ) do append pdasmall obj
		if (distance obj.max obj.min) < ( (amin pda) + (mySeuil*2) )  and (distance obj.max obj.min) > ( (amin pda) + mySeuil ) do append pdamed obj
		if (distance obj.max obj.min) > ( (amin pda) + (mySeuil*2) ) do append pdahigh obj
	)

	SelectionSets[mySmall] = pdasmall
	SelectionSets[myMed] = pdamed
	SelectionSets[myHigh] = pdahigh
)



pda
#(0.000215067, 0.000225368, 0.000247636, 0.000344524, 0.0338743, 0.0400035, 0.0400036, 0.049, 0.0490001, 0.0490001, 0.0490001, 0.0542444, 0.0588417, 0.061522, 0.0623213, 0.0628453, 0.0628453, 0.0628453, 0.0628453, 0.0639395, ...)
myTemp=0
0
for i = 1 to pda.count do myTemp = myTemp + pda[i]
OK
myTemp
2599.83
myTemp / pda.count
1.03373



-----------------------------------------------


-- Brouillon -- 
(
	global mySet = "lift_up"
	global x=1
	global pda1 = #()
	global pda2 = #()
	if SelectionSets[mySet] == undefined then
	(
		SelectionSets[mySet] = #()

	) else
	(
		select SelectionSets[mySet]
		pda2 = getCurrentSelection()
		
	)
	
	while x != 100 do 
	(
		pda1 =  pickObject()
		if pda1 == undefined then exit
		append pda2 pda1
		SelectionSets[mySet] = pda2
		hide pda1
		x = x+1
	) 
)


