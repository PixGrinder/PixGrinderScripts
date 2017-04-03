--------- WIP ----------------------
-- v 0.3 --

clearListener()
global myConfig
myConfig = openFile "D:/03_Max_UI/myShelf_TOMERGE_01.cuix" mode:"r"
myTemp = ""

while not eof myConfig do 
(
	append myTemp (readLine myConfig)
	append myTemp "\r"
)
close myConfig

-- format myTemp



cfActualPath = cui.getDir()
cfActualFile = cui.getConfigFile()
cfBackup = substituteString cfActualFile ".cuix" ".OLD"

copyFile cfActualFile cfBackup

cfFile = openFile cfActualFile mode:"a+"

seek cfFile 0
while skipToString cfFile "Window>" != undefined do skipToString cfFile "Window>"
filepos cfFile

format "\r \r" to:cfFile


format myTemp to:cfFile
close cfFile


-------------------------------------------------------------------------

if doesFileExist "d:/AS365.txt" == false then 
(
	HelicoList = createFile "d:/AS365.txt"
	print "File Created"
) else (
	HelicoList = openFile "d:/AS365.txt" mode:"a+"
	print "File Opened"
)



format "Youpla" to:HelicoList

close HelicoList

readLine HelicoList

filePos HelicoList

readValue "youp"

readToken "youp"

seek HelicoList #eof
seek HelicoList 0

