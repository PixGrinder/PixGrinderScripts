-------------
-- DEBUT
-------------


-- Mettre Mental Ray comme moteur de rendu
----------------------------------------------------

renderers.current = mental_ray_renderer()


-- Ouvrir tous les groupes de la sc�ne
-------------------------------------------
i=1
for i = 1 to 100 do (
	select helpers
	max group open
)


-- Stocker tous les materiaux de la sc�ne dans la variable pda_std ( array)
-------------------------------------------------------------------------------------

i=1
pda_std = #()
for i=1 to sceneMaterials.count do (
	if classOf sceneMaterials[i] == standard do append pda_std sceneMaterials[i]
)


-- Conversion des materiaux  
--------------------------------

pda_ar = #()
obj = 1
i=1
for obj in geometry do (
	for i = 1 to pda_std.count do(
		if obj.material == pda_std[i] do (
			append pda_ar obj
		)
	)
)

i=1
pda_mtls = #()
for i = 1 to pda_ar.count do(
		appendIfUnique pda_mtls pda_ar[i].material
)

i=1
obj=1
for i = 1 to pda_mtls.count do(
	-- pda_bump = pda_mtls[i].bumpMap
	-- pda_bump_amount = ((pda_mtls[i].bumpMapAmount)/100)
	meditMaterials[1] = Arch___Design__mi ()
	meditMaterials[1].name = pda_mtls[i].name
	meditMaterials[1].diff_color_map = pda_mtls[i].diffuseMap
	meditMaterials[1].diff_color = pda_mtls[i].diffuse
	meditMaterials[1].diff_weight = pda_mtls[i].diffuseMapAmount/100
	meditMaterials[1].bump_map = pda_mtls[i].bumpMap
	meditMaterials[1].bump_map_amt = ((pda_mtls[i].bumpMapAmount)/100)
	meditMaterials[1].cutout_map = pda_mtls[i].opacityMap
	meditMaterials[1].refr_weight  = 1-(pda_mtls[i].opacity/100)
	meditMaterials[1].displacement_map = pda_mtls[i].displacementMap
	meditMaterials[1].displacement_map_amt = (pda_mtls[i].displacementMapAmount/100)
	
	--if pda_mtls[i].opacityMap != undefined do (
	--	meditMaterials[1].cutout_map = Bitmaptexture filename:pda_mtls[i].opacityMap.filename
	--	meditMaterials[1].cutout_map.name=append pda_mtls[i].opacityMap.name "_opacity"
	--	meditMaterials[1].cutout_map.RGBOutput = 1
	--)
	meditMaterials[1].showInViewport=true
	for obj in geometry do (
		if obj.material == pda_mtls[i] do obj.material = meditMaterials[1]
	)
)



-- MultiMaterials Conversion
---------------------------------


i=1
pda_mult = #()
for i=1 to sceneMaterials.count do (
	if classOf sceneMaterials[i] == Multimaterial do appendifUnique pda_mult sceneMaterials[i]
)

i=1
for i=1 to pda_mult.count do (
	meditMaterials[1] = Multimaterial numsubs:pda_mult[i].numsubs
	meditMaterials[1].name = pda_mult[i].name
	--j=1
	for j=1 to pda_mult[i].numsubs do(
		if classOf pda_mult[i][j] == Standardmaterial then (
			meditMaterials[1][j] = Arch___Design__mi ()
			meditMaterials[1][j].name = pda_mult[i][j].name
			meditMaterials[1][j].diff_color_map = pda_mult[i][j].diffuseMap
			meditMaterials[1][j].diff_color = pda_mult[i][j].diffuse
			meditMaterials[1][j].diff_weight = pda_mult[i][j].diffuseMapAmount/100
			meditMaterials[1][j].bump_map = pda_mult[i][j].bumpMap
			meditMaterials[1][j].bump_map_amt = ((pda_mult[i][j].bumpMapAmount)/100)
			meditMaterials[1][j].cutout_map = pda_mult[i][j].opacityMap
			meditMaterials[1][j].refr_weight  = 1-(pda_mult[i][j].opacity/100)
			meditMaterials[1][j].displacement_map = pda_mult[i][j].displacementMap
			meditMaterials[1][j].displacement_map_amt = (pda_mult[i][j].displacementMapAmount/100)
			meditMaterials[1][j].showInViewport=true
		) else (
			meditMaterials[1][j] = pda_mult[i][j]
		)
	)
	--obj=1
	for obj in geometry do (
		if obj.material == pda_mult[i] do obj.material = meditMaterials[1]
	)
	
)


---------
-- FIN
---------


------------------------------------------
-- Brouillon : 
---------------



i=2
j=1

pda_mult[i][j]

meditMaterials[2] = pda_mult[2]
