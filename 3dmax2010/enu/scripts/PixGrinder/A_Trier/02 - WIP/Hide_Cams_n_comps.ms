for obj in cameras do 
(
	if superclassof obj == camera then
	(
		try
		(
			hide obj
			hide obj.parent
		) catch ()
	)
)