-- Open all groups !
------------------------

(
	for i = 1 to 100 do (
		select helpers
		max group open
	)
)

----------------------

-- Detect Materials with Bitmaps
-------------------------------------

pda_std = #()
pda_mult = #()


for obj in geometry do (
	if ((classOf obj.material == standardmaterial) and (obj.material.diffusemap != undefined) and (obj.material.diffusemap.bitmap != undefined)) do (
		append pda_std obj
	)
	if classof obj.material == multimaterial do (
		for i=1 to obj.material.count do (
			if classof obj.material[i] == standardmaterial and obj.material[i].diffusemap != undefined and obj.material[i].diffusemap.bitmap != undefined do (
				append pda_mult obj
			)
		)
	)
)

max select none
select (pda_std + pda_mult)


-------------------

pda_std_mats=#()
pda_std_bitmap=#()

pda_mult_mats=#()
pda_mult_bitmap=#()

for i=1 to pda_std.count do (
	append pda_std_mats pda_std[i].material
	append pda_std_bitmap (filenamefrompath (pda_std[i].material.diffusemap.bitmap as string))
)

for i=1 to pda_mult.count do (
	append pda_mult_mats pda_mult[i].material
)


pda_std_mats
pda_mult_mats
pda_std_bitmap

