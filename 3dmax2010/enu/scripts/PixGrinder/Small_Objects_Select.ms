
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Small Objects Selection --
-- Small_Objects_Select.ms --
-- Selects small objects within a threashold --
-- V 2.1  --
-- Interface Rollout Added --
-- edittext replaced by spinner --

---------------------------------------------------------------------



(
	global pda_MyRollout
	clearListener()
	
	fn selectSmallObj scope tresh =
	(
		pda = for obj in scope where (distance obj.min obj.max) <= tresh collect obj
		select pda
	)

	rollout pda_MyRollout "Select Small Objects"
	(
		label theTitle "--    Select Small Objects    --" offset:[0,10]
		label theFunc "Threshold : " offset:[0,15]
		spinner theTreshold "" range:[0.0,100000.0,0.4] type:#float scale:0.1 fieldWidth:75 align:#center
		button chkSel "CheckCurrent" width:75 offset:[0,10]
		label theType "Type :" offset:[0,10]
		radiobuttons myRad "" labels:#("Selection","All Objects") default:2 columns:2
		button myOK "OK" width:75 offset:[0,10]

		on myOK pressed do
		(
			clearSelection()
			if myRad.state == 1 then selectSmallObj (selection as array) theTreshold.value else selectSmallObj (geometry as array) theTreshold.value
			--destroyDialog pda_MyRollout
		)

		on chkSel pressed do if selection.count >0 do theTreshold.value = (distance selection[1].max selection[1].min)


	)

	try(destroyDialog pda_MyRollout) catch()
	createDialog pda_MyRollout 250 250 150 150 bgcolor:(color 70 75 75)

)

