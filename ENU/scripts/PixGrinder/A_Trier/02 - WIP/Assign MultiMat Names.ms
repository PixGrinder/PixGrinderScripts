-- Assign MultiMat Names -- 

if classof meditMaterials[activeMeditSlot] == Multimaterial then
(
	myMult = meditMaterials[activeMeditSlot]

	for i = 1 to myMult.count do 
	(
		if myMult[i] != undefined then myMult.names[i] = myMult[i].name
	)

	free myMult
)


/*
updateMTLInMedit ( <material> | <texture> ) 

*/