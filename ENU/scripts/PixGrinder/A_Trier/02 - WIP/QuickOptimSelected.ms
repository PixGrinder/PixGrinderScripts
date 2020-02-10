-- CAO_Optim_35 --
-----------------------

(
	myOpt = ProOptimizer MergePoints:on MergePointsThreshold:0.1 MergeFaces:on MergeFacesAngle:0.0872665 CompactFaces:off LockPoints:off VertexPercent:35

	mySel = for obj in selection where superclassof obj == GeometryClass collect obj

	for obj in mySel do 
	(
		--resetXForm obj
		addModifier obj myOpt
		obj.backfacecull = off
	)

	for obj in mySel do 
	(
		obj.modifiers[1].Calculate = on
		convertToPoly obj
	)
)

/*
mySel = selection as array
for obj in mySel do
(
	clearSelection()
	select obj
	(Include "$userScripts/PixGrinder_TPZ_Tools/CAO_OneClickProcess.ms")
)

mySel = selection as array
for obj in mySel do
(
	clearSelection()
	select obj
	(Include "$userScripts/PixGrinder_TPZ_Tools/CAO_OneClickProcess.ms")
)


*/