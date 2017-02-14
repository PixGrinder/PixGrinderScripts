
-- Mettre Mental Ray comme moteur de rendu
----------------------------------------------------

renderers.current = mental_ray_renderer()


-----------------------------------------

-- MR Occlusion  Variables : 
--------------------------------

-- Valeurs par défaut :
-------------------------
-- pda_samples = 16
-- pda_spread =0.75
-- pda_dist=0
-- pda_falloff = 1


pda_samples = 32
pda_spread =0.75
pda_dist=1    -- (100 = 1m)
pda_falloff = 1

-------------------------------------------


$.material[1].diff_color_map.max_distance

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
		if (classOf pda_occ[j].diff_color_map) == Ambient_Reflective_Occlusion__3dsmax do (
			pda_occ[j].diff_color_map.samples = pda_samples
			pda_occ[j].diff_color_map.spread = pda_spread
			pda_occ[j].diff_color_map.max_distance = pda_dist
			pda_occ[j].diff_color_map.falloff = pda_falloff
		)
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
			if classof pda_mult[i][j].diff_color_map == Ambient_Reflective_Occlusion__3dsmax do (
				pda_mult[i][j].diff_color_map.samples = pda_samples
				pda_mult[i][j].diff_color_map.spread = pda_spread
				pda_mult[i][j].diff_color_map.max_distance = pda_dist
				pda_mult[i][j].diff_color_map.falloff = pda_falloff
			)
		)
		
	)
)