macroScript ClearMaterialEditor category:"- Gueshni -" Icon:#("g9_clearmedit", 1) tooltip:"Clear Material Editor"
(
-- Variables

ray_yes = 0
on_which_slot_value = 1
on_which_slot_end_value = 24


-- Functions

fn changethematerial currentindex =
	(
	if ray_yes == 1 then newmaterial = RaytraceMaterial ()
	else newmaterial = Standard()
	newmaterial.name = ""
	newmaterial.diffuse = color 128 128 128
	meditMaterials[currentindex] = newmaterial
	)

fn clearall = 
	(
	for i = 1 to 24 do changethematerial i
	)

fn clear_range =
	(
	if on_which_slot_value > on_which_slot_end_value then
		(
		for i = on_which_slot_end_value to on_which_slot_value do
		changethematerial i
		)
	if on_which_slot_value <= on_which_slot_end_value then
		(
		for i = on_which_slot_value to on_which_slot_end_value do
		changethematerial i
		)
	)

fn clearunused = 
	(
	if sceneMaterials.count == 0 then
		for k = 1 to 24 do changethematerial k
		else
			(
			for i = 1 to 24 do
				(
				for j = 1 to sceneMaterials.count do
					(
					if sceneMaterials[j] == meditMaterials[i] then exit
					else
						( 
						if j == sceneMaterials.count then changethematerial i
						else continue
						)
					)
				)
			)
	)

fn clearunused_shift = 
	(
	if sceneMaterials.count == 0 then
		for k = 1 to 24 do changethematerial k
		else
			(
			m = 1   -- Medit last filled slot counter
			for i = 1 to 24 do
				(
				for j = 1 to sceneMaterials.count do
					(
					if sceneMaterials[j] == meditMaterials[i] then
						(
						if m != i then   -- if slot != index then copy from index and call clear fcn
							(
							meditMaterials[m] = meditMaterials[i]
							changethematerial i
							)
						m += 1  -- either case inc fill slot counter
						exit
						)
					else
						(
						if j == sceneMaterials.count then changethematerial i
						else continue
						)
					)
				)
			)
	)

-- Script

rollout clearmeditrollout "ClearMedit"
	(
	checkbox Use_Raytraced "Use Raytraced" align:#center
	on Use_Raytraced changed state do 
		(
		if Use_Raytraced.checked == true then ray_yes = 1
		else ray_yes = 0
		)

	button all "All" width:100 align:#center toolTip:"All"
	on all pressed do clearall()

	button unused "Unused" width:100 align:#center toolTip:"Unused"
	on unused pressed do clearunused()

	button unused_shift "Unused + Shift" width:100 align:#center toolTip:"Unused + Shift"
	on unused_shift pressed do clearunused_shift()

	button mat_range "Range" width:100 align:#center toolTip:"Range"
	on mat_range pressed do clear_range()

	spinner on_which_slot "Slot: " range:[1,24,1] type:#integer fieldWidth:50 align:#right
	spinner on_which_slot_end "to: " range:[1,24,24] type:#integer fieldWidth:50 align:#right

	on on_which_slot changed val do on_which_slot_value = val
	on on_which_slot_end changed val do on_which_slot_end_value = val
	)

clearmeditfloater = newRolloutFloater "Clear Material Editor" 140 236
addRollout clearmeditrollout clearmeditfloater
)