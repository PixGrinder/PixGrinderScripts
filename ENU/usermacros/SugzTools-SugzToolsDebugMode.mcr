macroScript SugzToolsDebugMode
				Category:"SugzTools" 
				toolTip:"Toggle the SugzTools debug mode" 
				Icon:#("Maxscript", 2)
			(
				global _sgz
				on execute do 
				(
					if _sgz == undefined then fileIn "$userScripts\Startup\SugzTools_Startup.ms"
					_sgz.debug = not _sgz.debug
				)
				
				on isChecked return if _sgz != undefined then _sgz.debug
			)
