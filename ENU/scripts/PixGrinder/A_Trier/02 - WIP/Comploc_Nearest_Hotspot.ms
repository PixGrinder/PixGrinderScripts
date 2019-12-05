-- Nearest_Cam -- 
-- V1.0 --
--------------------


myArray = #()
fn mySortCam v1 v2= 
(
	if v1[1] > v2[1] then 1 else -1
)


myATA = for obj in objects where matchpattern obj.name pattern:"ATA_??-??_*" == true collect obj

for obj in myATA do
(
	theCams = for cam in cameras collect #((distance cam obj), cam)
	qsort theCams mySortCam
	append myArray #(obj.name, theCams[1][2].name)
)

clearListener()
actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
for ar in myArray do format "%  -  %\r" ar[1] ar[2]

