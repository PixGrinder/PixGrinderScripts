-- SVN Startup --
-- SvnStartup.ms --
-- dassonphil@gmail.com -- 
-- v2.0 --

/*
rollout pdaMyUI "File Open Prompt"
(
	hyperlink  pda_lbl1 "Please wait during svn update" offset:[0,5] enabled:false align:#center
	hyperlink pda_lbl2 "You can click OK when update is finished !" offset:[0,5] enabled:false align:#center
	button pda_myOK "OK" width:75 align:#center offset:[0,10]
	on pda_myOK pressed do DestroyDialog pdaMyUI
	on pdaMyUI open do setFocus pda_myOK
)
*/
--fn pdaSvnUpdate v1 =
fn pdaSvnUpdate =
(
	pda_myFile = callbacks.notificationParam()
	pda_myFile = pda_myFile[2]
	if findString pda_myFile "maxstart.max" == undefined then
	(
		pda_cmd = "/command:update "
		pda_svn = @"C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe"
		print pda_myFile
		ShellLaunch pda_svn (pda_cmd + "/path:" + pda_myFile)
		messageBox ("Press OK when file is updated")
-- 		createDialog v1 300 100 modal:true escapeEnable:true bgcolor:(color 60 90 100) fgcolor:(color 255 255 255)
-- 		setFocus pdaMyUI.pda_myOK
	)
	--try (setFocus pdaMyUI.pda_myOK) catch ()
)

callbacks.removeScripts id:#myPdaSvnUpdate
-- callbacks.addScript #filePreOpenProcess "pdaSvnUpdate pdaMyUI" id:#myPdaSvnUpdate
callbacks.addScript #filePreOpenProcess "pdaSvnUpdate()" id:#myPdaSvnUpdate
format "SVN Startup Script launched successfully !\r"


/*

#mainWindowEnabled boolean

myString = "maxstart.max"
findString myString "bla"
createDialog pdaMyUI 300 100 modal:true escapeEnable:true bgcolor:(color 60 90 100) fgcolor:(color 255 255 255)

hyperlink  pda_lbl1 "Please wait during svn update" offset:[0,5] enabled:false align:#center

hyperlink pda_lbl2 "You can click OK when update is finished !" offset:[0,5] enabled:false align:#center

on myRollout open do setFocus editTextName


*/


