macroScript CompLocCleanScene
			category:"SugzTools"
			toolTip:"CompLoc Clean Scene"
			Icon:#("Comploc",5)
		
		(
			global _cl
			on execute do 
			(
				if doesFileExist (file = "$userscripts\SugzTools\Scripts\CompLoc_Component.ms") then 
				(
					fileIn file
					_cl.CleanScene()
				)
			)
		)
