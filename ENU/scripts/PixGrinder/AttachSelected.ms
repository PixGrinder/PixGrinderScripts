-- Attach Selected --
-- PixGrinder --


(
	theSelec = for obj in selection where superclassof obj == GeometryClass collect obj
	if theSelec.count < 2 then messageBox ("Select at least 2 geometry objects !") 
	(
		theSelec[1].parent = undefined
		resetXForm theSelec[1]
		convertToPoly theSelec[1]
		select theSelec[1]
		for i = 2 to theSelec.count do
		(
			convertToPoly theSelec[i]
			x1 = polyOp.attach theSelec[1] theSelec[i]
		)
		select theSelec[1]
	)
)