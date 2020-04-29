-- Smooth Quick -- 

if pdaTheAngle == undefined then pdaTheAngle = 80.0


try (DestroyDialog mySmoothDialog) catch()

rollout mySmoothDialog "Smooth Angle"
(
		label lbl1 "Smooth Angle :"
		spinner myAngle "" range:[1.0,180.0,pdaTheAngle] type:#float align:#center
		button myButton "Close"align:#center

		on myButton pressed do 
		(
			(DestroyDialog mySmoothDialog)
			global pdaTheAngle = mySmoothDialog.myAngle.value
		)

		on myAngle changed state do 
		(
				selection[1].autoSmoothThreshold = mySmoothDialog.myAngle.value
				selection[1].EditablePoly.autosmooth ()	
		)
)



if selection.count == 1 and subobjectlevel == 0 then 
(
	addModifier (selection[1]) (SmoothModifier autosmooth:on)
	selection[1].modifiers[1].threshold = pdaTheAngle
	update selection[1]
)


if selection.count == 1 and subobjectlevel == 4 or subobjectlevel == 5 then 
(
-- 		selection[1].autoSmoothThreshold = 80.0
		CreateDialog mySmoothDialog 250 75 1300 150
		selection[1].autoSmoothThreshold = pdaTheAngle
		selection[1].EditablePoly.autosmooth ()
)

