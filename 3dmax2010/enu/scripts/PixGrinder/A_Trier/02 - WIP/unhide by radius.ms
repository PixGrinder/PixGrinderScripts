-- unhide by radius --



if selection.count !=0 then 
(
	x1 = selection as array
	clearSelection()
	max hide inv
	for obj in x1 do obj.isHidden = false
	select x1
	rollout youpla "Youpla"
	(
		spinner myDist "blalva" range:[0.01,(distance $.min $.max)*10.0,(distance $.min $.max)] type:#float scale:((distance $.min $.max)/10.0) fieldWidth:100

		on myDist changed state do 
		(
			for obj in objects do
			(
				if (distance $.center obj.center) < myDist.value then obj.isHidden = false else obj.isHidden = true
			)
		)
	)

	--for obj in objects where (distance selection[1].center obj.center) < 500.0 do obj.isHidden = false
	createDialog youpla
)
