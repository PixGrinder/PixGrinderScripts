if selection.count != 0 then 
(
	myBox = box width:((abs(selection[1].max.x - selection[1].min.x)) as float) length:((abs(selection[1].max.y - selection[1].min.y)) as float) height:((abs(selection[1].max.z - selection[1].min.z)as float)) name:(selection[1].name+"_box") mapcoords:true
	myBox.pivot = myBox.center
	myBox.pos = selection[1].pos
) 



/*

select (for obj in geometry where obj.material == undefined collect obj)

*/