(
	max move
	-- (
-- 		if not mateditor.IsOpen() do MatEditor.Open()
  -- )
	(
	if not sceneexplorermanager.ExplorerExists "Layer Explorer" do SceneExplorerManager.CreateExplorerFromDefault "Layer Explorer"
	SceneExplorerManager.CloseExplorer "Layer Explorer"
	)
	SceneExplorerManager.ConfigureExplorer "Layer Explorer" "C:\Users\guest1219\AppData\Local\Autodesk\3dsMax\2016 - 64bit\ENU\en-US\plugcfg\ExplorerConfig\SceneExplorer\GueshniExplorer.ini"
	SceneExplorerManager.SetExplorerSize "Layer Explorer" [450,850]
	SceneExplorerManager.OpenExplorer "Layer Explorer"
	SceneExplorerManager.SetExplorerPosition "Layer Explorer" [3650,5]
)