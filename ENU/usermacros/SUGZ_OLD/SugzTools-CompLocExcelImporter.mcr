macroScript CompLocExcelImporter
			category:"SugzTools"
			toolTip:"CompLoc Excel Importer"
			Icon:#("Comploc",4)
		
		(
			global _cl
			on execute do 
			(
				if doesFileExist (file = "$userscripts\SugzTools\Scripts\CompLoc_Component.ms") then 
				(
					fileIn file
					_cl.ExcelImport()
				)
			)
		)
