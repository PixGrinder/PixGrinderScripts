
-- Mettre Mental Ray comme moteur de rendu
----------------------------------------------------

renderers.current = mental_ray_renderer()

pda_samples = 32
pda_maxdist = 1

-- single materials Occlusion
---------------------------------


i=1
pda_occ = #()
for i=1 to sceneMaterials.count do appendIfUnique pda_occ sceneMaterials[i]
	
j=1
for j=1 to pda_occ.count do(
	if classOf pda_occ[j] == Arch___Design__mi do (
			pda_occ[j].diff_color_map.Samples = pda_samples
			pda_occ[j].diff_color_map.max_distance = pda_maxdist
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
			pda_mult[i][j].diff_color_map.Samples = pda_samples
			pda_mult[i][j].diff_color_map.max_distance = pda_maxdist
		)	
	)
)



-- Brouillon
-------------

pda_occ


meditMaterials[3].diff_color_map.bright_shader

i=3
sceneMaterials[i].diff_color_map.Samples = 32
sceneMaterials[i].diff_color_map.max_distance = 1



