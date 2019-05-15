(



	rollout imaj ""
	(
	bitmap the_bmp fileName:"$userIcons/ImageBG.jpg"
		
	)								-- end rollout IMAGE


	rollout systm "System"
	(
		button btn1 "" width:30 height:30 pos:[10,10] across:1  images:#("Splines_24i.bmp", undefined, 11, 11, 1,1,1) tooltip:"CableRetopology"
		
		on btn1 pressed do macros.run "-- PixGrinder --" "CableRetopology"
	)								-- end rollout SYSTEM





	if pixGrindWindow != undefined do closerolloutfloater pixGrindWindow
  

	global pixGrindWindow = newRolloutFloater "PixGrinder Tools" 320 950 1000 5
	addRollout imaj pixGrindWindow 
	addRollout systm pixGrindWindow 
-- 	addRollout ui pixGrindWindow
-- 	addRollout pivo pixGrindWindow
-- 	addRollout clection pixGrindWindow rolledup: on
			
)					--end macro



