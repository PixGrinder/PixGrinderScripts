-- The TimerStart -- 


(

	clearListener()
	global myMinutes = 0.02
	global TimeInterval = myMinutes*1000*60
	global pdaTimer = dotNetObject "System.Windows.Forms.Timer"


	fn pda_AutoSave =
	(
		format "% %" localTime "\r"
	)

	dotnet.addEventHandler pdaTimer "tick" pda_AutoSave
	pdaTimer.interval = TimeInterval
	pdaTimer.Start()


	rollout ASPrompt "AutoSave Prompt"
	(
		label myQuestion "Timer Control" offset:[0,10]
		button pixYes "Start"  width:100 across:2 offset:[0,20]
		button pixNo "Stop"  width:100 across:2 offset:[0,20]

		on pixYes pressed do 
		(
			pdaTimer.Start()
			format "Timer Started\r"
		)


		on pixNo pressed do
		(
			pdaTimer.Stop()
			format "Timer Stopped\r"
		)
	)
	createDialog ASPrompt 250 150 150 150


)

