(

-- Valeur de reflection : 
----------------------------

global pda_val = 50

--------------------------------------

global pda_selec=getCurrentSelection()
-- global pda_selec=geometry
global pda_mat =#()
global pda_simplemat = #()



for i = 1 to pda_selec.count do 
(
	if pda_selec[i].material !=undefined do appendifunique pda_mat pda_selec[i].material
)

for i =1 to pda_mat.count do
(
		if classof pda_mat[i] == multimaterial do 
		(
			for j=1 to pda_mat[i].count do appendifunique pda_simplemat pda_mat[i][j]
		) 
		
		if classof pda_mat[i] != multimaterial do appendifunique pda_simplemat pda_mat[i]
)

-- pda_simplemat

for i = 1 to pda_simplemat.count do
(
	if classof pda_simplemat[i] == VRayMtl do 
	(
pda_simplemat[i].Reflection = color pda_val pda_val pda_val
pda_simplemat[i].reflection_lockGlossiness = off
pda_simplemat[i].hilight_glossiness = 0.3
-- 		pda_simplemat[i].option_traceReflection = on
-- 		pda_simplemat[i].option_traceRefraction = off
pda_simplemat[i].reflection_glossiness = 0.7
 		--pda_simplemat[i].reflection_glossiness = 1
		-- if pda_simplemat[i].reflection_subdivs == 32 do pda_simplemat[i].reflection_subdivs = 64
		pda_simplemat[i].reflection_subdivs = 48

	)
)

)
