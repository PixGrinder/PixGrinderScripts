

-- Post Import Treatment
(
	clearListener()	
	delete cameras
	ScaleRatio = 10
	mySelec= getcurrentSelection()
	pda = #()
	x = 0
	
	myLayer = LayerManager.getLayer 0
	myLayer.name
	
	for i = 0 to layermanager.count-1 do
	(
		myTemp = LayerManager.getLayer i
		if findstring myTemp.name "Imported" == 1 do x = i
	)
	if myTemp == undefined do myLayer = LayerManager.newLayerFromName "Imported"
	if x !=0 do myLayer = LayerManager.getLayer x
	
	myLayer.current = true
	
	for i = 1 to mySelec.count do myLayer.addnode mySelec[i]
	
	myDummy = dummy name:"Imported"
	
	for i = 1 to mySelec.count do
	(
		if mySelec[i].parent == undefined do mySelec[i].parent = myDummy
	)
	
	myDummy.scale = myDummy.scale * ScaleRatio
	Rotate myDummy (eulerangles 0 3 0)
	myDummy.position.z = - 4.3
	
	delete myDummy
	
	select mySelec
	
	for obj in mySelec do setTransformLockFlags obj #all
	
	--for obj in objects do setTransformLockFlags obj #all
		
		
	hideByCategory.helpers = true
	
	max tool zoomextents all

	
)
