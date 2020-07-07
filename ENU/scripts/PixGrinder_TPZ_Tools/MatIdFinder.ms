-- MatIdFinder v3--

try (DestroyDialog myFinder) catch ()


rollout myFinder "" 
(
	edittext myMatSearch "" text:"" fieldWidth:150 align:#center
	button myBtn "Search ID" align:#center
	listbox myMatId "" readOnly:off height:45

	on myBtn pressed do
	(
		myVal = #()
		for i = 1 to (meditMaterials[1].names).count do 
		(
			if MatchPattern (meditMaterials[1].materialList[i].name) pattern:("*" + myMatSearch.text + "*") then append myVal ((meditMaterials[1].materialIDList[i] as string) + " - " + (meditMaterials[1].names[i]))
		)
		clearListener()
		myVal
		if myVal.count > 0 then myFinder.myMatId.items = myVal
	)

	on myMatSearch entered myText do
	(
		myVal = #()
		for i = 1 to (meditMaterials[1].names).count do 
		(
			if MatchPattern (meditMaterials[1].materialList[i].name) pattern:("*" + myMatSearch.text + "*") then append myVal ((meditMaterials[1].materialIDList[i] as string) + " - " + (meditMaterials[1].names[i]))
		)
		clearListener()
		myVal
		if myVal.count > 0 then myFinder.myMatId.items = myVal
	)

	on myMatId doubleClicked itm do 
	(
		mySep = filterString (myFinder.myMatId.items[itm]) " - "
		mySep = mySep[1] as integer
		MatEditor.mode = #basic
		MatEditor.Open()
		meditmaterials[2] = meditmaterials[1][mySep]
	)
)

CreateDialog myFinder 500 670 800 150