-- GetVertexBound

(
mySnap = snapshot selection[1]
allVerts = (for i = 1 to (getNumVerts mySnap) collect i) as bitArray
ToRemoveNow = allVerts - getVertSelection mySnap
meshop.deleteVerts mySnap ToRemoveNow
distance mySnap.min mySnap.max
delete mySnap
)