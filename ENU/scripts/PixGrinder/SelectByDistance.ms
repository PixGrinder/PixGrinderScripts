-- SelectNearObjects --

myTab = for obj in geometry collect #(distance selection.center obj.center,obj)

rollout selectByDistance "SelectByDistance"
(
	label lbl1 "Select by Distance"
	spinner spn1 range:[0.0,1000.0,1.0] type:#float scale:0.1
	button btnUpdate "Update"

	on spn1 changed value do 
	(
		select (for obj in myTab where obj[1] < spn1.value collect obj[2])
	)

	on btnUpdate pressed do myTab = for obj in geometry collect #(distance selection.center obj.center,obj)

)


createDialog selectByDistance

/*
myVal = 1.0

x1 = Selection.center

select (for obj in geometry where (distance obj.center x1) < myVal collect obj)

*/