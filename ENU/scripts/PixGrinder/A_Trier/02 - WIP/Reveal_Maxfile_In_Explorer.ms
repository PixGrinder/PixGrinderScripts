-- PixGrinder
-- Reveal CurrentScene in windows explorer


(
	fn fileExist =
	(
		Hiddendoscommand ("explorer.exe /select, "+ "\"" +(maxfilepath+maxfileName)+"\"")
	)
	
	fn myFail =
	(
		messageBox ("Please, save your scene before using this script")
	)
	
	
	if maxfilename.count != 0 then fileExist() else myFail()
)