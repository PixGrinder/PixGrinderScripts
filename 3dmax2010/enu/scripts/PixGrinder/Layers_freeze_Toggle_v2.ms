-----------------------------
-- Layers Freeze Toggle --
------------------------------

(
	myTemp = true
	myCondition = 0
	nb = layermanager.count
	nb = nb-1


	fn layerOn x1 = 
	(
		for i = 0 to x1 do 
		(
			myLay = layermanager.getlayer i
			myLay.lock= true
		)
	)


	fn layerOff x1= 
	(
		for i = 0 to x1 do 
		(
			myLay = layermanager.getlayer i
			myLay.lock = false
		)
	)


	for i = 0 to nb do 
	(
		myTemp = layermanager.getlayer i
		if myTemp.lock == true do myCondition = 1
	)


	if myCondition == 0 then (layerOn nb) else (layerOff nb)
	
)
