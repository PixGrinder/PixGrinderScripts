--------- WIP ----------------------

clearListener()
if doesFileExist "d:/AS365.txt" == false then 
(
	global HelicoList = createFile "d:/AS365.txt"
	print "File Created"
) else (
	global HelicoList = openFile "d:/AS365.txt"
	print "File Opened"
)

filePos()


print "Youpi" to "d:/AS365.txt"

close HelicoList