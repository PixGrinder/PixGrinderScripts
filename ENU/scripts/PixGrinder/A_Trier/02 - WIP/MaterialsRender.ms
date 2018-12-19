-- Materials Render --

x1 = getClassInstances StandardMaterial

$.material = x1[1]

myMap = bitmap 256 256 the_bmp filename:("D:/Work/AS365CompLoc/Thumbs/"+x1[1].name+".png")
render to:myMap vfb:true
save myMap
close myMap

