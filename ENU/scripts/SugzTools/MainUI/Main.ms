try (
	-- Unregistered and destroy dialog if it already exists
	cui.UnRegisterDialogBar SgzRoll 
	destroyDialog SgzRoll
) catch()


rollout SgzRoll "SugzTools" width:200 height:830
(
	subrollout SubRoll "" width:200 height:830
	
	
	-- Set Position
	on SgzRoll open do try(SetDialogPos SgzRoll (execute (getIniSetting _sgz._ini "MainUi" "dialogPos"))) catch()
	on SgzRoll moved pos do setIniSetting _sgz._ini "MainUi" "dialogPos" (pos as string)
		
		
	rollout AutoSaveRoll "AutoSave"
	(
		include "$sugzTools\AutoSave\AutoSave.ms"
	)

	rollout ModelingRoll "Modeling"
	(
		include "$sugzTools\MainUI\Modeling.ms"
	)

	rollout SelectionRoll "Selection"
	(
		include "$sugzTools\MainUI\Selection.ms"
	)

	rollout DetachRoll "Detach" rolledup:true
	(
		include "$sugzTools\MainUI\Detach.ms"	
	)

	rollout OptionsRoll "Options" rolledup:true
	(
		include "$sugzTools\MainUI\MainOptions.ms"	
	)

)


createDialog SgzRoll
AddSubRollout SgzRoll.SubRoll SgzRoll.ModelingRoll
AddSubRollout SgzRoll.SubRoll SgzRoll.SelectionRoll
AddSubRollout SgzRoll.SubRoll SgzRoll.DetachRoll
AddSubRollout SgzRoll.SubRoll (_sgz._tmFlags.GetView()) 		-- Node Transform Flags
AddSubRollout SgzRoll.SubRoll (_sgz._gfxCm.GetView())
AddSubRollout SgzRoll.SubRoll SgzRoll.OptionsRoll

SgzRoll.SubRoll.pos = [0,0] -- Set the subrollout pos inside the rollout
cui.RegisterDialogBar SgzRoll minSize:[205,840]		-- register the dialog

-- Set the dock state
case execute (getIniSetting _sgz._ini "MainUi" "dockState") of 
(
	2: cui.DockDialogBar SgzRoll #cui_dock_left
	3: cui.DockDialogBar SgzRoll #cui_dock_right
)

