macroScript TortoiseSvnAdd
			Category:"SugzTools" 
			toolTip:"Tortoise SVN Add" 
			Icon:#("SugzTools", 4)
		(
			on execute do 
			(
				if _sgz._tSvn != undefined then 
				(
					_sgz._tSvn.GetSvnPath()
					_sgz._tSvn.ManageSvn #add _sgz._tSvn.svnPath
				)
			)
		)
