
----------------------------------------
-- Attach by Material in selection --
----------------------------------------

pda = #()
pda_mat = #()
pda = getcurrentselection()

for i = 1 to pda.count do
(
	appendifunique pda_mat pda[i].material
)

for i = 1 to pda_mat.count do
	
--- A FINIR !!