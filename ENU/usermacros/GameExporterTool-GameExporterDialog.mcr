macroScript GameExporterDialog
	category: "GameExporterTool"
	tooltip: "Open Dialog"
	(
		on execute do
		(
			if GameExporterOpenDialog != undefined then
			(
				GameExporterOpenDialog 0
			)
		)
		on isChecked return
		(
			if GameExporterShown != undefined then
			(
				if GameExporterShown()==true then true
				else false
			)
			else 
			(
				false
			)
		)
	)
