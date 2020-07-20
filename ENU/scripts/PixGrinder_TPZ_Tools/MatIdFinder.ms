-- MatIdFinder v4--
-- Corrected 1 bug when searching names on undefined materials --

try (DestroyDialog myFinder) catch ()


rollout myFinder "" 
(
	edittext myMatSearch "" text:"" fieldWidth:150 align:#center
	button myBtn "Search ID" align:#center
	listbox myMatId "" readOnly:off height:45

	on myBtn pressed do
	(
		if classof meditMaterials[activeMeditSlot] == Multimaterial then
		(
					myVal = #()
					for i = 1 to (meditMaterials[activeMeditSlot].names).count do 
					(
						if MatchPattern (meditMaterials[activeMeditSlot].names[i]) pattern:("*" + myMatSearch.text + "*") then append myVal ((meditMaterials[activeMeditSlot].materialIDList[i] as string) + " - " + (meditMaterials[activeMeditSlot].names[i]))
					)
					clearListener()
					--myVal
					if myVal.count > 0 then myFinder.myMatId.items = myVal
		)
	)

	on myMatSearch entered myText do
	(
		if classof meditMaterials[activeMeditSlot] == Multimaterial then
		(
			myVal = #()
			for i = 1 to (meditMaterials[activeMeditSlot].names).count do 
			(
				if MatchPattern (meditMaterials[activeMeditSlot].names[i]) pattern:("*" + myMatSearch.text + "*") then append myVal ((meditMaterials[activeMeditSlot].materialIDList[i] as string) + " - " + (meditMaterials[activeMeditSlot].names[i]))
			)
			clearListener()
			-- myVal
			if myVal.count > 0 then myFinder.myMatId.items = myVal
		)
	)

	on myMatId doubleClicked itm do 
	(
		mySep = filterString (myFinder.myMatId.items[itm]) " - "
		mySep = mySep[1] as integer
		MatEditor.mode = #basic
		MatEditor.Open()
		if activeMeditSlot < 24 then meditmaterials[(activeMeditSlot+1)] = meditMaterials[activeMeditSlot][mySep]
	)
)

CreateDialog myFinder 500 670 800 150


/*
--------------------------
clearListener()
x1 = meditmaterials[1]
x2 = for obj in x1 collect (classof obj as string)
x2 = makeUniqueArray x2
x2
x1.materialList
for obj in x1.names do print obj
for i = 1 to x1.count do format "% - % - %\r" (i as string) (classof x1[i] as string) (x1.materialIDList[i] as string)





