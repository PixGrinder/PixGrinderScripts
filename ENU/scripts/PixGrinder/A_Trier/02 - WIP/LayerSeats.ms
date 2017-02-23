
-- Add Seats to hidden Layer

(
	myLay = layermanager.newLayerFromName "SeatsTemp"
	myLay = layermanager.getLayerFromName "SeatsTemp"
	myLay.on = false
	for obj in objects where obj.center.x > 500 do myLay.addnode obj
)