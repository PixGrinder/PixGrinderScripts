--------- WIP ----------------------

clearListener()
global myConfig
myConfig = openFile "D:/03_Max_UI/myShelf_TOMERGE_01.cuix" mode:"r"
myTemp = ""

while not eof do 
(
	append myTemp (readLine myConfig)
	append myTemp "\r"
)
close myConfig

format myTemp














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

