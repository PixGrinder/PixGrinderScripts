macros.run "Medit Tools" "clear_medit_slots"


pda = getCurrentSelection()
pda_mat = #()


for i = 1 to pda.count do 
(
	if pda[i].material != undefined and superclassof pda[i] == GeometryClass do appendifunique pda_mat pda[i].material
)

for i = 1 to 24 do meditmaterials[i] = pda_mat[i]
	

----------------------------------

if pda[1].material != undefined do meditmaterials[24] = pda[1].material