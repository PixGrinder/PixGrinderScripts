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

for obj in geometry do (
		if obj.isHidden == false and classof obj.material == standardmaterial and obj.material.diffusemap != undefined and obj.material.diffusemap.bitmap != undefined do(
			appendifunique pda_maps (filenamefrompath (obj.material.diffusemap.bitmap as string))
		)
		
	
)

pda_maps

for i = 1 to pda_maps.count do print pda_maps[i]


------------------------------

obj=$
$.isHidden

