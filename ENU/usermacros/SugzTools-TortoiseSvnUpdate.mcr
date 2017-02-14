macroScript TortoiseSvnUpdate
			Category:"SugzTools" 
			toolTip:"Tortoise SVN Update" 
			Icon:#("SugzTools",6)	
		(
			on execute do 
			(
				if _sgz._tSvn != undefined then 
				(
					_sgz._tSvn.GetSvnPath()
					_sgz._tSvn.ManageSvn #update _sgz._tSvn.svnPath
				)
			)
		)
