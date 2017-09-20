(
	clearListener()
	for obj in selection where custAttributes.count obj > 0 do format "%;%\r" obj.name (substring obj.compLoc.hotspot.name (obj.name.count + 2) (obj.compLoc.hotspot.name.count))
)
