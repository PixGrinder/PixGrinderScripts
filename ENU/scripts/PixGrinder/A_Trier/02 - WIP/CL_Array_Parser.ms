-- CL_Array_Parser --
-- V1.0 --

clearListener()

for obj in myTable do 
(
	tp1 = trimleft obj[1] "\"\r\n"
	tp1 = trimRight tp1 "\"\r\n"
	tp1 = substituteString tp1 "\r" ""
	tp1 = substituteString tp1 "\n" ""
	obj[1] = tp1
)



for i = 1 to myTable.count do
(
	st1 = myTable[i][2]

	myTemp = FilterString st1 "\r"

	myTable[i][2] = myTemp
)


for i = 1 to myTable.count do
(
	for a = 1 to myTable[i][2].count do 
	(
		x1 = trimLeft myTable[i][2][a] "\"\r\n"
		x1 = trimRight x1 "\"\r\n"
		x1 = substituteString x1 "\r" ""
		x1 = substituteString x1 "\n" ""
		myTable[i][2][a] = x1
	)
)



-----------------------------

/*
clearListener()
myTable[10]
myTable[10][2][1]
for obj in myTable[10][2] do format "%\r" obj
for obj in myTable do format "%\r" obj


for i = 1 to 100 do format "%\r" myTable[i]


for i = 1 to myTable.count do format "%  -  %\r" i myTable[i]


for obj in myTable do print obj

myTable[1][1]

print myTable[10]


for i = 1 to myTable.count do
(

	--myTable[i][2]

	for a = 1 to myTable[i][2].count do 
	(
		x1 = trimleft myTable[i][2][a]
		x1 = trimRight x1
		myTable[i][2][a] = x1
	)

)

i=297
a1 = myTable[i][1]


*/