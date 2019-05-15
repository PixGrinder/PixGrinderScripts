pda_h=1
pda_i=1
pda_j=1


for pda_h = 1 to scenematerials.count do ( 
	if (classOf scenematerials[pda_h]== standard ) and (classOf scenematerials[pda_h].bumpmap == Bitmaptexture)  then (
		pda_bmp = scenematerials[pda_h].bumpmap
		scenematerials[pda_h].bumpmap=Normal_Bump ()
		scenematerials[pda_h].bumpmap.Normal_map = pda_bmp
		scenematerials[pda_h].bumpmap.method = 3
		scenematerials[pda_h].bumpMapAmount=100
		)
	)
	
for pda_i = 1 to scenematerials.count do ( 
		if (classOf scenematerials[pda_i]== MultiMaterial ) do (
			for pda_j = 1 to scenematerials[pda_j].numsubs do (
				if (classOf scenematerials[pda_i][pda_j]== standard ) and (classOf scenematerials[pda_i][pda_j].bumpmap == Bitmaptexture)  then (
				pda_bmp = scenematerials[pda_i][pda_j].bumpmap
				scenematerials[pda_i][pda_j].bumpmap=Normal_Bump ()
				scenematerials[pda_i][pda_j].bumpmap.Normal_map = pda_bmp
				scenematerials[pda_i][pda_j].bumpmap.method = 3
				scenematerials[pda_i][pda_j].bumpMapAmount=100
			)
		)
	)
)


