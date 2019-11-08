-- CAO - OneClickProcess -- 

if superclassof selection[1] == GeometryClass then 
(
	theWeld = Vertex_Weld ()
	theWeld.threshold = 0.0001
	theSmooth = Smooth()
	theSmooth.autosmooth = on
	theSmooth.threshold = 45

	addModifier selection[1] theWeld
	addModifier selection[1] theSmooth

	convertToPoly selection[1]
	/*
	ResetXForm selection[1]
	collapseStack selection[1]
	*/
)

----------------------------
/*
	theWeld = Vertex_Weld ()
	theWeld.threshold = 0.0001
	theSmooth = Smooth()
	theSmooth.autosmooth = on
	theSmooth.threshold = 45


for obj in geometry do
(
	addModifier obj theWeld
	addModifier obj theSmooth

	convertToPoly obj

)

*/