label startupLbl "Start with 3ds Max :" align:#left offset:[-5,0]
checkBox startupChk "" width:15 align:#right offset:[5,-18]
label dockStateLbl "Dock :" align:#left offset:[-5,0]
radiobuttons dockStateRdb labels:#("Float", "Left", "Right") default:2 align:#right offset:[5,-18]

on OptionsRoll open do 
(
	startupChk.state = execute (getIniSetting _sgz._ini "MainUi" "startup")
	dockStateRdb.state = execute (getIniSetting _sgz._ini "MainUi" "dockState")
)

on startupChk changed state do 
(
	setIniSetting _sgz._ini "MainUi" "startup" (state as string)
)

on dockStateRdb changed state do 
(
	case state of 
	(
		1: cui.FloatDialogBar SugzToolsUI 
		2: cui.DockDialogBar SugzToolsUI #cui_dock_left
		3: cui.DockDialogBar SugzToolsUI #cui_dock_right
	)
	setIniSetting _sgz._ini "MainUi" "dockState" (state as string)
)