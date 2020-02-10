 (
	(
-- Globals

global select_random_faces
global rfs_filters

global rfs_rollout
global rfs_floater

-- Variables

weight_value = 50
percentage_value = 50

select_array = #()

-- Functions

fn select_random_faces obj selecttype = 
	(
	if obj.faces.count != 0 then
		(
		subobjectLevel = 4
		select_array = #()
		
		a = (for i = 1 to obj.faces.count collect i)
		
		if selecttype == 1 then select_array = choose_unique_by_weight a weight_value
		else select_array = choose_unique_by_percentage a percentage_value
		
		select obj.faces[select_array]
		select_array = #()
		)
	)
	
fn rfs_filters selecttype =
	(
	undo "RandomFaceSelect" on
		(
		if selection.count == 1 then
			(
			for i in selection do
				(
				if classof i == Editable_Poly or classof i == PolyMeshObject then 
					(
					convertTo i PolyMeshObject
					select_random_faces i selecttype
					)
				else if classof i == Editable_mesh then
					(
					convertTo i TriMeshGeometry
					select_random_faces i selecttype
					)
				else (MessageBox "The object is not a PolyObject or Editable Mesh." title:"RandomFaceSelect")
				)
			)
		else (MessageBox "Please select only one object." title:"RandomFaceSelect")
		)
	)
	
-- Script

	try(destroyDialog rfs_rollout)catch()
rollout rfs_rollout "RandomFaceSelect"
	(
	spinner weight_spinner "Weight:" range:[0,100,50] type:#integer fieldWidth:40 across:2 align:#right offset:[9,0] 
	button do_weight "Select Faces" width:100 toolTip:"Select Faces" align:#right
	spinner per_spinner "Percentage %:" range:[0,100,50] type:#float fieldWidth:40 across:2 align:#right offset:[9,0]
	button do_per "Select Faces" width:100 toolTip:"Select Faces" align:#right

	on weight_spinner changed val do weight_value = val
	on per_spinner changed val do percentage_value = val
	
	on do_weight pressed do rfs_filters 1
	on do_per pressed do rfs_filters 2
	)

createdialog rfs_rollout  width:290 height:60 pos:[140,210] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)
)
)