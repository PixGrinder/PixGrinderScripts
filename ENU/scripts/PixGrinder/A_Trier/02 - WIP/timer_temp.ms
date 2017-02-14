	fn youpi = 
	(
		print "youpi"
	)
	
	if pdaTimer == undefined then pdaTimer = dotNetObject "System.Windows.Forms.Timer" else pdaTimer.stop()
	dotnet.addEventHandler pdaTimer "tick" youpi
	pdaTimer.interval = TimeInterval
	pdaTimer.start()
	

	
	
	
	