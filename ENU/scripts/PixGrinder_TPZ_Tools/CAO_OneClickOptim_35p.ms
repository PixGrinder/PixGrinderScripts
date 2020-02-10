-- CAO - OneClickOptim_35p -- 

myOpt = ProOptimizer MergePoints:on MergePointsThreshold:0.1 MergeFaces:on MergeFacesAngle:0.0872665 CompactFaces:off LockPoints:off VertexPercent:35
theSmooth = Smooth autosmooth:on threshold:45.0
theSelec = for obj in selection where superClassOf obj == GeometryClass collect obj


	for obj in theSelec do 
	(
		obj.backfacecull = off
		addModifier obj myOpt			
	)

	for obj in theSelec do 
	(
		obj.modifiers[1].Calculate = on
		convertToPoly obj
	)

	for obj in theSelec do 
	(
		addModifier obj theSmooth
		convertToPoly obj
	)


