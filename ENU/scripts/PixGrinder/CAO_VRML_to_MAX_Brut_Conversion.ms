-- VRML to Max 
-- V 5.0

(
	-- DotNet Open Folder dialog --

		initPath = getDir #scene

		fn FileSelec thePath = 
		(
			theDialog = dotNetObject "System.Windows.Forms.OpenFileDialog" --create a OpenFileDialog 
			theDialog.title = "Folder selection" --set the title
			theDialog.Multiselect = false --allow multiple files to be selected
			theDialog.Filter = "VRML Files (*.wrl)|" --specify the filter
			theDialog.FilterIndex = 1 --set the filter drop-down list to All Files
			theDialog.InitialDirectory = thePath
			theDialog.FileName=""
			result = theDialog.showDialog() --display the dialog, get result into variable
			result.ToString() --when closed, convert the result to string
			result.Equals result.OK --returns TRUE if OK was pressed, FALSE otherwise
			result.Equals result.Cancel --returns TRUE if Cancel was pressed, FALSE otherwise
			theFilenames = theDialog.fileNames --the selected filenames will be returned as an array
			myPath = getFilenamePath theFilenames[1]
			return myPath
		)

	--


	fn sortBySize file1 file2=
	(
		if getFileSize file1 > getFileSize file2 then 1 else -1
	)



	fn SysUnit =
	(
		resetMaxFile #noPrompt
		units.DisplayType  = #Metric
		units.MetricType = #Millimeters
		units.SystemType = #Centimeters
		units.SystemScale = 10.0
	)


	myInput = FileSelec initPath
	files = getFiles (myInput + "*.wrl")
	qsort files sortBySize


	for i = 1 to files.count do
	(
		with redraw off
		(
			resetMaxFile #noPrompt
			SysUnit()

			importFile files[i] #noPrompt  using:VrmlImp
			delete cameras

			-- Put objects in a new layer with wrl file name -- 
				y1 = "CAO_ATA_" + getFilenameFile files[i]
				myLayer = LayerManager.newLayerFromName y1
				for obj in objects do myLayer.addnode obj
			--

			x1 = myInput+(getFilenameFile files[i])+".max" -- define max file name

			-- Maximize viewport on perspective view -- 
				viewport.setGridVisibility #all false
				viewport.setLayout #layout_4
				viewport.activeViewport = 4
				viewport.setType #view_persp_user
				disp = NitrousGraphicsManager.GetActiveViewportSetting()
				disp.VisualStyleMode = #Shaded
				disp.ShowSelectionBracketsEnabled = false
				max tool maximize

				clearSelection()
				select geometry
				max zoomext sel all
			--
		)
		clearSelection()
		forceCompleteRedraw doDisabled:true
		sleep 1

		saveMaxFile x1 useNewFile:true --quiet:<bool>
	)
)











