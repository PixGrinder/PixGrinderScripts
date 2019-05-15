for obj in selection do 
(
	myTemp = obj.parent
	obj.parent = undefined
	obj.pivot = obj.center
	ResetXForm obj
	
)


/*
select (for obj in geometry where obj.isFrozen collect obj)

*/