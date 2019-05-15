

-- Post Import Treatment
(
	clearListener()	
	
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
	
	mySelec.parent = myDummy
	
	myDummy.scale = myDummy.scale * 0.01
	Rotate myDummy (eulerangles 0 3 0)
	myDummy.position.z = - 4.3
	
	delete myDummy
	
	select mySelec
	
	max tool zoomextents all

	
)
