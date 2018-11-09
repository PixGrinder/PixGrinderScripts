clearListener()

fn wldSpine tr1= 
(
	max select all
	updateshape $
	weldSpline $ tr1
	updateshape $
)

fn sortKnot v1 v2= 
(
	if v1[2] < v2[2] then 1 else -1
)

max modify mode
updateshape $
subobjectlevel = 1

knotSplines = #()

if (numsplines $) == 1 then 
(
	knotSplines = #(#(1, (getKnotSelection $ 1)[1]),#(1, (getKnotSelection $ 1)[2])) 
	qsort knotSplines sortKnot
) else (
	for i = 1 to (numSplines $) do 
	(
		if ((getKnotSelection $ i)[1] != undefined) then append knotSplines (#(i, (getKnotSelection $ i)[1]))
	)
)


--knotSplines

if knotSplines.count == 2 then
(
	myCoords = #((getKnotPoint $ knotSplines[1][1] knotSplines[1][2]),(getKnotPoint $ knotSplines[2][1] knotSplines[2][2]))
	updateshape $
	addKnot $ 1 #corner #line myCoords[1]
	--updateshape $
	addKnot $ 1 #corner #line myCoords[2]
	--updateshape $
)

updateshape $
max select none
wldSpine 0.01
updateshape $
wldSpine 0.01
updateshape $ 

/*
Make all knots Corner ! 

*/