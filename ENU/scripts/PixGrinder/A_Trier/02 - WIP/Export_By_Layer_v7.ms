-- Export by Layer



(

	clearListener()
	myStdPath = "D:\10 - Helicopters\H135CompLoc\AH_H135_Unity\Assets\Graphics\Models\\"
	global exp_path = getSavePath caption:"Export Files To : " initialDir:myStdPath
	global exp_path = append exp_path "\\"
	
	
	delete cameras
	
	
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
		myDum = dummy name:"temp"
		if selection.count <= 2 then 
		(
			myName = (exp_path + selection[1].name + ".fbx")
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


	
	


)



