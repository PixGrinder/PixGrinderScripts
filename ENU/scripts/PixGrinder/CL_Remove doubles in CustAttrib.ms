-- CL - Remove doubles in CustAttrib

tempNames = #()
cur = selection[1]
t1 = cur.compLoc.hidden.count as string
fn mySort v1 v2 =  
(
	if v1[1] > v2[1] then 1 else -1
)


for i = 1 to cur.compLoc.hidden.count do
(
	append tempNames #(cur.compLoc.hidden[i].node.name, cur.compLoc.hidden[i],cur.compLoc.hidden[i].node,cur.compLoc.hidden[i].node.name)
)

qsort tempNames mySort
theYoupla = #()
append theYoupla tempNames[1][2]

for i = 2 to tempNames.count do
(
	if tempNames[i-1][1] != tempNames[i][1] then append theYoupla tempNames[i][2]
)

t2 = theYoupla.count as string

/*
clearListener()
print("Before : "+t1)
print("After : "+t2)
*/

cur.compLoc.hidden = theYoupla

/*
blurf = "cur.compLoc.hidden"
execute (blurf+".count")
*/

-- for obj in tempNames do print obj[1]

