-- CL hide collisions --

mySel = selection as array
clearSelection()
select (for obj in geometry where (matchpattern obj.name pattern:"*_CollisionMesh*") or (matchpattern obj.name pattern:"*_Volume*") collect obj)
max hide selection
select mySel

