-- Select NextObject


(
	all = #()
	
	c = selection[1]-- current selection
	for obj in objects do
	(
		if obj.ishidden == false do append all obj
	)
	v = findItem all c
	if v+1 >all.count then select all[1]  else ( 
	v=v+1
	select all[v]
	viewport.setType #view_persp_user
	max zoomext sel
	)
)

