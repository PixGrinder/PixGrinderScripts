myVar=0.1
fn sortByName v1 v2 =
(
	if v1.name > v2.name then 1 else -1
)
--myAr = cameras as array
myAr = selection as array
qsort myAr sortByName
actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
clearListener()
format "----------------------\r\r"
format "%;%;%;%\r" "Hotspot name" "Hotspot position" "Hotspot default rotation" "Hotspot rotation"
for obj in myAr do format "%;%,%,%\r" obj.name (obj.pos.x*myVar*-1.0) (obj.pos.z*myVar) (obj.pos.y*myVar*-1.0)
format "\r\r----------------------\r"