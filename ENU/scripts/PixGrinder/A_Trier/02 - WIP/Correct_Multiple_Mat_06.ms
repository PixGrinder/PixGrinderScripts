
pda01 = selection as array
pda02 = pda01
pda_seuil1 = 1
pda_seuil2 = 25

for i = 1 to pda01.count do (
	if classOf pda01[i].material == Standard do (
		for j = 1 to pda02.count do (
			if classOf pda02[j].material == Multimaterial do (
				for k = 1 to pda02[j].material.count do (
					x1 = pda01[i].material.diffusecolor.red
					y1 = pda01[i].material.diffusecolor.green
					z1 = pda01[i].material.diffusecolor.blue
					x2 = pda02[j].material[k].diffusecolor.red
					y2 = pda02[j].material[k].diffusecolor.green
					z2 = pda02[j].material[k].diffusecolor.blue
					if (
						((x1+y1+y2)/3) < (((x2+y2+z2)/3)+pda_seuil1) and ((x1+y1+y2)/3) > (((x2+y2+z2)/3)-pda_seuil1)
					) do (
						pda02[j].material[k] = pda01[i].material
					)
				)
			)
		)
				for j = 1 to pda02.count do (
					if classOf pda02[j].material == Standard do (
						x1 = pda01[i].material.diffusecolor.red
						y1 = pda01[i].material.diffusecolor.green
						z1 = pda01[i].material.diffusecolor.blue
						x2 = pda02[j].material.diffusecolor.red
						y2 = pda02[j].material.diffusecolor.green
						z2 = pda02[j].material.diffusecolor.blue
						if (
							((x1+y1+y2)/3) < (((x2+y2+z2)/3)+pda_seuil1) and ((x1+y1+y2)/3) > (((x2+y2+z2)/3)-pda_seuil1)
						) do (
							pda02[j].material = pda01[i].material
						)
					)
				)
	)
)

--------------

y2
y2+25

---------------------
-- Backup
---------------------

-- pda01 = selection as array
-- pda02 = pda01

-- for i = 1 to pda01.count do (
-- 	if classOf pda01[i].material == Standard do (
-- 		for j = 1 to pda02.count do (
-- 			if classOf pda02[j].material == Multimaterial do (
-- 				for k = 1 to pda02[j].material.count do (
-- 					if pda01[i].material.diffusecolor == pda02[j].material[k].diffusecolor do (
-- 						pda02[j].material[k] = pda01[i].material
-- 					)
-- 				)
-- 			)
-- 		)
-- 				for j = 1 to pda02.count do (
-- 					if classOf pda02[j].material == Standard do (
-- 						if pda01[i].material.diffusecolor == pda02[j].material.diffusecolor do (
-- 							pda02[j].material = pda01[i].material
-- 						)
-- 					)
-- 				)
-- 	)
-- )


x1 = $.material.diffusecolor.red
y1 = $.material.diffusecolor.green
z1 = $.material.diffusecolor.blue

x2 = $.material.diffusecolor.red
y2 = $.material.diffusecolor.green
z2 = $.material.diffusecolor.blue


x1 > x2
