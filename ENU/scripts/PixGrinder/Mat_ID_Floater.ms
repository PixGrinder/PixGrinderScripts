
-- Mat_ID_Floater --
-- pixgrinder@gmail.com --

-- v1.1 --
--------------------------

clearListener()



fn selID var1= 
(
	subObjectLevel = 4
	myAr = #{}
	for i = 1 to getNumFaces selection[1] do 
	(
		if polyop.getFaceMatID selection[1] i == var1 then append myAr i

	)
	polyop.setFaceSelection selection[1] myAr
	update selection[1]
)


rollout PDE_Ids "Material IDs" 
(
	Label lbl1 "Set ID :" across:2
	spinner mySet "" range:[1,150,1] type:#integer fieldWidth:50
	button myGetBtn "Select ID" across:2
	spinner myGet "" range:[1,150,1] type:#integer fieldWidth:50 offset:[0,3]
	dropdownlist myDropList "" items:theMatList offset:[3,0] --[selection:<number>] [height:<number>] [tooltip:<string>] 


	on myGetBtn pressed do selID myGet.value

	on mySet changed val do 
	(
		theAr = polyop.getFaceSelection selection[1]
		--theAr
		for fc in theAr do polyop.setFaceMatID selection[1] fc mySet.value
		update selection[1]
	)

	on myDropList selected val do
	(
		x1 = filterString myDropList.selected " - "
		myGet.value = x1[1] as integer
		selID (x1[1] as integer)
	)

)


fn matFloat =
(
	theMatList = #()

	myIds = #()
	for i = 1 to getNumFaces selection[1] do appendifUnique myIds (polyop.getFaceMatID selection[1] i)
	myIds = for obj in myIds where obj != undefined collect obj
	sort myIds

	if classof selection[1].material == Multimaterial then
	(
		for i = 1 to myIds.count do
		(
			if classof selection[1].material[myIds[i]] == StandardMaterial then
			(
				if selection[1].material[myIds[i]].diffuseMap == undefined then 
				(
					append theMatList (myIds[i] as string + " - ")
				) else (
					append theMatList (myIds[i] as string + " - " + (filenameFromPath selection[1].material[myIds[i]].diffuseMap.filename)) 
				)
			)

			if classof selection[1].material[myIds[i]] == PhysicalMaterial then
			(
				if selection[1].material[myIds[i]].base_color_map == undefined then 
				(
					append theMatList (myIds[i] as string + " - ")
				) else (
					append theMatList (myIds[i] as string + " - " + (filenameFromPath selection[1].material[myIds[i]].base_color_map.filename)) 
				)
			)


		)
	)
	try (DestroyDialog PDE_Ids) catch()
	createDialog PDE_Ids --width:300
)

matFloat()
callbacks.addScript #modPanelSelChanged "matFloat()" id:#MatFloaterCallback persistent:false
