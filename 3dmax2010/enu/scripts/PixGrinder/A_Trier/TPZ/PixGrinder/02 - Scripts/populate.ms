pda = getcurrentselection()
pda_mat = #()

for i = 1 to pda.count do appendifunique pda_mat pda[i].material
	
for i = 1 to pda_mat.count do if i < 25 do meditmaterials[i] = pda_mat[i]