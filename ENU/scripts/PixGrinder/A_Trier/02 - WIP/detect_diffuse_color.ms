pda_ar1 = #()



for obj in selection do (
	if ((classOf obj.material == standardmaterial) and (obj.material.diffusemap != undefined) and (obj.material.diffusemap.bitmap != undefined)) do (
		append pda_ar1 obj
	)
	if classof obj.material == multimaterial do (
		for i=1 to obj.material.count do (
			if classof obj.material[i] == standardmaterial and obj.material[i].diffusemap != undefined and obj.material[i].diffusemap.bitmap != undefined do (
				append pda_ar1 obj
			)
		)
	)
-- 	on stop do (
-- 		print obj.name
-- 		select obj
-- 		meditmaterials[1] = obj.material
-- 	)
)
-- dummy isSelected: true
-- delete $
max select none
select pda_ar1



-------------------


obj = $


if classOf $.material[2].diffusemap.bitmap as string  --- != bitmap then print "test reussi" else print "loose"
	
on error