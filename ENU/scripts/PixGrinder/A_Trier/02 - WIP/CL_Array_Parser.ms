-- CL_Array_Parser --
-- v0.1 --

clearListener()

st1 = myTable[1][2]

myTemp = FilterString st1 "\r"

for a = 1 to myTemp.count do 
(
	x1 = trimleft myTemp[a]
	x1 = trimRight x1
	myTemp[a] = x1
)




