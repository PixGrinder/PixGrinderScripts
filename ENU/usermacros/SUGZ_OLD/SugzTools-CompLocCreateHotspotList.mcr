macroScript CompLocCreateHotspotList
			category:"SugzTools"
			toolTip:"CompLoc Create Hotspot List"
			Icon:#("Comploc",7)
		
		(
			global _cl
			on execute do 
			(
				if doesFileExist (file = "$userscripts\SugzTools\Scripts\CompLoc_Component.ms") then 
				(
					fileIn file
					_cl.CreateHotspotList()
				)
			)
		)
