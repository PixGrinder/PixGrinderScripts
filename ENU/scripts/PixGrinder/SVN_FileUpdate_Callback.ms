(
	fn UpdateFile = 
	(
		-- Get the file path of the file that will be open
		file = callbacks.notificationParam()
		
		-- Check if it's a file related to the project then update it via tortoise SVN before opening it
		if _sgz._tSvn.IsSvnPath(file[2]) then 
		(
			_sgz._tSvn.ManageSvn #update (file[2])
			messageBox "\t\tPress \"OK\" when you have finish the update\t\t\t\t\t" title:(_sgz._tSvn.GetRelatifPath (getFilenamePath file[2] + filenameFromPath file[2])) beep:false
			
		)
	)


	UpdateFile()
)