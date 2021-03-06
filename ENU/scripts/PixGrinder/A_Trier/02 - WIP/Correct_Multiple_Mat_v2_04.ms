-- Open all groups !
------------------------

(
	for i = 1 to 100 do (
		select helpers
		max group open
	)
)

----------------------

-- Lister toutes les bitmaps de la scene
--------------------------------------------


pda_maps=#()
pda_std=#()
pda_mti=#()


for obj in geometry do (
	if obj.isHidden == false and classof obj.material == standardmaterial and obj.material.diffusemap != undefined and obj.material.diffusemap.bitmap != undefined do(
		appendifunique pda_maps (filenamefrompath (obj.material.diffusemap.bitmap as string))
		append pda_std obj
	)
	if obj.isHidden == false and classof obj.material == multimaterial do(
		for i = 1 to obj.material.count do (
			if obj.material[i].diffusemap != undefined and obj.material[i].diffusemap.bitmap != undefined do (
				appendifunique pda_maps (filenamefrompath (obj.material[i].diffusemap.bitmap as string))
				append pda_mti obj
			)
		)
	)
)


pda_maps.count


-- Problem with Standard Mats
----------------------------------

pda=#()

for j=1 to pda_std.count do (
	append pda #()
)


for j=1 to pda_std.count do (
	for i = 1 to pda_maps.count do (
		if pda_maps[i] == (filenamefrompath (pda_std[j].material.diffusemap.bitmap as string)) do (
			append pda[j] pda_std[j]
		)
	)
)





