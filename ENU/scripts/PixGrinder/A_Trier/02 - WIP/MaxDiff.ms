-- MaxDiff --
-- v 0.02 --


clearListener()

-- Variables
myAr1 = myAr2 = #()


-- Functions
fn pdaMySortAr a b=
(
	if a[2]>b[2] then 1 else -1
)



pda_ComparedFiles = getFiles "D:\Temp\Compare\*.max"

mySt1= substituteString pda_ComparedFiles[1] ".max" ".csv"
mySt2= substituteString pda_ComparedFiles[2] ".max" ".csv"

the1stFile = createFile mySt1
close the1stFile
the2ndFile = createFile mySt2
close the2ndFile

the1stFile = openFile mySt1 mode:"w"
loadMaxFile pda_ComparedFiles[1] useFileUnits:true quiet:true

---
-- obj=objects[1] -- A VIRER !!!
-- obj=objects[2] -- A VIRER !!!
---

for obj in objects do 
(
	--format "%;%;%\r" obj.name obj.position obj.rotation to:the1stFile
	theVolTemp = obj.max-obj.min
	theVol = abs(theVolTemp[1]*theVolTemp[2]*theVolTemp[3])
	theDist = distance [0,0,0] obj.position
	append myAr1 #(obj.name,theVol,theDist,obj.pivot,obj.position)
)

qsort myAr1 pdaMySortAr
clearListener()
format "Name;Bounding Box;Distance to Origin;Pivot;Position\r" to:the1stFile
for obj in myAr1 do format "%;%;%;%;%\r" obj[1] obj[2] obj[3] obj[4] obj[5] to:the1stFile
close the1stFile


