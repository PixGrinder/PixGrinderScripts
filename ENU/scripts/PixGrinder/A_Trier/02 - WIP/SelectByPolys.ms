-- Select by Polys -- 

clearSelection()
select (for obj in geometry where classof obj == Editable_Poly or classOf obj == Editable_mesh and (getNumFaces obj) > 10000 collect obj)

/*
select (getNodeByName "ATA_52-30_AntiBurst_HOLE_LH")
*/