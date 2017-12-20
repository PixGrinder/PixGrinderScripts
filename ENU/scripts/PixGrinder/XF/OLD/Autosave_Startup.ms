-- PixGrinder 1st Startup Script !!! --


	clearListener()
	fn myTestFn=
	(
	-- 	sleep 5
		messagebox ("AutoSave is launched !")
		fileIn "$userScripts/GueshniScripts/AutoSave.ms"
	)
	callbacks.addScript #filePostOpen "myTestFn()" id:#FelipeCallback persistent:false
	print "PixGrinder Startup Done"



-- callbacks.removeScripts id:#FelipeCallback