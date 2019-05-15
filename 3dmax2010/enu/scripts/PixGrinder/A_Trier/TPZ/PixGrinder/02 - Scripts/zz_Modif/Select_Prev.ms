(
	c = $selection as array
	max select all
	all = $selection as array
	v = findItem all c[1]
	nt = all.count
	if v-1 < 1 then select all[nt]  else ( 
	v=v-1
	select all[v]
	)
)