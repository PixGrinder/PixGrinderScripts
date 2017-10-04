----------------------
-- Layers Toggle --
-- v2.1 --
----------------------

(
	myTemp = true
	myCondition = false
	nb = (layermanager.count)-1


	fn layerOn = 
	(
		for i = 0 to nb do 
		(
			myLay = (layermanager.getlayer i)
			if matchpattern myLay.name pattern:"zz*" then myLay.on = false else myLay.on = true
		)
	)


	fn layerOff x1= 
	(
		for i = 0 to x1 do (layermanager.getlayer i).on = false
	)


	for i = 0 to nb do 
	(
		if (layermanager.getlayer i).on == true do myCondition = true
	)


	if myCondition == false then layerOn() else (layerOff nb)
	
)
