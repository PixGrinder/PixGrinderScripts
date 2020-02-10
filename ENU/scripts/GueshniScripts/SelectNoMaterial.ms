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