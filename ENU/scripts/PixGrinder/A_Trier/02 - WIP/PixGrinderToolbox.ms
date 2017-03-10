(



	rollout imaj ""
	(
	bitmap the_bmp fileName:"$userIcons/ImageBG.jpg"
		
	)								-- end rollout IMAGE


	rollout systm "System"
	(
		button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("$userIcons/PixGrinder_24i.bmp", undefined, 4,1,1,1,1) tooltip:"ResetXForm"
		on btn1 pressed do macros.run "-- PixGrinder --" "ResetXForm"
	)								-- end rollout SYSTEM





	if pixGrindWindow != undefined do closerolloutfloater toolG9wind
  

	pixGrindWindow = newRolloutFloater "PixGrinder Tools" 320 950 1000 5
	addRollout imaj pixGrindWindow 
	addRollout systm pixGrindWindow 
-- 	addRollout ui pixGrindWindow
-- 	addRollout pivo pixGrindWindow
-- 	addRollout clection pixGrindWindow rolledup: on
			
)					--end macro



