-- CL - Remove doubles in CustAttrib


cur = selection[1]
-- obj.compLoc.hidden

-- tempNames = for bla in cur.compLoc.hidden collect #(i+1,bla,bla.node,bla.node.name)
--for obj in tempNames do format "%   %   \r" obj[1] obj[2]

fn mySort v1 v2 =  
(
	if v1[1] > v2[1] then 1 else -1
)

tempNames = #()
for i = 1 to cur.compLoc.hidden.count do
(
	append tempNames #(cur.compLoc.hidden[i].node.name, cur.compLoc.hidden[i],cur.compLoc.hidden[i].node,cur.compLoc.hidden[i].node.name)
)

qsort tempNames mySort

for obj in tempNames do format "%\r" obj

theArr = #()

for obj in tempNames do
(
	for bla in theArr do
	(
		if obj[4] != bla[2] do append theArr #(obj[2],obj[4])
	)
)

theArr.count
/*
tempArray = #()
for obj in cur.compLoc.hidden do appendIfUnique tempArray obj
for obj in tempArray do format "%\r" obj.node.name

for obj in $.compLoc.hidden do
(
	for bla in $.compLoc.hidden do
	(
		if obj.node == bla.node then deleteItem  $.compLoc.hidden
	)
)

*/
