
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Max Scene Cleaner --
-- MaxSceneCleaner.ms --
-- CleanUp scenes before Export - Target : VMT --
-- V 1.0 --

---------------------------------------------------------------------




(
	clearListener()

	macros.run "Medit Tools" "clear_medit_slots" -- cleanup medit materials

	-- Display usefull layers (all but the ones with a name beginning with "zz")
	for i = 0 to (LayerManager.count - 1) do
	(
		myLayTemp = LayerManager.getLayer i
		if matchpattern myLayTemp.name pattern:"zz*" == true then myLayTemp.on = false else myLayTemp.on = true
	)

	x1 = for obj in objects where matchpattern obj.name pattern:"*ParticleView*" == true collect obj
	if x1.count > 1 then delete x1

	Include "$userScripts/PixGrinder/CleanLayers_v2.ms"

	Include "$userScripts/PixGrinder_TPZ_Tools/BitmapPath_AH.ms"

)

x1 = LayerManager.getLayerFromName "NG_Structure_adelete"

x1.parent

