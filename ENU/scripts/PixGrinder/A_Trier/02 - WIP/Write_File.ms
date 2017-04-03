--------- WIP ----------------------
-- v 0.4 --

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
-- while skipToString cfFile "</Window>" != undefined do 
-- (
-- 	print (filepos cfFile)
-- 	skipToString cfFile "</Window>"
-- )

skipToString cfFile "</CUIWindows>"
myPos = filepos cfFile - 13

seek cfFile myPos


format "\r \r" to:cfFile
format myTemp to:cfFile
format "\r \r" to:cfFile
close cfFile



-- UTILISER DES VARIABLES POUR RE-ECRIRE COMPLETEMENT LE FICHIER CONFIG !! --

