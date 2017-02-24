/*##############################################################################
GFX Conflict Manager Struct
Version 2.0
Script By Cl�ment "Sugz" Plantec
plantec.clement@gmail.com

#Required Components:
SugzTools Manager Struct
Tortoise Svn Struct

#Script infos:
This script is design to avoid 3D artist to work on the same file at the same moment and thus avoid conflict. 
Works with Tortoise SVN

*Use / Modify this script at your own risk !*

check for the conflict bewteen with autosave when performing autosave, as it's not recognize as an autoback
GetIsFileUse is obsolete, use getFile
replace all saves with the method

@"X:\BU_SSA\Scratch\CPlantec\GfxConflictManager\GfxConflictManager.xml"
currentUser = "Yan",
currentUser = "Phil",
currentUser = "test",


###############################################################################*/



struct GfxConflictManagerStruct
(
	
	xmlDoc = dotNetObject "system.xml.xmlDocument",
	xmlPath = "",
	currentUser = sysInfo.username,
	currentFile = "",
	isFileIsNotice = false,
	
	/* Set the GfxConflictManager xml file ############################################################################################*/
	fn SetXmlPath = 
	(
		if xmlPath == "" then 
		(
			_path = undefined
			while _path == undefined do 
			(
				_path = getOpenFileName caption:"Select the Gfx Conflict Manager INI file" filename:"GfxConflictManager.xml" types:"XML (*.xml)" 
			)
			xmlPath = _path
			setIniSetting _sgz._ini "GfxConflictManager" "xmlPath" xmlPath
		)
		
	),
	
	
	/* Get the GfxConflictManager INI file ############################################################################################*/
	fn GetXmlPath = 
	(
		if xmlPath == "" then 
		(
			xmlPath = getIniSetting _sgz._ini "GfxConflictManager" "xmlPath" 
			if xmlPath == "" then SetXmlPath()
		)
		
		xmlPath
	),
	
	
	/* Save the xml file ############################################################################################*/
	fn SaveXml = 
	(
		xmlDoc.save xmlPath
	),
	
	
	/* Create xml and the root node then save it############################################################################################*/
	fn CreateXml = 
	(
		root = xmlDoc.createElement "TheDreamTeam"
		xmlDoc.appendChild root
		SaveXml()
		
	),
	
	
	/* Load xml  and define the root node ############################################################################################*/
	fn LoadXml = 
	(
		xmlDoc.load xmlPath
		if (xmlDoc.firstChild) == undefined then CreateXml()

	),
	
	
	/* Update Macroscript state ############################################################################################*/
	fn UpdateMacro bool = 
	(
		isFileIsNotice = bool
		updateToolbarButtons()
		
	),

	
	/* Create a new xml element as child of a given xml element ############################################################################################*/
	fn AddElement parent type =
	(
		/*<Function>
		Arguments:
			<xml Element> parent : the xml element to add the new xml element to
			<String> type : the type of  the new xml element
		Return:
			<xml Element> newElem : the new xml element
		</Function>*/
		
		-- Create a new element and add it to its parent
		newElem = xmlDoc.createElement type
		parent.appendChild newElem
		
		-- Save the xml document
		SaveXml()
		
		newElem
	),
	
	
	/* Get children list of given xml element ############################################################################################*/
	fn GetElements parent =
	(
		/*<Function>
		Arguments:
			<xml Element> parent: the xml element to get children from
		Return:
			<Array <xml Element>> the parent's children
		</Function>*/
		
		elemList = #()
		for i = 0 to parent.childNodes.count - 1 do 
		(
			appendIfUnique elemList parent.childNodes.itemOf[i]
		)
		
		elemList
	),
	
	
	/*  get user xml element, create it if necessary ############################################################################################*/
	fn GetUser =
	(
		/*<Function>
		Return:
			<xml Element> user: the xml element reprensenting current user
		</Function>*/
		
		-- Get the user element with XPath. 
		user = xmlDoc.selectSingleNode ("/" + xmlDoc.firstChild.name + "/" + currentUser)
		if user == undefined then user = AddElement xmlDoc.firstChild currentUser
			
		user
	),

	
	/* Get the current list of user ############################################################################################*/
	fn GetOtherUsers = 
	(
		/*<Function>
		Return:
			<Array <xml Element>> the users list 
		</Function>*/
		
		return for user in (GetElements xmlDoc.firstChild) where not matchPattern (user.name) pattern:currentUser collect user

	),
	
	
	/* Get the list of other users used files ############################################################################################*/
	fn GetOtherFiles =
	(
		/*<Function>
		Return:
			<Array <xml Element>> fileList : liste contenant tous les fichiers des autres utsers
		</Function>*/
		
		-- Get a list of other users and get all of their file in a list
		fileList = #()
		for user in GetOtherUsers() do
		(
			for file in (GetElements user) do append fileList file
		)
		
		fileList
	),
	
	
	/* Check if the open file isn't already use by someone else ############################################################################################*/
	fn CheckForConflict =
	(
		/*<Function>
		Return:
			<Bool> isFree
		</Function>*/
		
		isFree = true
		
		-- Loop trought every other users files and compare to the open one
		for file in GetOtherFiles() while isFree == true do 
		(
			-- Check if relatif paths are identical
			if (file.getAttribute "Path") == _sgz._tSvn.GetRelatifPath (MaxFilePath + MaxFileName) then 
			(
				-- Format a message indacting that the file is already used, along with the other used flies
				message = StringStream ""
				format "% is working on this file, please work on another one.\nFiles also used right now :\n" file.parentNode.name to:message
				
				-- Get all files used without the conflicted one
				for otherFile in GetOtherFiles() where otherFile != file do 
				(
					format " - %: %\n" otherFile.parentNode.name (otherFile.getAttribute "Path") to:message
				)
				
				messageBox message title: (_sgz._tSvn.GetRelatifPath MaxFilePath + MaxFileName) beep:false
				isFree = false
			)
		)
		
		isFree
	),
	
	
	/* Get current file xml element in the user list ############################################################################################*/
	fn GetFile =
	(
		/*<Function>
		Return:
			<xml Element> file : the xml element representing current file in the user list if it exist, undefined otherwise
		</Function>*/
		
		file = undefined
		for elem in GetElements (GetUser()) while file == undefined do 
		(
			if elem.getAttribute "Path" == currentFile then file = elem
		)
		
		file
	),
	
	
	/* remove a file from the user list ############################################################################################*/
	fn RemoveFileAt index  =
	(
		/*<Function>
		Arguments:
			<xml Element> the index of the element 
		</Function>*/
		
		parent = GetUser()
		parent.removeChild parent.childNodes.itemOf[index]
		SaveXml()
	
	),

	
	/* Check if the open file already exist in the user list ############################################################################################*/
	fn GetIsFileUse =
	(
		/*<Function>
		Return:
			<Bool> isFileUse 
		</Function>*/
		
		-- Loop through the file contain in the list and compare to the actual max file
		isFileUse = false
		for file in GetElements (GetUser()) while not isFileUse do 
		(
			if file.getAttribute "Path" == currentFile then isFileUse = true
		)
	
		isFileUse
	),
	
	
	/* Add current file to the user list  ############################################################################################*/
	fn NoticeFileAsUse =
	(
		-- reload XML
		LoadXml()
		
		-- Update Macroscript and set currentFile
		UpdateMacro false
		
		-- check if the open file is part of svn
		if (_sgz._tSvn.IsSvnPath MaxFilePath) then
		(
			-- Set Current file 
			currentfile = _sgz._tSvn.GetRelatifPath (MaxFilePath + MaxFileName)
			
			-- Check that user can work on the file and isn't already on his list
			if CheckForConflict() and not GetIsFileUse() and maxFileName != "" then 
			(
				-- Ask user if he want to notice he is working on the open file
				if queryBox "Do you want to notice you are working on this file ?" title: currentfile then
				(
					-- Add the file to the user list
					file = AddElement (GetUser()) "File"
					file.setAttribute "Path" currentfile
					SaveXml()
						
					-- Update Macroscript
					 UpdateMacro true
				)
			)
		)
		
		
		
		
		-- Update Macroscript
		if GetIsFileUse() then UpdateMacro true
		
	),
	
	
	/* Ask user to commit the file on svn and update his file list ############################################################################################*/
	fn NoticeFileAsUnuse =
	(
		-- reload XML
		LoadXml()
		
		-- check if current file exist in the user list
		if GetIsFileUse() and (queryBox "Do you want to notice you are not working on this file anymore?" title:currentFile) then 
		(
			-- Lunch tortoise svn for commit
			_sgz._tSvn.ManageSvn #commit (_sgz._tSvn.GetSvnPath())
				
			-- check if the max file has been commit then rewrite ini file
			if queryBox "Did you commit the max file ?" title:currentFile then 
			(
				-- Delete the file in the xml
				file = GetFile()
				file.parentNode.removeChild file
				SaveXml()
				
				-- Update Macroscript
				UpdateMacro false
				
			)
		)
	),
	
	
	/* Update file before loading it to avoid conflict ############################################################################################*/
	fn UpdateFile = 
	(
		-- Get the file path of the file that will be open
		file = callbacks.notificationParam()
		
		-- Check if it's a file related to the project then update it via tortoise SVN before opening it
		if _sgz._tSvn.IsSvnPath(file[2]) then 
		(
			_sgz._tSvn.ManageSvn #update (file[2])
			messageBox "\t\tPress \"OK\" when you have finish the update\t\t\t\t\t" title:(_sgz._tSvn.GetRelatifPath (getFilenamePath file[2] + filenameFromPath file[2])) beep:false
			
		)
	),
	
	/* When user save, if the filename change, ask the user if he wants to free the old file from his list and add the new one ############################################################################################*/
	fn SaveFile = 
	(
		-- Get the file path of the file that will be open
		file = callbacks.notificationParam()
		
		-- Check for user save and avoid Edit>Hold and Autoback 
		if file[1] == 1 then 
		(
			-- Check if save on a new file
			if _sgz._tSvn.GetRelatifPath(file[2]) != currentFile then
			(
				-- Since currentFile is still the old file, it's still possible to use NoticeFileAsUnuse() 
				NoticeFileAsUnuse() 
				NoticeFileAsUse()
			)
		)
		
	),
	
	
	/* Register callbacks ############################################################################################*/
	fn RegisterCb = 
	(
		callbacks.addScript #filePreOpenProcess "_sgz._gfxCm.UpdateFile()" id:#UpdateFileOnOpenCb											--  Update file before open it to avoid conflict
		callbacks.addScript #filePreOpen "_sgz._gfxCm.NoticeFileAsUnuse()" id:#NoticeFileAsUnuseOnOpenCb								-- Ask user if he wants to remove the current file from his list before opening a new file
		callbacks.addScript #filePostOpen "_sgz._gfxCm.NoticeFileAsUse()" id:#NoticeFileAsUseOnOpenCb									-- Ask user if he wants to add the newly open file to his list
		callbacks.addScript #filePreSaveProcess "_sgz._gfxCm.SaveFile()" id:#NewFileNameOnSaveCb				 							-- When saving, if the filename change, ask the user if he wants to free the old file from his list and add the new one
		callbacks.addScript #preSystemShutdown "_sgz._gfxCm.NoticeFileAsUnuse()" id:#NoticeFileAsUnuseShutdownCb				-- Ask user if he wants to remove the current file from his list before quiting Max
		callbacks.addScript #systemPreReset "_sgz._gfxCm.NoticeFileAsUnuse()" id:#NoticeFileAsUnuseResetCb							-- Ask user if he wants to remove the current file from his list before reset Max
		callbacks.addScript #systemPreNew "_sgz._gfxCm.NoticeFileAsUnuse()" id:#NoticeFileAsUnuseNewCb								-- Ask user if he wants to remove the current file from his list before doing a new scene
		
	),
	
	
	/* Remove callbacks  ############################################################################################*/
	fn RemoveCb = 
	(
		callbacks.removeScripts  #filePreOpenProcess id:#UpdateFileOnOpenCb
		callbacks.removeScripts  #filePreOpen id:#NoticeFileAsUnuseOnOpenCb
		callbacks.removeScripts  #filePostOpen id:#NoticeFileAsUseOnOpenCb
		callbacks.removeScripts #filePreSaveProcess id:#NewFileNameOnSaveCb		
		callbacks.removeScripts  #preSystemShutdown id:#NoticeFileAsUnuseShutdownCb
		callbacks.removeScripts  #systemPreReset id:#NoticeFileAsUnuseResetCb
		callbacks.removeScripts  #systemPreNew id:#NoticeFileAsUnuseNewCb
		
	),
	
	
	/* UI ############################################################################################*/
	fn UI = 
	(
		-- reload XML
		LoadXml()
		
		-- dialog size
		width = 50
		height = 80
		
		-- Create the ui part for a user, add the open and remove button if the user is the current one.
		fn SetUserList user width height = 
		(
			str = "\tgroup \"" + user.name + " :\"\n\t(\n"
			
			files = GetElements user
			for i = 1 to files.count do 
			(
				-- create the file name label and get it's size
				lbl = "\t\tlabel " + user.name + i as string + "Lbl \"" + (files[i].getAttribute "Path") + "\" align:#left\n"
				if width <=  (lbl.count * 4) then width = (lbl.count * 4)
				str += lbl
				
				-- Add buton for the current user part
				if user.name == currentUser then 
				(
					-- Open button
					str += "\t\tbutton " + user.name + i as string + "OpenBtn \"\" width:20 height:20 align:#right offset:[-17,-21] tooltip:\"Open file\" "
					str += "images:#((\"$sugzIcons\Folder_16i.bmp\"), (\"$sugzIcons\Folder_16a.bmp\"), 1, 1, 1, 1, 1)\n"
					str += "\t\ton "  + user.name + i as string + "OpenBtn pressed do\n\t\t(\n"
					str += "\t\t\tif checkForSave() then loadMaxFile (_sgz._tSvn.AddSvnPath \"" + (files[i].getAttribute "Path") + "\") useFileUnits:true quiet:false\n"
					str += "\t\t\t_sgz._gfxCm.UI()\n\t\t)\n\n"
					
					-- Remove Button
					str += "\t\tbutton " + user.name + i as string + "RemoveBtn \"\" width:20 height:20 align:#right offset:[5,-25] tooltip:\"Remove from list\" "
					str+= "images:#((\"$sugzIcons\Close_16i.bmp\"), (\"$sugzIcons\Close_16a.bmp\"), 1, 1, 1, 1, 1)\n"
					str += "\t\ton "  + user.name + i as string + "RemoveBtn pressed do\n\t\t(\n"
					str += "\t\t\t_sgz._gfxCm.RemoveFileAt " + (i - 1) as string + "\n"
					str += "\t\t\t_sgz._gfxCm.UI()\n\t\t)\n\n"
					
					height += 4
				)
				
				height += 18
			)
			
			str += "\t)\n\n"
			
			#(str, width, height)
			
		) -- End SetUserList()
		
		-- dialog declaration
		uiStr = "try(destroyDialog GfxCMUiRoll) catch()\nRollout GfxCMUiRoll \"Gfx Conflict Manager\"\n(\n"
		
		-- Create the ui part for every users, and update the dialog size
		users = append (_sgz._gfxCm.GetOtherUsers()) (_sgz._gfxCm.GetUser())
		for user in users do 
		(
			result = SetUserList user width height
			uiStr += result[1]
			width = result[2]
			height  = result[3]
		)
		
		-- dialog position
		uiStr += "\ton GfxCMUiRoll open do\n\t(\n\t\ttry(SetDialogPos GfxCMUiRoll (execute (getIniSetting _sgz._ini \"GfxConflictManager\" \"dialogPos\"))) catch()\n\t)\n\n"
		uiStr += "\ton GfxCMUiRoll moved pos do\n\t(\n\t\tsetIniSetting _sgz._ini \"GfxConflictManager\" \"dialogPos\" (pos as string)\n\t)\n\n"
		
		-- dialog creation
		execute (uiStr += ")\ncreateDialog GfxCMUiRoll " + (width + 30) as string + " " + height as string + " style:#(#style_titlebar, #style_sysmenu, #style_toolwindow)")
	),

	
	/* Initialize the struct ############################################################################################*/
	fn Run =
	(
		GetXmlPath()
		
		if doesFileExist xmlPath 
			then LoadXml()
			else CreateXml()
		
		RegisterCb()
		
		-- check if the open file is part of svn
		if (_sgz._tSvn.IsSvnPath MaxFilePath) then
		(
			-- Set Current file 
			currentfile = _sgz._tSvn.GetRelatifPath (MaxFilePath + MaxFileName)
		)
	),
	
	
	/* GfxConflictManager Macroscript ############################################################################################*/
	GfxConflictManagerMacroscript = 
	(
		macroScript GfxConflictManager
			Category: "SugzTools"
			toolTip:"Notice open file as use or unuse"
			Icon:#("SugzTools",3)
			
		(
			global _sgz
			
			on execute do 
			(
				if _sgz != undefined then
				(
					if _sgz._gfxCm.isFileIsNotice 
						then _sgz._gfxCm.NoticeFileAsUnuse()
						else _sgz._gfxCm.NoticeFileAsUse()
				)
			)
			
			on isChecked return if _sgz != undefined 
				then _sgz._gfxCm.isFileIsNotice 
				else false

		)
	)

) -- End Struct