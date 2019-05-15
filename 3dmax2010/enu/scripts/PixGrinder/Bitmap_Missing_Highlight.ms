-- List Used Scene Bitmaps --

(
	clearListener()
	local mapfiles=#()
	fn addmap mapfile =
	(
		local mapfileN=mapfile as name
		local index=finditem mapfiles mapfileN
		if index == 0 do append mapfiles mapfileN
	)
	enumeratefiles addmap #missing 
	sort mapfiles
	actionMan.executeAction 0 "40472"
	for obj in mapfiles do format "%; " (filenameFromPath obj)
	ATSOps.SelectFiles mapfiles
)

