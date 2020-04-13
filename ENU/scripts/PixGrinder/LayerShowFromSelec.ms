-- LayerShowFromSelec --
-- v 2.0 --

(
	
	myLays = #()
	for obj in selection do appendIfUnique myLays obj.layer

	x1 = selection[1].layer

	for i = 1 to (layermanager.count-1) do
	(
		myLay = layermanager.getlayer i
		myLay.on = false
	)

	for lay in myLays do lay.on = true
	--x1.current = true
)