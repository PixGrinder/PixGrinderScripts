-- CL_Hierarchy_Selector --
-- V0.6 --

rollout pda_Working "Working"
(
	Label lbl1 "Identifying Components..."
)



FileIn "$userScripts/PixGrinder/A_Trier/02 - WIP/CL_Component_Identifier.ms"

FileIn "$userScripts/PixGrinder/A_Trier/02 - WIP/CL_Array_Parser.ms"
 




-- enableSceneRedraw() 

clearListener()

function selectHierarchy =
(
    for p in selection do
    (
	    if p.children != undefined do selectmore p.children
    )
)

fn sortBySize file1 file2 =
(
	if getFileSize file1 > getFileSize file2 then 1 else -1
)


-- 	initPath = getDir #scene
	initPath = @"D:\Travail\SVN3D_H160\H160_Comploc\MAX\CAO_BRUT\"
	theMaxFiles = #()
	
	if Maxfilepath.count != 0 do initPath = Maxfilepath
	
	
	fn FileSelec thePath = 
	(
		theDialog = dotNetObject "System.Windows.Forms.OpenFileDialog" --create a OpenFileDialog 
		theDialog.title = "PLEASE Select One Or More Files" --set the title
		theDialog.Multiselect = true --allow multiple files to be selected
		theDialog.Filter = "MaxFile(*.max)|" --specify the filter
		theDialog.FilterIndex = 1 --set the filter drop-down list to All Files
		theDialog.InitialDirectory = thePath
		theDialog.FileName="*.max"
		result = theDialog.showDialog() --display the dialog, get result into variable
		result.ToString() --when closed, convert the result to string
		result.Equals result.OK --returns TRUE if OK was pressed, FALSE otherwise
		result.Equals result.Cancel --returns TRUE if Cancel was pressed, FALSE otherwise
		theFilenames = theDialog.fileNames --the selected filenames will be returned as an array
		return theFilenames
	)
	
	
	theMaxFiles = FileSelec initPath

	qsort theMaxFiles sortBySize



callbacks.removeScripts id:#myPdaSvnUpdate





for fil in theMaxFiles do
(
	loadMaxFile fil quiet:on allowPrompts:off useFileUnits:on

	allComponents = #()


	for t = 1 to myTable.count do
	(
		pda = #()
		myComp = #()
		clearSelection()

		for i = 1 to myTable[t][2].count do
		(
			--if (myTable[t][2][i] as string).count > 12 then mySearch = (FilterString (myTable[t][2][i]) "--")[2] else mySearch = (myTable[t][2][i])
			mySearch = (myTable[t][2][i] as string)
			pda = for obj in helpers where matchpattern obj.name pattern:("*"+ mySearch +"*") == true collect obj
			if pda.count >= 1 then
			(
				select pda
				selectHierarchy()
				-- myComp = for obj in selection where superclassof obj == GeometryClass collect obj
				for obj in selection do appendifunique myComp obj
			) else (
				myComp = #()
			)
		)

		if myComp.count >= 1 then
		(
			myComp = for obj in myComp where superclassof obj == GeometryClass collect obj
			select myComp
			myComp1 = #()
			for obj in myComp do append myComp1 (copy obj)
			for obj in myComp1 do
			(
				obj.material = undefined
				obj.parent = undefined
				obj.wireColor = (color 128 128 128)
			)



			select myComp1
			FileIn "$userScripts/PixGrinder/A_Trier/02 - WIP/CL_AttachComponents.ms"
	-- 		doesFileExist "$userScripts/PixGrinder/A_Trier/02 - WIP/CL_AttachComponents.ms"

			myResult = selection[1]
			myResult.name = myTable[t][1]
			myResult.pivot = myResult.center
			update myResult

			appendifunique allComponents myResult
		)
		myResult = undefined
		--mod 100 10
		if mod allComponents.count 10 == 0.0 then
		(
			if doesFileExist (MaxFilePath+(getfilenameFile maxFileName)+ "_ID_WIP.max") then deleteFile (MaxFilePath+(getfilenameFile maxFileName)+ "_ID_WIP.max")
			saveNodes allComponents (MaxFilePath+(getfilenameFile maxFileName)+ "_ID_WIP.max") quiet:on
		)
	)

FinalFile = maxFilePath + (getfilenameFile maxFileName) + "_IDENTIFIED.max"
saveMaxFile FinalFile useNewFile:on quiet:on
)


DestroyDialog pda_Working


messageBox("Identification Finished !")

-- ForceCompleteRedraw()





-- U212A3430113_--A_DEF01_AIR_DISTRIBUTOR



/*

for obj in myTable[15][2] do print obj


-- WORKING TRIMMED VERSION --
-------------------------------
for i = 1 to myTable[15][2][i].count do
(
	if (myTable[15][2][i] as string).count > 12 then mySearch = (FilterString (myTable[15][2][i]) "--")[2] else mySearch = (myTable[15][2][i])
	pda = for obj in helpers where matchpattern obj.name pattern:("*"+ (mySearch as string) +"*") == true collect obj
	select pda
	selectHierarchy()
	-- myComp = for obj in selection where superclassof obj == GeometryClass collect obj
	for obj in selection do appendifunique myComp obj
)




OLD VERSION
---------------
	for i = 1 to myTable[27][2][i].count do
	(
		for obj in helpers do
		(
			if matchpattern obj.name pattern:("*"+ (myTable[27][2][i] as string) +"*") == true do appendifunique pda obj
		)
		select pda
		selectHierarchy()
		-- myComp = for obj in selection where superclassof obj == GeometryClass collect obj
		for obj in selection do appendifunique myComp obj
	)
--------------------
*/

