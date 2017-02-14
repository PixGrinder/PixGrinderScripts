macroScript Planter category:"- Gueshni -" Icon:#("g9_planter", 1) tooltip:"Planter"
 (
	(
-- Globals

global ground_obj
global pl_down = true

global plant_em

global pl_floater
global pl_rollout

-- Includes

include "$scripts/GueshniLib.ms"

-- Variables

-- Functions

fn plant_em = 
	(
	progressStart "Planter"
	escapeEnable = false
	itemnum = selection.count
	
	pl_errors = 0
	
	curiter = 0
	high_z = (get_scene_bbox())[1].z + 100
	low_z = (get_scene_bbox())[2].z - 100
	
	for i in selection do
		(
		curiter += 1
		m = ((curiter as float)/(itemnum as float))*100
		
		local ray_pos
		local s
		
		if pl_down == true then 
			(
			ray_pos = [i.pos.x, i.pos.y, high_z]
			s = intersectray ground_obj (ray ray_pos [0,0,-1])
			)
		else 
			(
			ray_pos = [i.pos.x, i.pos.y, low_z]
			s = intersectray ground_obj (ray ray_pos [0,0,1])
			)
		
		if s == undefined then pl_errors += 1 else i.pos = s.pos
		progressUpdate m
		)
		
	progressEnd()
	if pl_errors > 0 then 
		(
		to_print = (pl_errors as string) + " object(s) in your selection were not directly above or below the ground object, and their positions were not modified"
		MessageBox to_print title:"Planter"
		print to_print
		)
	)
	
-- Script

rollout pl_rollout "Planter"
	(
	group "Ground Object"
	(
	label what_ground "None" align:#center

	pickbutton pickground "Pick The Ground Object" width:150 toolTip:"Pick The Ground Object" filter:geometry_filter across:2 align:#left
	Checkbutton updown "Down" width:40 highlightcolor:([255,255,0] as color) tooltip:"Up or Down" align:#right
	)
	on pickground picked obj do 
		(
		ground_obj = obj
		what_ground.text = obj.name
		)
		
	on updown changed state do 
		(
		if state == on then 
			(
			pl_down = false
			updown.text = "Up"
			)
		else 
			(
			pl_down = true
			updown.text = "Down"
			)
		)

	button doit "Plant Selected Objects" width:196 align:#center toolTip:"Plant Selected Objects"
	on doit pressed do 
		(
		if ground_obj == undefined then (MessageBox "Please pick a ground object" title:"Planter")
		else
			(
			if selection.count == 0 then (MessageBox "Please select some object to be planted" title:"Planter")
			else 
				(
				if isdeleted ground_obj == true then MessageBox "Your ground object no longer seems to exist, please pick a new object" title:"Planter"
				else plant_em()
				)
			)
		)
	)

if pl_floater != undefined then CloseRolloutFloater pl_floater
pl_floater = newRolloutFloater "Planter" 250 164
addRollout pl_rollout pl_floater
)
)