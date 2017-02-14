macroScript TortoiseSvnCommit
			Category:"SugzTools" 
			toolTip:"Tortoise SVN Commit" 
			Icon:#("SugzTools",5)
		(
			on execute do 
			(
				if _sgz._tSvn != undefined then 
				(
					_sgz._tSvn.GetSvnPath()
					_sgz._tSvn.ManageSvn #commit _sgz._tSvn.svnPath
				)
			)
		)
