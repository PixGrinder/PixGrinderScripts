 -- Shader TroubleShoot --

 myAr = #()
 for obj in geometry do appendifUnique myAr (classof obj.material)
 clearListener()
 myAr

 clearSelection()
 select (for obj in geometry where classof obj.material == UndefinedClass collect obj)