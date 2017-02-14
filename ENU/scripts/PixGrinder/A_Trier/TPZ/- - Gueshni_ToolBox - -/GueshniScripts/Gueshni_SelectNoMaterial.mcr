macroScript SelectNoMaterial category:"- Gueshni -" Icon:#("g9_selectnomaterial", 1) tooltip:"Select No Material"
 (
	(
sbnm_mat_array = #()
for i in $* do
	(
	if i.material == undefined then append sbnm_mat_array i
	)
select sbnm_mat_array
)
)