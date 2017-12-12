-- PixGrinder
-- Reveal CurrentScene Backupo Folder in windows explorer


(
	fn myFail =
	(
		messageBox ("Please, save your scene before using this script")
	)


	fn fileExist =
	(
		pda_myPath = maxfilepath + "_BACKUP_\\"+ substituteString maxfilename ".max" ""+"_autoback"
		if doesFileExist pda_myPath == true then (Hiddendoscommand ("explorer.exe /e, "+ "\"" +pda_myPath+"\"")) else myFail()
	)
	

	
	
	if maxfilename.count != 0 then fileExist() else myFail()
)



