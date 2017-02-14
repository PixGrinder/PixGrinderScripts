pda01 = getCurrentSelection()
pdac = $.center

x = abs($.max[1]-$.min[1])
y = abs($.max[2]-$.min[2])
z = abs($.max[3]-$.min[3])


global pda_dum = dummy isselected:false
pda_dum.pos = pdac
pda_dum.boxSize = [x,y,z]


rollout boxslice "Box Slicer" 
(
	spinner x1 "X" range:[-99999,999999,pda_dum.boxSize[1]] type:#float
	spinner y1 "Y" range:[-99999,999999,pda_dum.boxSize[2]] type:#float
	spinner z1 "Z" range:[-99999,999999,pda_dum.boxSize[3]] type:#float

	
	on x1 changed state do pda_dum.boxSize = [x1.value,pda_dum.boxSize[2],pda_dum.boxSize[3]]
	on y1 changed state do pda_dum.boxSize = [pda_dum.boxSize[1],y1.value,pda_dum.boxSize[3]]
	on z1 changed state do pda_dum.boxSize = [pda_dum.boxSize[1],pda_dum.boxSize[2],z1.value]
	
)


createDialog boxslice


-----------------------------

