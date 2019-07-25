clearListener()
select cameras
actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
myVar=0.1
format "----------------------\r\r"
format "%;%;%;%\r" "Hotspot name" "Hotspot position" "Hotspot default rotation" "Hotspot rotation"
for obj in selection do format "%;%,%,%\r" obj.name (obj.pos.x*myVar*-1.0) (obj.pos.z*myVar) (obj.pos.y*myVar*-1.0)
format "\r\r----------------------\r"