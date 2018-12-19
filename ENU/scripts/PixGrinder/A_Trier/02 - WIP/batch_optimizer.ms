-- batch_optimizer.ms
myMod = ProOptimizer()
myMod.VertexPercent = 35

for obj in selection where superclassof obj == GeometryClass do
(
	addModifier obj myMod
-- 	obj.modifers[1].VertexPercent = 0.35
	myMod.Calculate = on
	convertToPoly obj

)