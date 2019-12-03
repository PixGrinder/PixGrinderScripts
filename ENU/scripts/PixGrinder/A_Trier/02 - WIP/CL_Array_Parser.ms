-- CL_Array_Parser --
-- v0.2 --

clearListener()

for obj in myTable do 
(
	tp1 = trimleft obj[1]
	tp1 = trimRight tp1
	obj[1] = tp1
)



for i = 1 to myTable.count do
(
	st1 = myTable[i][2]

	myTemp = FilterString st1 "\r"

	for a = 1 to myTemp.count do 
	(
		x1 = trimleft myTemp[a]
		x1 = trimRight x1
		myTemp[a] = x1
	)
	myTable[i][2] = myTemp
)



for obj in myTable do print obj

myTable[1][1]

print myTable[10]