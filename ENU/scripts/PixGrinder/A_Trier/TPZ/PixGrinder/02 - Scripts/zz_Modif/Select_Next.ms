(
	rollout Selector "Selector" 
	(
		radiobuttons myRad labels:#("Zoom On", "Zoom Off") default:1
	)
	createDialog Selector
	
	c = $selection as array
	max select all
	all = $selection as array
	v = findItem all c[1]
	nt = all.count
	if v+1 > nt then select all[1]  else ( 
	v=v+1
	select all[v]
	)
)