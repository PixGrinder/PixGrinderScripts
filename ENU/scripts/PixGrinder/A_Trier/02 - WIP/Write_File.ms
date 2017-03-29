--------- WIP ----------------------

clearListener()
global HelicoList
if doesFileExist "d:/AS365.txt" == false then 
(
	HelicoList = createFile "d:/AS365.txt"
	print "File Created"
) else (
	HelicoList = openFile "d:/AS365.txt"
	print "File Opened"
)

filePos()


format "Youpi" to:HelicoList

close HelicoList