(
	clearListener()
	TimeInterval = 0.1*1000*60
	test = 1

	pdaTimer = dotNetObject "System.Windows.Forms.Timer"
	fn myTest = 
	(
		print "test"
		test = test+1
		if test > 5 do 
		(
			pdaTimer.stop()
			print "Timer stopped"
		)
	)
	dotnet.addEventHandler pdaTimer "tick" myTest
	pdaTimer.interval = TimeInterval
	pdaTimer.start()

)