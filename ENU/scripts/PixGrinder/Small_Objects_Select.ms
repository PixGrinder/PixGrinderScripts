
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Small Objects Selection --
-- Small_Objects_Select.ms --
-- Selects small objects within a threashold --
-- V 2.0  --
-- Interface Rollout Added --

---------------------------------------------------------------------



(
	clearListener()
	
	fn selectSmallObj scope tresh =
	(
		pda = for obj in scope where (distance obj.min obj.max) <= tresh collect obj
		select pda
	)

	rollout pda_MyRollout "Select Small Objects"
	(
		label theTitle "Select Small Objects"
		offset:[0,10]
		label theFunc "Threshold : "
		edittext theTreshold "" text:"0.4" 
		label theType "Type :"
		radiobuttons myRad "" labels:#("Selection","All Objects") default:1 columns:2
		button myOK "OK" width:75

		on myOK pressed do
		(
			if myRad.state == 1 then selectSmallObj (selection as array) (theTreshold.text as float) else selectSmallObj (geometry as array) (theTreshold.text as float)
		)

		on theTreshold entered bla do 
		(
			if (theTreshold.text as float) == undefined then theTreshold.text = "0.4"
		)

	)

	try(destroyDialog pda_MyRollout) catch()
	createDialog pda_MyRollout 250 150 150 150

)


--       distance $.min $.max
--      "youpla" as float

