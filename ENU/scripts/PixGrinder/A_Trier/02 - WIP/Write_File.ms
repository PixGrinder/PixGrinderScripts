--------- WIP ----------------------
-- v 0.5 --
-- Test'n'pray !! --

clearListener()
global myConfig
global myToolBox


-- Backup Actual Config File --
cfActualFile = cui.getConfigFile()
cfBackup = substituteString cfActualFile ".cuix" ".OLD"
copyFile cfActualFile cfBackup


-- Copy Lines before my text in myToolBox --
myToolBox = ""
cfFile = openFile cfActualFile mode:"r"
seek cfFile 0
skipToString cfFile "</CUIWindows>"
myPos = (filepos cfFile) - 13
seek cfFile 0
while filepos cfFile <= (myPos - 5) do
(
	append myToolBox (readLine cfFile)
	append myToolBox "\r"
)
close cfFile


-- Add my Lines in myToolBox --
myConfig = openFile "D:/03_Max_UI/myShelf_TOMERGE_01.cuix" mode:"r"
while not eof myConfig do 
(
	append myToolBox (readLine myConfig)
	append myToolBox "\r"
)
close myConfig


-- Copy Lines after my text in myToolBox --
cfFile = openFile cfActualFile mode:"r"
seek cfFile (myPos - 1)
-- skipToString cfFile "</CUIWindows>"
while not eof cfFile do
(
	append myToolBox (readLine cfFile)
	append myToolBox "\r"
)
close cfFile

-- replace current config file --
-- deleteFile cfActualFile
-- createFile cfActualFile
-- close cfActualFile
cfFile = openFile cfActualFile mode:"w+"
seek cfFile 0
format myToolBox to:cfFile
close cfFile






-- UTILISER DES VARIABLES POUR RE-ECRIRE COMPLETEMENT LE FICHIER CONFIG !! --

