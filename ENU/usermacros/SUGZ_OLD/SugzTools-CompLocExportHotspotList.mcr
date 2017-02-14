macroScript CompLocExportHotspotList
			category:"SugzTools"
			toolTip:"CompLoc Export Hotspot List"
			Icon:#("Comploc",8)
		
		(
			global _cl
			on execute do 
			(
				if doesFileExist (file = "$userscripts\SugzTools\Scripts\CompLoc_Component.ms") then 
				(
					fileIn file
					_cl.ExportHotspotList()
				)
			)
		)
