-- MaxDiff --
-- v 0.03 --

resetMaxFile #noPrompt
clearListener()

-- Variables
myAr1 = myAr2 = #()


-- Functions
fn pdaMySortAr a b=
(
	if a[2]>b[2] then 1 else -1
)


fn myLogFiles comparedFile theNumber=
(
	print theNumber
	mySt = substituteString comparedFile[theNumber] ".max" ".csv"
	theFile = createFile mySt
	close theFile
	theFile = openFile mySt mode:"w"
	loadMaxFile comparedFile[theNumber] useFileUnits:true quiet:true
	myAr = #()
	for obj in objects do 
	(
		theVolTemp = obj.max-obj.min
		theVol = abs(theVolTemp[1]*theVolTemp[2]*theVolTemp[3])
		theDist = distance [0,0,0] obj.position
		append myAr #(obj.name,theVol,theDist,obj.pivot,obj.position)
	)
	qsort myAr pdaMySortAr
	format "Name;Bounding Box;Distance to Origin;Pivot;Position\r" to:theFile
	for obj in myAr do format "%;%;%;%;%\r" obj[1] obj[2] obj[3] obj[4] obj[5] to:theFile
	close theFile
	resetMaxFile #noPrompt
)




pda_ComparedFiles = getFiles "D:\\Temp\\Compare\\*.max"
-- mySt1= substituteString pda_ComparedFiles[1] ".max" ".csv"
-- mySt2= substituteString pda_ComparedFiles[2] ".max" ".csv"
myLogFiles pda_ComparedFiles 1
myLogFiles pda_ComparedFiles 2

messageBox("The End")







