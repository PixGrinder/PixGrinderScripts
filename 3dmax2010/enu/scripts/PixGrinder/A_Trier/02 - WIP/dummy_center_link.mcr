-- Dummy creator

(
	pda1 = getcurrentselection()
	pda2 = dummy name:"A_Virer" pos:[0,0,0] boxsize:[5,5,5]
	select pda1
	pda2.pos = $.center
	pda1.parent = pda2
)
