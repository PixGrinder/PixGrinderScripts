macroScript CleanVertex category:"- Gueshni -" Icon:#("g9_cleanvertex", 1) tooltip:"Clean Vertex"
 ( fn cleanVertices poly = 
(
	local selectList = polyOp.getVertSelection poly as array
	local removeList = #()
	
	for v in selectList do
	(
		if (poly.getVertexEdgeCount v) < 3 then
			append removeList v
	)
	
	polyOp.setVertSelection poly removeList
	poly.Remove selLevel:#Vertex
	
	local countString = removeList.count as String
	local pointString = " points enlev�s"
	
	if removeList.count < 2 then
		pointString = " point enlev�"
	if removeList.count == 0 then
		countString = "Aucun"
	
	messageBox (countString + pointString)
)

rollout mainWindow "Nettoyage de sommets"
(
	
	button runButton "Nettoyer"
	
	on runButton pressed do
	(
		if  (selection[1] != undefined and isKindOf selection[1] Editable_Poly) then
			cleanVertices selection[1]
		else
			messageBox "S�lection non valide"
	)
)

createDialog mainWindow
)