$.length

curveLength $ 1

fn drawChain ptA ptB ptC ptD ptE ptF	=
(
	  ss = SplineShape pos:[0,0,0]
	  addNewSpline ss
	  addKnot ss 1 #corner #line PtA
	  addKnot ss 1 #corner #line PtB
	  addKnot ss 1 #corner #line PtC
	  addKnot ss 1 #corner #line PtD
	  addKnot ss 1 #corner #line PtE
	  addKnot ss 1 #corner #line PtF
	  updateShape ss
	  ss
)

newSpline = drawChain [-40,0,0] [-20,20,0] [20,20,0] [40,0,0] [20,-20,0] [-20,-20,0] 
close newSpline 1
updateShape newSpline
max modify mode
select newSpline
subObjectLevel = 1
setKnotType newSpline 1 1 #bezier
setKnotType newSpline 1 4 #bezier
setKnotSelection newSpline 1 #(1,4)

updateShape newSpline

updateShape $