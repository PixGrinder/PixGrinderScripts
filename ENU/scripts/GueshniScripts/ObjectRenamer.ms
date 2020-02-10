try (destroyDialog roll_objectRename) catch ()

iniFile = getdir #userscripts + "\\toolState.ini"

rollout roll_objectRename "Object Renamer"
(
	group "Base Name :"
	(
		button btn_sampleBaseName "!" width:12 height:16 across:3 offset:[-28,3] tooltip:"Copy name from selected object"
		editText edt_baseName fieldWidth:120 offset:[-53,2]
		button btn_baseRename "Rename" width:55 offset:[8,0] tooltip:"Rename selected objects"
	)
	group "Add Characters :"
	(
		button btn_addPrefix "+" width:30 across:4 offset:[-11,0] tooltip:"Add characters to beginning of names"
		button btn_sampleAddName "!" width:12 height:16 offset:[-33,3]
		editText edt_addText fieldWidth:111 offset:[-50,2]
		button btn_addSuffix "+" width:30 offset:[13,0] tooltip:"Add characters to end of names"
	)
	group "Remove Characters :"
	(
		spinner spn_prefix range:[0,99,0] type:#integer fieldWidth:30 align:#left offset:[-2,2] across:5
		button btn_removePrefix "-" width:20 offset:[-3,0] tooltip:"Remove characters from beginning of names"
		button btn_removeBoth "Remove" width:55 offset:[2,0] tooltip:"Remove characters from beginning & end"
		button btn_removeSuffix "-" width:20 offset:[7,0] tooltip:"Remove characters from end of names"
		spinner spn_suffix range:[0,99,3] type:#integer fieldWidth:30 align:#right offset:[4,2]
	)
	group "Substitue Characters :"
	(
		label lbl_replaceText "Replace" across:3 offset:[-13,4]
		button btn_sampleReplaceText "!" width:12 height:16 offset:[-48,3]
		editText edt_replaceText "" fieldWidth:116 offset:[-74,2]
		label lbl_withText "With" across:4 offset:[3,4]
		button btn_sampleWithText "!" width:12 height:16 offset:[-24,3]
		editText edt_withText "" fieldWidth:116 offset:[-42,2]
		button btn_swapText "X" width:16 height:36 offset:[20,-19] tooltip:"Swap name fields"
		button btn_replace "Replace" width:198  tooltip:"Replace characters in names"
	)
	group "Number Suffix :"
	(
		dropdownlist ddl_format items:#("00", "000") width:42 across:3 tooltip:"Suffix length"
		spinner spn_start "Start " range:[0,999,1] type:#integer fieldwidth:30 offset:[-10,2]
		spinner spn_increment "Step " range:[1,100,1] type:#integer fieldwidth:30 offset:[0,2]
		checkbox chk_underscore "_" offset:[0,2] across:3 tooltip:"Include underscore in Add/Remove"
		button btn_addNumbers "Add" width:100 offset:[-15,0] tooltip:"Add incremental number suffixes"
		button btn_removeNumbers "Remove" width:55 offset:[8,0] tooltip:"Remove numbers from end of names"
	)
	group "Change Case"
	(
		button btn_caseSwap1st "Swap 1st" width:60 align:#left across:3 tooltip:"Swap case of 1st character"
		button btn_caseSwapAll "Swap All" width:60 tooltip:"Swap case of all characters"
		button btn_caseLower "all lower" width:60 align:#right tooltip:"Change all characters to lower case"
	)
	group "Select by Name (from Selection) :"
	(
		button btn_sampleSelectByName "!" width:12 height:16 across:4 offset:[-20, 3]
		editText edt_selectByName fieldWidth:120 offset:[-37, 2]
		button btn_selectRemove "<" width:25 offset:[32,0] tooltip:"Remove objects from selection"
		button btn_selectAdd ">" width:25 offset:[16, 0] tooltip:"Leave objects selected"
	)
	
	on btn_sampleBaseName pressed do if selection.count == 1 then edt_baseName.text = $.name
	
	on btn_baseRename pressed do
	(
		undo "Object Rename (Base)" on
		(
			for obj in selection do
			(
				obj.name = edt_baseName.text
			)
		)
	)
	
	on btn_sampleAddName pressed do if selection.count == 1 then edt_addText.text = $.name
	
	on btn_addPrefix pressed do
	(
		undo "Object Rename (Add Prefix)" on
		(
			for obj in selection do
			(
				sourceName = obj.name
				newPrefix = edt_addText.text
				newName = newPrefix + sourceName
				obj.name = newName
			)
		)
	)
	
	on btn_addSuffix pressed do
	(
		undo "Object Rename (Add Suffix)" on
		(
			for obj in selection do
			(
				sourceName = obj.name
				newSuffix = edt_addText.text
				newName = sourceName + newSuffix
				obj.name = newName
			)
		)
	)
	
	on btn_removePrefix pressed do
	(
		undo "Object Rename (Remove Prefix)" on
		(
			for obj in selection do
			(
				sourceName = obj.name
				prefixRemove = spn_prefix.value
				newName = substring sourceName (prefixRemove +1) (sourceName.count)
				obj.name = newName
			)
		)
	)
	
	on btn_removeBoth pressed do
	(
		undo "Object Rename (Remove Prefix + Suffix)" on
		(
			for obj in selection do
			(
				sourceName = obj.name
				prefixRemove = spn_prefix.value
				suffixRemove = spn_suffix.value
				newName = substring sourceName (prefixRemove +1) (sourceName.count - (prefixRemove + suffixRemove))
				obj.name = newName
			)
		)
	)
	
	on btn_removeSuffix pressed do
	(
		undo "Object Rename (Remove Suffix)" on
		(
			for obj in selection do
			(
				sourceName = obj.name
				suffixRemove = spn_suffix.value
				newName = substring sourceName 1 (sourceName.count - suffixRemove)
				obj.name = newName
			)
		)
	)
	
	on btn_sampleReplaceText pressed do if selection.count == 1 then edt_replaceText.text = $.name
	
	on btn_sampleWithText pressed do if selection.count == 1 then edt_withText.text = $.name
	
	on btn_swapText pressed do
	(
		tempText = edt_replaceText.text
		edt_replaceText.text = edt_withText.text
		edt_withText.text = tempText
	)

	on btn_replace pressed do
	(
		undo "Object Rename (Replace)" on
		(
			for obj in selection do
			(
				sourceName = obj.name
				replaceString = edt_replaceText.text
				withString = edt_withText.text
				
				replacePos = findString sourceName replaceString
				if replacePos != undefined then
				(
					renameString = replace sourceName replacePos  (replaceString.count) withString
					obj.name = renameString
				)
			)
		)
	)
	
	on btn_addNumbers pressed do
	(
		undo "Object Rename (Add Numbers)" on
		(
			objNumber = spn_start.value
			increment = spn_increment.value
			
			for obj in selection do
			(
				renameString = obj.name
				if chk_underscore.state == true then renameString += "_"
				numberString = objNumber as string
				numberStringLength = ddl_format.selection
				if numberStringLength == 1 then
				(
					if objNumber <10 and objNumber >= 0 then numberString = "0" + numberString
				)
				else
				(
					if objNumber <10 and objNumber >= 0 then numberString = "00" + numberString
					else if objNumber <100 and objNumber >= 10 then numberString = "0" + numberString
				)
				renameString += numberString
				obj.name = renameString
				objNumber += increment
				)
			spn_start.value = objNumber
			if spn_start.value > 999 then spn_start.value = 999
		)
	)
	
	on btn_removeNumbers pressed do
	(
		undo "Object Rename (Remove Numbers)" on
		(
			for obj in selection do
			(
				remString = obj.name
				suffixLength = 0
				for i = remString.count to 1 by -1 do
				(
					checkString = bit.charAsInt (substring remString i 1)
					if checkString >=47 and checkString <= 58 then suffixLength += 1
					else if checkString == 95 and chk_underscore.state == true then suffixLength += 1
					else exit
				)
				renameString = substring remString 1 (remString.count - suffixLength)
				obj.name = renameString
			)
		)
	)
	
	on btn_caseSwap1st pressed do
	(
		undo "Object Rename (Swap Case 1st)" on
		(
			for obj in selection do
			(
				swapString = obj.name
				checkString = bit.charAsInt (substring swapString 1 1)
				if checkString >=65 and checkString <= 90 then checkString += 32 else if checkString >=97 and checkString <= 122 then checkString -= 32
				renameString = (bit.intAsChar checkString) + substring swapString 2 swapString.count
				obj.name = renameString
			)
		)
	)
	
	on btn_caseSwapAll pressed do
	(
		undo "Object Rename (Swap Case All)" on
		(
			for obj in selection do
			(
				swapString = obj.name
				renameString = ""
				for i = 1 to swapString.count do
				(
					checkString = bit.charAsInt (substring swapString i 1)
					if checkString >=65 and checkString <= 90 then checkString += 32 else if checkString >=97 and checkString <= 122 then checkString -= 32
					renameString += (bit.intAsChar checkString)
				)
				obj.name = renameString
			)
		)
	)
	
	on btn_caseLower pressed do
	(
		undo "Object Rename (All Lower Case)" on
		(
			for obj in selection do
			(
				swapString = obj.name
				renameString = ""
				for i = 1 to swapString.count do
				(
					checkString = bit.charAsInt (substring swapString i 1)
					if checkString >=65 and checkString <= 90 then checkString += 32
					renameString += (bit.intAsChar checkString)
				)
				obj.name = renameString
			)
		)
	)
	
	on btn_sampleSelectByName pressed do if selection.count == 1 then edt_selectByName.text = $.name
	
	on btn_selectRemove pressed do
	(
		undo "Object Rename (Remove From Selection)" on
		(
			selectArray = #()
			for obj in selection do
			(
				checkString = edt_selectByName.text
				if findString obj.name checkString == undefined then append selectArray obj
			)
			select selectArray
		)
	)
	
	on btn_selectAdd pressed do
	(
		undo "Object Rename (Leave Selected)" on
		(
			selectArray = #()
			for obj in selection do
			(
				checkString = edt_selectByName.text
				if findString obj.name checkString != undefined then append selectArray obj
			)
			select selectArray
		)
	)
	
	on roll_objectRename open do
	(
		if  (getIniSetting iniFile "objectRename" "position") != "" then SetDialogPos roll_objectRename (execute(getIniSetting iniFile "objectRename" "position"))
	)
	
	on roll_objectRename close do
	(
		setIniSetting iniFile "objectRename" "position" ((GetDialogPos roll_objectRename) as string)
	)
)
createDialog roll_objectRename width:220 pos:[140,210] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)