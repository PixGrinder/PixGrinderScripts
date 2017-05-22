-- MaxDiff --
-- v 0.01 --

pda_ComparedFiles = getFiles "D:\Temp\Compare\*.max"

mySt1= substituteString pda_ComparedFiles[1] ".max" ".txt"
-- mySt1a = pathConfig.convertPathToUnc mySt1


the1stFile = createFile mySt1
close the1stFile

the1stFile = openFile mySt1 mode:"w"

loadMaxFile pda_ComparedFiles[1] useFileUnits:true quiet:true


for obj in objects do 
(
	format "%;%;%\r" obj.name obj.position obj.rotation to:the1stFile
)

close the1stFile