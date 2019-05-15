for i = 1 to sceneMaterials.count do(
-- 	if classof sceneMaterials[i] == standardmaterial do (
-- 			sceneMaterials[i].Diffuse = color 255 255 255
-- 	)
	if classof sceneMaterials[i] == multimaterial do (
		for j = 1 to scenematerials[i].count do (
			if classof sceneMaterials[i][j] == standardmaterial do (
				sceneMaterials[i][j].Diffuse= color 255 255 255
			)
			
		)
	)
)



i=
sceneMaterials[50].diffuse = color