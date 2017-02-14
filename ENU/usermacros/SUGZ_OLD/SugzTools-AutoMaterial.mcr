macroScript AutoMaterial
			category:"SugzTools"
			toolTip:"Open the AutoMaterial Dialog"
			Icon:#("SugzTools",7)
		(
			global _sgz
			on execute do 
			(
				if _sgz != undefined then _sgz._autoMtl.Run()
				else 
				(
					fileIn "$userScripts\Startup\SugzTools_Startup.ms"
					_sgz._autoMtl.Run()
				)
			)
			
		)
