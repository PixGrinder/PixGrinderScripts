 (
	for orthoObject in selection do 
(
	if isKindOf orthoObject Editable_Poly do
	(
		if (orthoObject.material != undefined and classof orthoObject.material == Multimaterial) do
		(
			local matId = polyOp.getFaceMatID orthoObject 1
			local orthoMat = getSubMtl orthoObject.material matId
			orthoObject.material = orthoMat
		)
	)
)
)