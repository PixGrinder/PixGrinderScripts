-- diffuse bitmap problem
----------------------------

pda01 = selection as array
pda02 = pda01
pda_a = ""
pda_b = ""


for i = 1 to pda01.count do (
	if classOf pda01[i].material == Standard and pda01[i].material.diffusemap != undefined  do (
		for j = 1 to pda02.count do (
			if classOf pda02[j].material == Multimaterial do (
				for k = 1 to pda02[j].material.count do (
					if (pda02[j].material[k].diffusemap != undefined) do (
						pda_a = filenamefrompath (pda02[j].material[k].diffusemap.bitmap as string)
						pda_b = filenamefrompath (pda01[i].material.diffusemap.bitmap as string)
						if  pda_a == pda_b do ( pda02[j].material[k] = pda01[i].material )
					)
				)
			)
		)
		for j = 1 to pda02.count do (
			if classOf pda02[j].material == Standard do (
				if (pda02[j].material.diffusemap != undefined)  do (
					pda_a = filenamefrompath (pda02[j].material.diffusemap.bitmap as string)
					pda_b = filenamefrompath (pda01[i].material.diffusemap.bitmap as string) 
					if  pda_a == pda_b do ( pda02[j].material = pda01[i].material )
				)
			)
		)
	)
)





-- diffuse color problem
---------------------------

pda01 = selection as array
pda02 = pda01
pda_seuil1 = 30 -- seuil de variation entre rouge - vert - bleu
pda_seuil2 = 15 -- seuil de variation pour les materiaux qui ont des rgd proches ( ex 2 materiaux gris )
pda_seuil3 = 5 -- seuil de variation pour les materiaux dont le RGB est disparate



for i = 1 to pda01.count do (
	if classOf pda01[i].material == Standard and pda01[i].material.diffusemap==undefined do (
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
						pda02[j].material[k].diffusemap==undefined and x1<=(y1+pda_seuil1) and x1>=(y1-pda_seuil1) and x1<=(z1+pda_seuil1) and x1>=(z1-pda_seuil1) and x2<=(y2+pda_seuil1) and x2>=(y2-pda_seuil1) and x2<=(z2+pda_seuil1) and x2>=(z2-pda_seuil1) and (abs(x1-x2)<=pda_seuil2) and (abs(y1-y2)<=pda_seuil2) and (abs(z1-z2)<=pda_seuil2)
					) then (
						pda02[j].material[k] = pda01[i].material
					) else if (
						pda02[j].material[k].diffusemap==undefined and (abs(x1-x2)<=pda_seuil3) and (abs(y1-y2)<=pda_seuil3) and (abs(z1-z2)<=pda_seuil3)
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
						pda02[j].material.diffusemap==undefined and x1<=(y1+pda_seuil1) and x1>=(y1-pda_seuil1) and x1<=(z1+pda_seuil1) and x1>=(z1-pda_seuil1) and x2<=(y2+pda_seuil1) and x2>=(y2-pda_seuil1) and x2<=(z2+pda_seuil1) and x2>=(z2-pda_seuil1) and (abs(x1-x2)<=pda_seuil2) and (abs(y1-y2)<=pda_seuil2) and (abs(z1-z2)<=pda_seuil2)
					) then (
						pda02[j].material = pda01[i].material
					) else if (
						pda02[j].material.diffusemap==undefined and (abs(x1-x2)<=pda_seuil3) and (abs(y1-y2)<=pda_seuil3) and (abs(z1-z2)<=pda_seuil3)
						) do (
						pda02[j].material = pda01[i].material
						)
					)
				)
	)
)




