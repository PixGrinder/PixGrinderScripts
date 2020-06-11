-- ProBoolean Quick -- 

(
	myTempObj = selection[1]
	ProBoolean.CreateBooleanObjects selection[1] #() 2 2 0
	select myTempObj
	myOp = pickObject()
	ProBoolean.SetBoolOp myTempObj 2
	ProBoolean.SetOperandB myTempObj myOp 2 0
	-- ProBoolean.SetImprint myTempObj false
	ProBoolean.SetPlanarEdgeRemoval myTempObj 2
	addModifier myTempObj (Turn_to_Poly ())
	collapseStack myTempObj
)

