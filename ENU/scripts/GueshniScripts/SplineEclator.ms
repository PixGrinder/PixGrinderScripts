new_sel =#()
for obj in selection do
(
	for la_spline = 1 to numsplines obj do
	(
		new_spline = splineshape ()
		new_spline.name = obj.name + "_" + la_spline as string
		addnewspline new_spline
		append new_sel new_spline
		nk = numknots obj la_spline
		for k = 1 to nk do
		(
			point_new = getknotpoint obj la_spline k
			addknot new_spline 1 #corner #line point_new
		)-- end for k
		updateshape new_spline 
		new_spline.steps = 0
	)
)
delete selection
for i = 1 to new_sel.count do selectmore new_sel[i]
	
for i in selection do i.pivot = i.center