-- LayerShowFromSelec --


(
	x1 = selection[1].layer

	for i = 1 to (layermanager.count-1) do
	(
		myLay = layermanager.getlayer i
		myLay.on = false
	)

	x1.on = true
	x1.current = true
)