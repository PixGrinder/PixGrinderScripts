
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Startup for Autosave --
-- Lauches Timers and everything needed for PixGrinder's autosave system --
-- V 0.1 --

---------------------------------------------------------------------




(
	clearListener()
	myMinutes = 1.0
	TimeInterval = myMinutes*1000*60

	global pix_AutoSaveMaxFiles = 50

	myTotal = myMax - 1

	global pixTimer = dotNetObject "System.Windows.Forms.Timer"
	
	dotnet.addEventHandler pixTimer "tick" myAutoSave
	pixTimer.interval = TimeInterval
	pixTimer.start()
	
	SaveStartup()
	--pdaTimer.stop()
	) 
)
------------------------------------------------------------------

