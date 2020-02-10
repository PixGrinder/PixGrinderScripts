(
	try(destroyDialog speedMeter)catch()
rollout speedMeter "Speed Meter"
(
	label speedLbl "0" pos:[30,5]
	label kmhLbl "km/h" pos:[60,5]

    fn getSelection = (
		global obj
		obj = $
		)
		
	fn getUnits = (
		global unitsType
		case of (
			 (units.SystemType == #Millimeters) :unitsType = 1000
		     (units.SystemType == #Centimeters) : unitsType = 100
		     (units.SystemType == #Meters) : unitsType = 1
		     (units.SystemType == #Kilometers) : unitsType = 0.001
		     default : (messagebox "This script doesn't support yours system units" tittle:"ERROR")
		     )
		)
	
	fn measureFn =(
		     try(
		     actualPos = at time slidertime obj.pos
             futurePos = at time (slidertime+framerate) obj.pos
             speedLbl.text = (((distance actualPos futurePos)/unitsType)*3.6) as string
		     )catch()
		)
		
	on speedMeter open do(
		getUnits()
		registerRedrawViewsCallback getSelection
		registerTimeCallback measureFn
		)
		
    on speedMeter close do(
		unregisterTimeCallback measureFn
		unregisterredrawViewsCallback getSelection
		unregisterRedrawViewsCallback getUnits
		)

)createdialog speedMeter width:100 pos:[140,210] style:#(#style_toolwindow,#style_sysmenu) -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45) 
)