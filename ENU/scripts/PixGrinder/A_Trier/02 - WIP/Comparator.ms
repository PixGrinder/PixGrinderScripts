-- MaxFile Comparator


(
	clearListener()
	myObjects1 = #()
	myMissings = #()
	mySelec = #()
	myStdPath = "c:"+"\\"
-- 	global exp_path = getSavePath caption:"Export Files To : " initialDir:myStdPath
-- 	global exp_path = append exp_path "\\"
	exp_path = getSavePath caption:"Select Folder with files to compare : " initialDir:myStdPath
	exp_path = append exp_path ("\\" + "*.max")
	
	files = getFiles exp_path
	
	loadMaxFile files[1] useFileUnits:true quiet:true
	
	for obj in objects do append myObjects1 obj.name
		
	loadMaxFile files[2] useFileUnits:true quiet:true
	
	for obj in myObjects1 do
	(
		if (getNodeByName obj exact:true ignoreCase:false all:false) == undefined do append myMissings obj
	)
	
	for obj in myMissings do print obj
	
	loadMaxFile files[1] useFileUnits:true quiet:true
	
	for bla in myMissings do 
	(
		append mySelec (getNodeByName bla exact:true ignoreCase:false all:false)
	)
	
	select mySelec
	
	messageBox("Missing objects in " + files[2] + " have been selected in " + files[1])
)


