
-- ReSave folder.ms --

(
	
	----------------------------------------------------------------------
	-- TPZ Specific
		callbacks.removeScripts #filePreOpenProcess id:#UpdateFileOnOpenCb
	-- TPZ Specific
	----------------------------------------------------------------------


	thePath = getSavePath  initialDir:(GetDir #scene)
	files = getFiles (thePath+"\\"+"*.max")
	for obj in files do
	(
		loadMaxFile obj useFileUnits:true quiet:true
		viewport.setLayout #layout_4
		viewport.activeViewport = 4
		max tool maximize
		clearSelection()
		select geometry[1]
		max zoomext sel all
		select geometry
		max zoomext sel all
		clearSelection()
		forceCompleteRedraw doDisabled:true
		-- sleep 1
		saveMaxFile obj useNewFile:true quiet:true
	)
	

	----------------------------------------------------------------------
	-- TPZ Specific
		callbacks.addScript #filePreOpenProcess fileName:"$userScripts/PixGrinder/SVN_FileUpdate_Callback.ms" id:#UpdateFileOnOpenCb
	-- TPZ Specific
	----------------------------------------------------------------------



	messageBox("Process finished !")
)
