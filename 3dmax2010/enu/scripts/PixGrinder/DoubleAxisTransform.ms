-- Double Axis Transform --


rollout a "Dummy Resizer" 
(
	spinner l "XY   " pos:[20,20] width:100 height:20 range:[-1000,1000,0.0]
	spinner w "YZ   " pos:[20,50] width:100 height:20 range:[-1000,1000,0.0]
	spinner h "ZX   " pos:[20,80] width:100 height:20 range:[-1000,1000,0.0]

	on l changed state do
	(
		in coordsys local $.pos=[$.pos.x+l.value,$.pos.y+l.value,$.pos.z]
		l.value = 0.0
	)

	on w changed state do
	(
		in coordsys local $.pos=[$.pos.x,$.pos.y+w.value,$.pos.z+w.value]
		w.value = 0.0
	)

	on h changed state do
	(
		in coordsys local $.pos=[$.pos.x+h.value, $.pos.y, $.pos.z+h.value]
		h.value = 0.0
	)

	
	
)
createDialog a 150 120





/*
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
*/