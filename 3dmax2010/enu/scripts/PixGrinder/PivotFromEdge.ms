-- PivotFromEdge -- 

myEdgeknots = polyop.getEdgeVerts $ (((getEdgeSelection $) as array)[1])

myVertCoord =#()

mySelectedVerts = #()

for obj in myEdgeknots do append mySelectedVerts (polyop.getVert $ obj)

$.pivot = mySelectedVerts[1]
$.pidir = 