pda_x = getCurrentSelection()
pda_size = ((abs(pda_x[1].max[1]-pda_x[1].min[1]) + abs(pda_x[1].max[2]-pda_x[1].min[2]) + abs(pda_x[1].max[3]-pda_x[1].min[3]))/3)/2
pda_dum = dummy name:(pda_x[1].name+"_pivot")
pda_dum.transform = pda_x[1].transform
pda_dum.center = pda_x[1].pivot
pda_dum.boxSize = [pda_size,pda_size,pda_size]
pda_x[1].parent = pda_dum
select pda_dum
max tool zoomextents
