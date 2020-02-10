 (
	global rol_ViewportStatistic
	 
	try(destroyDialog rol_ViewportStatistic)catch()
	rollout rol_ViewportStatistic "Viewport Statistic"
	(
		local curMaxVersion = ((maxversion())[1] / 1000)
		checkbox chkbtn_polygon "Polygon Count" pos:[5,5] checked:true
		checkbox chkbtn_triangle "Triangle Count" pos:[5,25] checked:true
		checkbox chkbtn_edge "Edge Count" pos:[5,45] checked:false
		checkbox chkbtn_vertex "Vertex Count" pos:[5,65] checked:true
		checkbox chkbox_fps "FPS" pos:[5,85] checked:false
		radiobuttons rb_objects "" labels:#("Total", "Selection", "Total + Selection") default:3 columns:1 offset:[60,-80]

		function ChangeStatistic =
		(
			dialogMonitorOPS.UnRegisterNotification id:#ChangeStatisticsSettingsID
			dialogMonitorOps.enabled = true
			function ChangeStatisticsSettings = 
			(
				local type = case rb_objects.state of
					(
						1: "Total"
						2: "Selection"
						3: "Total + Selection"
					)
				local BM_SETCHECK = 241	
				local BN_CLICKED = 0
				local WM_COMMAND = 273
				local TCM_SETCURFOCUS = 0x1330
				local statisticsTabIndex = if curMaxVersion < 15 then 5 else 6
				local hwnd = DialogMonitorOPS.GetWindowHandle()
				local hwnd_title = UIAccessor.GetWindowText hwnd
				if (hwnd_title == "Viewport Configuration") then
				( 
					for kidHWND in (UIAccessor.GetChildWindows hWND) where ((UIAccessor.GetWindowClassName kidHWND) == "SysTabControl32") do
					(
						UIAccessor.SendMessage kidHWND TCM_SETCURFOCUS statisticsTabIndex 0
					)
					controls = windows.getChildrenHWND hwnd
					show = undefined
					for child in controls do
					(
						if (child[5] == type) do show = child
						if (child[5] == "Total") do (UIAccessor.SendMessage child[1] BM_SETCHECK 0 0)
						if (child[5] == "Selection") do (UIAccessor.SendMessage child[1] BM_SETCHECK 0 0)
						if (child[5] == "Total + Selection") do (UIAccessor.SendMessage child[1] BM_SETCHECK 0 0)
						if (child[5] == "Polygon Count") do (UIAccessor.SendMessage child[1] BM_SETCHECK (if chkbtn_polygon.checked then 1 else 0) 0)
						if (child[5] == "Triangle Count") do (UIAccessor.SendMessage child[1] BM_SETCHECK (if chkbtn_triangle.checked then 1 else 0)  0)
						if (child[5] == "Edge Count") do (UIAccessor.SendMessage child[1] BM_SETCHECK (if chkbtn_edge.checked then 1 else 0)  0)
						if (child[5] == "Vertex Count") do (UIAccessor.SendMessage child[1] BM_SETCHECK (if chkbtn_vertex.checked then 1 else 0)  0)
						if (child[5] == "Frames Per Second") do (UIAccessor.SendMessage child[1] BM_SETCHECK (if chkbox_fps.checked then 1 else 0)  0)
					)
					--
					if show != undefined do
					(
						UIAccessor.SendMessage show[1] BM_SETCHECK 1 0
						windows.sendMessage (UIAccessor.getParentWindow show[1]) WM_COMMAND ((bit.shift BN_CLICKED 16) + (UIAccessor.getWindowResourceID hwnd)) show[1] 
						uiAccessor.sendMessageID hwnd #IDOK
					)
					UIAccessor.PressButtonByName hwnd "OK"
				) 
				true
			)
			dialogMonitorOPS.RegisterNotification ChangeStatisticsSettings id:#ChangeStatisticsSettingsID
			max vptconfig
			dialogMonitorOPS.UnRegisterNotification id:#ChangeStatisticsSettingsID
			dialogMonitorOps.enabled = false
		)
		
		on chkbtn_polygon changed state do ChangeStatistic()
		on chkbtn_triangle changed state do ChangeStatistic()
		on chkbtn_edge changed state do ChangeStatistic()
		on chkbtn_vertex changed state do ChangeStatistic()
		on chkbox_fps changed state do ChangeStatistic()
		
		on rb_objects changed state do ChangeStatistic()
		
		on rol_ViewportStatistic open do
		(
			ChangeStatistic()
		)
	)
	createdialog rol_ViewportStatistic width:220 pos:[10,300] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)
)