macroScript SugzToolsUI
				Category:"SugzTools" 
				toolTip:"Run SugzTools and load the MainView" 
				Icon:#("SugzTools", 1)
			(
				global _sgz
				on execute do 
				(
					if SgzRoll != undefined and SgzRoll.open then
					(
						cui.UnRegisterDialogBar SgzRoll 
						destroyDialog SgzRoll
						SgzRoll = undefined
					)
					else 
					(
						if doesFileExist "$userScripts\SugzTools\Managers\SugzTools_Manager.ms" do fileIn "$userScripts\SugzTools\Managers\SugzTools_Manager.ms"
						if _sgz != undefined then _sgz.MainView()
					)
					
				)
				
				on isChecked return if SgzRoll != undefined and SgzRoll.open 
					then true
					else false
			)
