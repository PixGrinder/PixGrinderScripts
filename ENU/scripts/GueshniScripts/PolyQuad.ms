(
try(destroyDialog PolyQuad)catch()

rollout PolyQuad "PolyQuad" 
(
	button go "Go PolyQuad" width:140
	
	on go pressed do
	(
		total = selection.count
		mySelection = selection as array
		for i = 1 to total do
		(
			myElement = selection[i]
			convertTo myElement Editable_Poly
			select myElement
			PolyToolsModeling.Quadrify false false
			select mySelection
		)
	)
)
createDialog PolyQuad width:180 pos:[1700,220] bgcolor:(color 84 101 120)
)