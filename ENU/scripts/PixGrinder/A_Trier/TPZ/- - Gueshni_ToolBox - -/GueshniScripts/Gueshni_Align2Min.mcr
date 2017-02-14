macroScript Align2Min category:"- Gueshni -" Icon:#("g9_align2min", 1) tooltip:"Align spline to minimum"
 (
	(
	for obj in selection do
	(

	for s = 1 to (numSplines obj) do 
	( 
	new_z = obj.max.z
	for k = 1 to (numKnots obj s) do 
	(
	knt=getKnotPoint obj s k
	if knt.z<new_z then new_z=knt.z
	)
	for k = 1 to (numKnots obj s) do 
	( 

	knt = getKnotPoint obj s k 
	in_vec = getInVec obj s k 
	out_vec = getOutVec obj s k 
	knt.z = in_vec.z = out_vec.z = new_z 
	setInVec obj s k in_vec 
	setOutVec obj s k out_vec 
	setKnotPoint obj s k knt 
	)--end k loop 
	)--end s loop 
	updateshape obj 
	)

)
)