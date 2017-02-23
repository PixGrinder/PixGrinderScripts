-- Export by Layer



(

	clearListener()
	myStdPath = "c:"+"\\"
	global exp_path = getSavePath caption:"Export Files To : " initialDir:myStdPath
	global exp_path = append exp_path "\\"
	
	
	delete cameras
	
	(
		l_ar = #()

		l0 = layermanager.getLayer 0
		l0.current = true

		for i = 1 to (layermanager.count-1) do 
		(
			x = layermanager.getLayer i
			append l_ar x.name
		)
		
		for i = 1 to l_ar.count do
		(
			LayerManager.deleteLayerHierarchy l_ar[i] forceDelete:false
		)
	)
	
	
	-- Display all layers --
	(
		for i = 0 to (layermanager.count-1) do 
		(
			myLay = layermanager.getlayer i
			myLay.on = true
		)
	)
	
	
	-- Export by Layer --
	
	for w = 1 to layermanager.count-1 do 
	(
		lx = layermanager.getLayer w
		lx.current = true 
		print ( "layer : " + lx.name )
		myName =""
		max select none
		lx.select on
		myTemp = selection as array
		myDum = dummy name:"temp" isSelected:false
		if myTemp.count <= 2 then 
		(
			myName = (exp_path + myTemp[1].name + ".fbx")
			print myName
		) else (
			max select none
			lx.select on
			x1 = getCurrentSelection()
			pda = for obj in x1 where obj.parent == undefined and obj != myDum collect obj
			-------------
			--select pda -- !!! A passer en remarque !!!
			-------------
			for obj in pda do obj.parent = myDum
			myName = (exp_path + lx.name + ".fbx")
		)
		
		if myName.count !=0 do
		(
			if doesFileExist  myName == true do 
			(
				deleteFile myName
-- 				print myName+" was deleted"
			)
			max select none
			lx.select on
			exportFile myName #noprompt selectedOnly:true using:FBXEXP
			
		)
		delete myDum
		
	)


	loadMaxFile  (MaxFilePath + MaxFileName) useFileUnits:true quiet:true
	
	

)



