-- MatIdFinder v2--

try (DestroyDialog myFinder) catch ()
-- pda1 = meditMaterials[1].materialList
-- pda2 = meditMaterials[1].materialIDList
-- pda3 = meditMaterials[1].names

rollout myFinder "" 
(
	--edittext <name> [<caption>] [text:<string>] [fieldWidth:<integer>] [height:<integer>] [bold:<boolean>] [labelOnTop:<boolean>] [readOnly:<boolean>] [toolTip:<string>]
	edittext myMatSearch "" text:"" fieldWidth:150 align:#center --[height:<integer>] [bold:<boolean>] [labelOnTop:<boolean>] [readOnly:<boolean>] [toolTip:<string>]
	button myBtn "Search ID" align:#center
	--edittext myMatId "" text:"Id" fieldWidth:150 align:#center
	edittext myMatId ""  fieldWidth:450 height:550 text:"Result" offset:[-2,15] align:#center

	on myBtn pressed do
	(
		myVal = ""
		for i = 1 to (meditMaterials[1].names).count do 
		(
			if MatchPattern (meditMaterials[1].materialList[i].name) pattern:("*" + myMatSearch.text + "*") then append myVal ((meditMaterials[1].materialIDList[i] as string) + " - " + (meditMaterials[1].names[i]) +"\n" )
			if myVal.count > 0 then myFinder.myMatId.text = myVal
		)
	)

	on myMatSearch entered myText do
	(
		myVal = ""
		for i = 1 to (meditMaterials[1].names).count do 
		(
			if MatchPattern (meditMaterials[1].materialList[i].name) pattern:("*" + myText + "*") then append myVal ((meditMaterials[1].materialIDList[i] as string) + " - " + (meditMaterials[1].names[i]) +"\n" )
			if myVal.count > 0 then myFinder.myMatId.text = myVal
		)
	)


)



CreateDialog myFinder 500 670 800 150



-- for i = 1 to (meditMaterials[1].names).count do print meditMaterials[1].names[i]