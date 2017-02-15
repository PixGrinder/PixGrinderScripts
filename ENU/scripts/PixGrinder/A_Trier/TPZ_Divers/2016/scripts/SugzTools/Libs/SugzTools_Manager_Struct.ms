/*##############################################################################
SugzTools Manager Struct
Version 1.1
Script By Clément "Sugz" Plantec
plantec.clement@gmail.com

#Required Components:
None

#Script infos:
Install and load SugzTools scripts

*Use / Modify this script at your own risk !*
###############################################################################*/



global _sgz
(
	struct SugzToolsStruct
	(
		/* INI file and Structs ############################################################################################*/
		_ini,							-- Ini file
		_extMax,					-- Extend Max struct instance
		_mod,						-- Modeling struct instance
		_sel,						-- Selection struct instance
		_iniMan, 					-- Ini Manager struct
		_tSvn,						-- Tortoise SVN Struct
		_gfxCm,					-- Gfx Conflict Manager Struct

		macroIconsCount = 5,				-- Number of icons in the strip

		/* User Paths ############################################################################################*/
		-- Create symbolic user path and directories
		fn SetUserPaths =
		(
			-- Create symbolic user path
			if not (symbolicPaths.isUserPathName "$sugzTools") then 
				symbolicPaths.addUserPath "$sugzTools" (symbolicPaths.getPathValue "$userscripts" + "\\SugzTools")

			if not (symbolicPaths.isUserPathName "$sugzIcons") then 
				symbolicPaths.addUserPath "$sugzIcons" (symbolicPaths.getPathValue "$usericons" + "\\SugzTools")
				
			-- Create directories
			if not (doesFileExist "$sugzTools") then makeDir "$sugzTools"
			if not (doesFileExist "$sugzIcons") then makeDir "$sugzIcons"
			
		),
		
		-- Remove symbolic user path and directories
		fn RemoveUserPaths directories:false = 
		(
			if directories then 
			(
				_extMax.DeleteFolder (symbolicPaths.getUserPathValue "$sugzTools" )
				_extMax.DeleteFolder (symbolicPaths.getUserPathValue "$sugzIcons" )
			)
			
			if (symbolicPaths.isUserPathName "$sugzTools") then symbolicPaths.removeUserPath "$sugzTools"
			if (symbolicPaths.isUserPathName "$sugzIcons") then symbolicPaths.removeUserPath "$sugzIcons"
			
		),


		/* Structs ############################################################################################*/
		fn DefineStructs = 
		(
				if doesFileExist "$userscripts\SugzTools\Libs\Extend_Max_Struct.ms" do include "$userscripts\SugzTools\Libs\Extend_Max_Struct.ms"										-- Extend Max struct
				_extMax = ExtendMaxStruct()
				if doesFileExist "$userscripts\SugzTools\Libs\Modeling_Struct.ms" do include "$userscripts\SugzTools\Libs\Modeling_Struct.ms"													-- Modeling struct
				_mod = ModelingStruct()
				if doesFileExist "$userscripts\SugzTools\Libs\Selection_Struct.ms" do include "$userscripts\SugzTools\Libs\Selection_Struct.ms"			 										-- Selection struct
				_sel = SelectionStruct()
				if doesFileExist "$userscripts\SugzTools\Libs\Ini_Manager_Struct.ms" do include "$userscripts\SugzTools\Libs\Ini_Manager_Struct.ms"										-- Ini Manager struct
				_iniMan = IniManagerStruct()
				if doesFileExist "$userscripts\SugzTools\Libs\Tortoise_Svn_Struct.ms" do include "$userscripts\SugzTools\Libs\Tortoise_Svn_Struct.ms"									-- Tortoise SVN struct
				_tSvn = TortoiseSvnStruct()
				if doesFileExist "$userscripts\SugzTools\Libs\GfxConflictManager_Struct.ms" do include "$userscripts\SugzTools\Libs\GfxConflictManager_Struct.ms"				-- Gfx Conflict Manager Struct
				_gfxCm = GfxConflictManagerStruct()
		),
		
		
		/* Ini File  ############################################################################################*/
		fn SetIni =
		(
			-- get user document folder
			sysEnv = dotNetClass "System.Environment"
			speFolder = dotNetClass "System.Environment+specialFolder"
			_ini = (sysEnv.GetFolderPath speFolder.myDocuments) + @"\3dsMax\SugzTools\SugzTools.ini"
			
			-- If the ini doesn't exit, create directory and ini
			if not (doesFileExist _ini) then 
			(
				makeDir ((sysEnv.GetFolderPath speFolder.myDocuments) + @"\3dsMax\SugzTools")
				_iniMan.CreateIniFn()
			)
		),
		
		
		/* UI ############################################################################################*/
		fn MainUi = 
		(
			if doesFileExist "$sugzTools\MainUI\Main.ms" do fileIn "$sugzTools\MainUI\Main.ms"
		),
		
		
		/* Macroscripts ############################################################################################*/
		fn InstallMacros = 
		(
			for macro in (getFiles "$sugzTools\Macroscripts\*") do fileIn macro
		),
		
		
		/* Startup  ############################################################################################*/
		fn StartupScripts =
		(
			
			
			-- AutoSave toolbar
			if execute (getIniSetting _sgz._ini "AutoSave" "toolbar") and doesFileExist "$sugzTools\AutoSave\AutoSave_Toolbar.ms" do fileIn "$sugzTools\AutoSave\AutoSave_Toolbar.ms"
			
		),
		
		
		/* Initialize SugzTools ############################################################################################*/
		fn SugzTools = 
		(
			exitCode = 0
			try (SetUserPaths()) catch(exitCode = "SetUserPaths() raised an issue...")
			try (DefineStructs()) catch(exitCode = "DefineStructs() raised an issue...")
			try (SetIni()) catch(exitCode = "SetIni() raised an issue...\n")
			try (InstallMacros()) catch(exitCode = "InstallMacros() raised an issue...")
			try (StartupScripts()) catch(exitCode = "StartupScripts() raised an issue...")
				
			if exitCode == 0 then
			(
				_tSvn.GetSvnPath()
				_gfxCm.Run()
				if execute (getIniSetting _sgz._ini "MainUi" "startup") then MainUI() 						-- Main UI
				format "SugzTools succesfully loaded :)\n"
			)
			
			else format "%\nSugzTools failed to load :(\n" exitCode
		),

		/* Macroscript ############################################################################################*/
		SugzToolsUI = 
		(
			macroScript SugzToolsUI 
				Category:"SugzTools" 
				toolTip:"SugzTools UI" 
				Icon:#("SugzTools", 1)
			(
				global _sgz
				on execute do 
				(
					if SgzRoll != undefined and SgzRoll.open then
					(
						cui.UnRegisterDialogBar SgzRoll 
						destroyDialog SgzRoll
					)
					else 
					(
						if doesFileExist "$userscripts\SugzTools\Libs\SugzTools_Manager_Struct.ms" do fileIn "$userscripts\SugzTools\Libs\SugzTools_Manager_Struct.ms"	
						if _sgz != undefined then _sgz.MainUi()
					)
					
				)
				
				on isChecked return if SgzRoll != undefined and SgzRoll.open 
					then true
					else false
			)
		)
		
		
	)-- End Struct


	_sgz = SugzToolsStruct()
	_sgz.SugzTools()

)







