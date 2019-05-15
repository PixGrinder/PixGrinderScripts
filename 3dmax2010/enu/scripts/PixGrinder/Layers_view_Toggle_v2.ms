----------------------
-- Layers Toggle --
-- v3.0 --
----------------------

(
	undo off
	(
		clearListener()
		myCondition = false
		nb = (layermanager.count)-1
		disableSceneRedraw()

		fn recurseLay v1= 
		(
			v1.on=false
			if v1.getNumChildren() > 0 then for tp = 1 to v1.getNumChildren() do (v1.getChild tp).on = false
			for i = 1 to v1.getNumChildren() do recurseLay (v1.getChild i)
		)

		fn layerOn = 
		(
			for i = 0 to nb do (layermanager.getlayer i).on = true
			for i = 0 to nb where matchpattern (layermanager.getlayer i).name pattern:"zz*" do recurseLay (layermanager.getlayer i)
		)
	
		fn layerOff = 
		(
			for i = 0 to nb do (layermanager.getlayer i).on = false
		)
	
	
		for i = 0 to nb do 
		(
			if (layermanager.getlayer i).on == true do myCondition = true
		)
	
	
		if myCondition == false then layerOn() else layerOff()

		enableSceneRedraw()
		forceCompleteRedraw doDisabled:true
	)
)
