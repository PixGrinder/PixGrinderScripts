
-- Mettre Mental Ray comme moteur de rendu
----------------------------------------------------

renderers.current = mental_ray_renderer()



-- single materials Occlusion
---------------------------------


i=1
pda_occ = #()
for i=1 to sceneMaterials.count do (
	if classOf sceneMaterials[i] == Arch___Design__mi do append pda_occ sceneMaterials[i]
)

j=1
for j=1 to pda_occ.count do(
	if classOf pda_occ[j] == Arch___Design__mi do (
		if pda_occ[j].diff_color_map != undefined then(
			pda_temp = 1
			pda_temp = pda_occ[j].diff_color_map
			pda_occ[j].diff_color_map = Ambient_Reflective_Occlusion__3dsmax ()
			pda_occ[j].diff_color_map.bright_shader = pda_temp
		) else (pda_occ[j].diff_color_map = Ambient_Reflective_Occlusion__3dsmax ())
	)	
)


-- MultiMaterials Occlusion
---------------------------------


i=1
pda_mult = #()
for i=1 to sceneMaterials.count do (
	if classOf sceneMaterials[i] == Multimaterial do appendifUnique pda_mult sceneMaterials[i]
)

i=1
for i=1 to pda_mult.count do (
	for j=1 to pda_mult[i].numsubs do(
		if classOf pda_mult[i][j] == Arch___Design__mi do (
			if pda_mult[i][j].diff_color_map != undefined then(
				pda_temp = 1
				pda_temp = pda_mult[i][j].diff_color_map
				pda_mult[i][j].diff_color_map = Ambient_Reflective_Occlusion__3dsmax ()
				pda_mult[i][j].diff_color_map.bright_shader = pda_temp
			) else (pda_mult[i][j].diff_color_map = Ambient_Reflective_Occlusion__3dsmax ())
		)	
	)
)







-- Brouillon
-------------

pda_occ


meditMaterials[3].diff_color_map.bright_shader