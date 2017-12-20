-- PixGrinder 1st Startup Script !!! --


	clearListener()
	global pda_TheStart
	fn myTestFn=
	(
	-- 	sleep 5
		pda_TheStart = true
		messagebox ("AutoSave is launched !")
		fileIn "$userScripts/PixGrinder/XF/AutoSave_WIP.ms"
	)
	callbacks.addScript #filePostOpen "myTestFn()" id:#FelipeCallback persistent:false
	format ("PixGrinder Startup Done\r")



-- callbacks.removeScripts id:#FelipeCallback