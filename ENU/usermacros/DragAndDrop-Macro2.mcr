macroScript Macro2
	category:"DragAndDrop"
	toolTip:""
(
	(
		myAr = polyop.getFaceSelection $
		polyop.detachFaces $ myAr asnode:true
		max hide inv
	)
)
