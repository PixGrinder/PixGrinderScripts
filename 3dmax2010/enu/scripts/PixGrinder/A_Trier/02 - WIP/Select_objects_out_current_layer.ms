

obj_ar = #()
l1 = layermanager.current

for obj in objects do (
	if obj.layer != l1 do (
		append obj_ar obj
	)
)

select obj_ar

