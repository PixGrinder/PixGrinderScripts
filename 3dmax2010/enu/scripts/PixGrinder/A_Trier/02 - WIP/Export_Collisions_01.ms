
-- Export Collisions !!!
--527


(
	if maxFileName == undefined then messagebox "The scene must be saved on disk !" else
	(

		--global exp_path = getSavePath caption:"Export Files To : " initialDir:"c:"
		
		fn l_on =
		(
			local i = 1
			local lxi = 1
			for i = 0 to layermanager.count-1 do (
				lxi  = layermanager.getLayer i
				lxi.on = true
			)
		)
		
		
		
		rollout mywarning "Export Collisions"
		(
			label txt3 "" pos:[50,10] style_sunkenedge:true width:150 height:45
			label txt1 "Do you want to" pos:[90,15]
			label txt2 "backup the current scene ?"
			radiobuttons copy_type labels:#("Yes", "No") pos:[90,65] default:2
			button mybutton "OK" width:100 pos:[75,90]
			
			on mybutton pressed do
			(
				if copy_type.state == 1 then 
				(
					-- Backup = True --
					pda_cur = MaxFilePath+MaxFileName
					fnm = replace MaxFileName (MaxFileName.count-3) 4 "_backup.max"
					saveMaxFile ( MaxFilePath + fnm)
					pda = #()
					for obj in objects do
					(
						if findstring obj.name "col_" != undefined do append pda obj
						if findstring obj.name "track_active_" != undefined do append pda obj
					)
					pda_temp = (MaxFilePath+"collision_temp.max")
					saveNodes pda pda_temp
					LoadMaxFile pda_temp
					l_on()
					max unhide all
					max file export
					deletefile pda_temp
					LoadMaxFile pda_cur
					--exportFile(getSavePath caption:"Export Files To : " initialDir:"c:") -- using:REDFileExporter
					-- exporterPlugin.classes
					destroyDialog mywarning
					
				) else  (
					-- Backup = False --
					pda_cur = MaxFilePath+MaxFileName
					pda = #()
					for obj in objects do
					(
						if findstring obj.name "col_" != undefined do append pda obj
						if findstring obj.name "track_active_" != undefined do append pda obj
					)
					pda_temp = (MaxFilePath+"collision_temp.max")
					saveNodes pda pda_temp
					LoadMaxFile pda_temp
					l_on()
					max unhide all
					max file export
					deletefile pda_temp
					LoadMaxFile pda_cur
					destroyDialog mywarning
				)
			)
			
		)

		createDialog mywarning width:250 height:125
		setFocus mywarning.mybutton
	)
)