-------------------------------------------------------------------------------
-- CollapseSubObjectMaterial.ms
-- By Neil Blevins (soulburn@blur.com)
-- v 1.21
-- Created On: 09/12/01
-- Modified On: 04/16/02
-- tested using Max 4.2
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Required Files:
-- BSLib.ms, http://www.blur.com/blurmaxscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- Takes an object that has a multi/subobject material, and collapses the material 
-- to use only the subobject materials that are assigned to face IDs on the object.
-- Modifies the object as well, consolidation material IDs and collapsing it to an 
-- editable mesh. Great for cleaning up nasty subobject materials on characters 
-- or buildings that have been attached several billion times.
--
-- A huge thanks to Larry Minton for the CollapseMM script on which the initial
-- version of this script is based.
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Revision History:
--
-- v 1.00 Takes an object that has a multi/subobject material, and collapses the 
-- material to use only the subobject materials that are assigned to face IDs on 
-- the object. Modifes the object as well, consolidation material IDs, and 
-- converting it to an editable mesh.
--
-- v 1.10 Put a lot of error trapping in. Added ability to reduce submaterials
-- that are instances of each other.
--
-- v 1.20 Added ability to reduce nested submaterials, as in, get rid of
-- submaterials that exist inside of sub materials. Original idea and code from
-- Brett Hartshorn.
--
-- v 1.21 Added a warning label so the user realizes collapsing material will
-- also collapse the modifier stack of the object.
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------


-- PixGrinder Modif v2.0 -- 
-- Proccess all scene geometries and added a progress bar  --


-------------------------------------------------------------------------------

-------------------------------------------------------------------------------


(
	-- Globals

	global csom_compare_func
	global csom_clear_object
	global prepare_mesh
	global collapse_material
	global kill_nested_submaterials

	global csom_rollout
	global csom_floater

	-- Includes

	include "$userScripts/PixGrinder/BSLib.ms"

	-- Variables

	my_obj = undefined
	old_mat = undefined
	new_mat = undefined
	used_mat_ids = #()
	old_sub_mats = #()
	new_sub_mats = #()

	active_slot_value = false
	sort_alpha_value = true
	reduce_instanced_value = true
	reduce_nested_value = true

	-- Functions

	fn csom_compare_func x y = 
		(
		if (lowercase x[1].name) < (lowercase y[1].name) then return -1
		else if (lowercase x[1].name) > (lowercase y[1].name) then return 1
		else return 0
		)

	fn csom_clear_object = 
		(
-- 		csom_rollout.what_obj.text = "None"
		my_obj = undefined
-- 		csom_rollout.submats_label.text = ""
-- 		csom_rollout.usedmatid_label.text = ""
-- 		csom_rollout.cm_do.enabled = false
		)

	fn prepare_mesh obj = 
		(
		my_obj = obj
		old_mat = my_obj.material
		used_mat_ids = #()
		
		convertToMesh my_obj
-- 		csom_rollout.what_obj.text = my_obj.name
		if classof old_mat != Multimaterial then 
			(
			-- MessageBox "Object material is not a Multi/sub-object Material." title:"CollapseSubObjectMaterial"
			csom_clear_object()
			)
		else if (getNumFaces my_obj) == 0 then 
			(
			--MessageBox "Object does not have any faces, please pick a new object." title:"CollapseSubObjectMaterial"
			csom_clear_object()
			)
		else
			(
			for i = 1 to (getNumFaces my_obj) do 
				(
				answer = getFaceMatID my_obj i
				if finditem used_mat_ids (answer as integer) == 0 then append used_mat_ids (answer as integer)
				)
			sort used_mat_ids
			
-- 			csom_rollout.submats_label.text = old_mat.numsubs as string
-- 			csom_rollout.usedmatid_label.text = used_mat_ids.count as string
-- 			csom_rollout.cm_do.enabled = true
			)
		)

	fn collapse_material obj = 
		(

		my_obj = obj	
		if isDeleted my_obj == true then 
			(
			-- MessageBox "Object no longer exists, please pick a new object." title:"CollapseSubObjectMaterial"
			csom_clear_object()
			)
		else
			(
			old_sub_mats = #()
			new_sub_mats = #()

			-- Perform Nested SubMaterial Test
			if reduce_nested_value == true then kill_nested_submaterials()
			
			-- Make Old_sub_Mats Array
			for osm = 1 to old_mat.numsubs do
				(
				append old_sub_mats old_mat[osm]
				)
			
			-- Make New_Sub_Mats Array
			if reduce_instanced_value == false then
				(
				for m = 1 to used_mat_ids.count do
					(
					append new_sub_mats #(old_sub_mats[used_mat_ids[m]],#(used_mat_ids[m]))
					)
				)
			else
				(
				for m = 1 to old_sub_mats.count do
					(
					if old_sub_mats[m] != undefined then
						(
						a = indexes_of_instances_in_array old_sub_mats old_sub_mats[m]
						c = #()
						for b = 1 to a.count do
							(
							if finditem used_mat_ids a[b] != 0 then append c a[b]
							)
						if c.count!= 0 then append new_sub_mats #(old_sub_mats[m],c)
						for b = 1 to a.count do
							(
							old_sub_mats[a[b]] = undefined
							)
						)
					)
				)
				
			-- Sort New-Sub_Mats Array
			if sort_alpha_value == true then
				(
				qsort new_sub_mats csom_compare_func
				)
				
			-- Makes Material
			new_mat = Multimaterial numsubs:new_sub_mats.count name:(my_obj.name+"_"+my_obj.material.name)
			for m = 1 to new_sub_mats.count do
				(
				new_mat[m] = new_sub_mats[m][1]
				)
			
			-- Changes Faces
			for f = 1 to my_obj.numfaces do
				(
				oldid = getFaceMatID my_obj f
				for i = 1 to new_sub_mats.count do
					(
					for w = 1 to new_sub_mats[i][2].count do
						(
						if new_sub_mats[i][2][w] == oldid then setFaceMatID my_obj f i
						)
					)			
				)
				
			-- Sets New Material
			my_obj.material = new_mat
			if active_slot_value == true then meditMaterials[medit.GetActiveMtlSlot()] = new_mat
			
			csom_clear_object()
			)
		)
		
	fn kill_nested_submaterials = 
		(
		one_found = false
		for i = 1 to my_obj.material.count do
			(
			if classof my_obj.material[i] == Multimaterial then
				(
				one_found = true
				my_obj.material[i] = my_obj.material[i][i]
				)
			)
		if one_found == true then kill_nested_submaterials()
		)



-- 	for bla in geometry where classof bla.material == multiMaterial do
-- 	(
-- 		prepare_mesh bla
-- 		collapse_material bla
-- 		convertToPoly bla
-- 	)

	myMultis = for obj in objects where classof obj.material == multiMaterial and obj.layer.on == on collect obj

	myProg = 0

	progressStart "Collapsing MultiMaterials..."

	for i = 1 to myMultis.count do
	(
		prepare_mesh myMultis[i]
		collapse_material myMultis[i]
		convertToPoly myMultis[i]
		if (100*(i as float)/myMultis.count > (myProg as float)) do
		(
			myProg = myProg+1
			progressUpdate myProg
		)
	)

	ProgressEnd()

-- 	messageBox("BlurScript done on whole scene objects ")
)

