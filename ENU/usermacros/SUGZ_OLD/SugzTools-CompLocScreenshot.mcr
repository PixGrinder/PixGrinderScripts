macroScript CompLocScreenshot
			category:"SugzTools"
			toolTip:"CompLoc ScreenShot"
			Icon:#("Comploc",6)
		
		(
			global _cl
			on execute do 
			(
				if doesFileExist (file = "$userscripts\SugzTools\Scripts\CompLoc_Component.ms") then 
				(
					fileIn file
					_cl.MakeScreenshot()
				)
			)
		)
