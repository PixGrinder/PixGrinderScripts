
rollout a "Dummy Resizer" 
(
	button Dum "Create Dummy" pos:[10,5] width:120 height:20
	spinner l "Length" pos:[20,35] width:100 height:20 range:[-1000000,1000000,10]
	spinner w "Width" pos:[20,65] width:100 height:20 range:[-1000000,1000000,10]
	spinner h "Height" pos:[20,95] width:100 height:20 range:[-1000000,1000000,10]
	
	on Dum pressed do
	(
	Dummy pos:[0,0,0] isSelected:on boxsize:[10, 10,10]
		
	)
	
	
	

		on l changed state do
		(
			$.boxsize=[l.value, w.value, h.value]
		)
	
		on w changed state do
		(
			$.boxsize=[l.value, w.value, h.value]
		)
	
		on h changed state do
		(
			$.boxsize=[l.value, w.value, h.value]
		)

	
	
)
createDialog a 150 120