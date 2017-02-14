pda_cur=#()
pda_cur = selection as array
Dummy pos:[0,0,0] isSelected:on boxsize:[10, 10,10] 
$.name="A_virer"
for i=1 to pda_cur.count do pda_cur[i].parent = $A_virer
macros.run "Tools" "Scale"
max tti
