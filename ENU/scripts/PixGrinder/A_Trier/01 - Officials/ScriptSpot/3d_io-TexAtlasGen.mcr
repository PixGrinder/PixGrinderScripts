-- Copyright 2009 3d-io
-- 3D-IO Games & Video Production GmbH | Rüdesheimer Straße 9 | 65197 Wiesbaden | GERMANY
-- Contact: info@3d-io.com
-- Author: Friedrich Hanisch, friedrich@3d-io.com

-- Version 1.0.3

macroScript TexAtlasGen
			category:"3d-io"
			Icon:#("Patches",1)
(
	local filename = "$scripts\\texatlasgen_configfile.txt"
    local file
	
	local polyop_setmapvert = polyop.setMapVert
	local polyop_getvert = polyop.getVert
	local polyop_slice = polyop.slice
	local polyop_getfaceverts = polyop.getFaceVerts
	local polyop_getfaceedges = polyop.getFaceEdges
	local polyop_getmapvert = polyop.getMapVert
	local polyop_getmapface = polyop.getMapFace
	local polyop_getfacenormal = polyop.getFaceNormal

	---

	fn tag_getEdgeVerts obj face_index edge_index =
	(
		if (classOf obj) == Editable_Poly then
		(
			local verts = (polyop_getfaceverts obj face_index)
			local edges = (polyop_getfaceedges obj face_index)
	 
			edge_index = findItem edges edge_index
			if edge_index == edges.count then
				#(verts[edge_index], verts[1])
			else
				#(verts[edge_index], verts[edge_index+1])
		)
		else
			"ERROR"
	)

	fn tag_getMapVert obj map_channel face_indices index =
	(
		if (classOf obj) == Editable_Poly then
		(
			if (classof face_indices) == integer then face_indices = #(face_indices)
			else face_indices = face_indices as Array
			local mesh_verts = #()
			local text_verts = #()
			for i in face_indices do
			(
				join mesh_verts (polyop_getfaceverts obj i)
				join text_verts (polyop_getmapface obj map_channel i)
			)
			index = findItem mesh_verts index
			(polyop_getmapvert obj map_channel text_verts[index])
		)
		else
			"ERROR"
	)

	fn tag_setMapVert obj map_channel face_indices index vert =
	(
		if (classOf obj) == Editable_Poly then
		(
			if (classof face_indices) == integer then face_indices = #(face_indices)
			else face_indices = face_indices as Array
			local mesh_verts = #()
			local text_verts = #()
			for i in face_indices do
			(
				join mesh_verts (polyop_getfaceverts obj i)
				join text_verts (polyop_getmapface obj map_channel i)
			)
			index = findItem mesh_verts index
			polyop_setmapvert obj map_channel text_verts[index] vert
		)
		else
			"ERROR"
	)
	 
	fn tag_getVertex obj index =
	(
		if (classOf obj) == Editable_Poly then
			(in coordsys world polyop_getvert obj index)
		else
			"ERROR"
	)
	 
	fn tag_slice obj faces normal center =
	(
		if (classOf obj) == Editable_Poly then
		(
			local plane = (ray center normal)
			polyop_slice obj faces plane
		)
		else
			"ERROR"
	)
	 
	-- helper functions
	 
	fn tag_equal_int a b =
	(
		if a-b > 0.001 or a-b < -0.001 then false else true
	)
	 
	---
	 
	fn checkMirror obj map_channel face_index =
	(
		local sum = 0
		
		if (classOf obj) == Editable_Poly then
		(
			local verts = (polyop_getfaceverts obj face_index)
			local edges = (polyop_getfaceverts obj face_index)
			
			for i = 1 to edges.count do
			(
				local edge_verts
				local tv1, tv2, tv3
	 
				if i == edges.count-1 then
				(
					tv1 = (tag_getMapVert obj map_channel face_index verts[i])
					tv2 = (tag_getMapVert obj map_channel face_index verts[i+1])
					tv3 = (tag_getMapVert obj map_channel face_index verts[1])
				)
				else if i == edges.count then
				(
					tv1 = (tag_getMapVert obj map_channel face_index verts[i])
					tv2 = (tag_getMapVert obj map_channel face_index verts[1])
					tv3 = (tag_getMapVert obj map_channel face_index verts[2])
				)
				else
				(
					tv1 = (tag_getMapVert obj map_channel face_index verts[i+0])
					tv2 = (tag_getMapVert obj map_channel face_index verts[i+1])
					tv3 = (tag_getMapVert obj map_channel face_index verts[i+2])
					
				)
				
				local edge1_vect = normalize (tv2 - tv1)
				local edge2_vect = normalize (tv3 - tv1)
		
				-- (cross edge1_vect edge2_vect)
				sum += (cross edge1_vect edge2_vect).z
			)
		)
		
		(sum <= 0)
	)
	 
	---------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------
	 
	fn TAG objs	map_channel:1
				texture_atlas_filename:"C:\\TEMP\\TESTTEXTUREATLAS.tga"
				padding:2
				padding_tresize:true
				do_undo:off
				do_slicing:true
				do_generate_ta:true
				do_msgs:false
				do_break_all:false
				do_force_padding:false
				do_ignore_errors:false
				=						
	(
		if objs.count == 0 do
			return -1
		
		local tag_objs = #()
		for o in objs where (((classOf o == Editable_Poly) or (classOf o == PolyMeshObject)) and ((classOf o.material == Standardmaterial) or (classOf o.material == Multimaterial))) do
			append tag_objs o

		if tag_objs.count == 0 do
		(
			messagebox "Select correct object type, with correct material type!"
			return -1
		)
		
		-- get rid of instanced objects!
		local instances
		for i = 1 to tag_objs.count do with undo do_undo
			if tag_objs[i] != #empty do
				if (InstanceMgr.GetInstances tag_objs[i] &instances) > 1 do
					for i2 = i+1 to tag_objs.count do
						for j in instances do
							if tag_objs[i2] == j do
								tag_objs[i2] = #empty
		local is_too_much = -1
		do
		(
			is_too_much = (findItem tag_objs #empty)
			if is_too_much != 0 do deleteItem tag_objs is_too_much
		) while is_too_much != 0
			
		if do_msgs do format "TAG begins.\n"

		if (objs.count-tag_objs.count) > 0 and do_msgs do format "... % objects won't be manipulated (wrong class or material, or were instances)\n" (objs.count-tag_objs.count)

		local textures = #()
		local cutted_textures = #{} -- special feature: uvmaps don't have padding
									-- no texture will have padding when slicing isn't needed, that's a bug ...
		struct SMaterialInfo
		(
			mats_in_multi_used = #{}, -- materials can have different ids than their position in multimaterial ...
			mmat_ids = #(),
			num_materials_used = 0,
			mmatid_to_texid = #()
		)
		local material_info = #()
		material_info[tag_objs.count] = 0
		
		-------------------------------------------------------------
		-- begin loop		
		local o = 0
		for real_obj in tag_objs do with undo do_undo
		(
			o += 1
			local obj = real_obj

			if do_slicing or do_force_padding do
			(
				-- this is a workaround for max 9, because collapseNodeTo is buggy
				obj = editable_mesh()
				obj.baseobject = copy real_obj.baseobject
				local save_obj = real_obj.baseobject
				hide real_obj
				convertTo obj PolyMeshObject
			)
		
			select obj
			setCommandPanelTaskMode #modify
			
			if do_msgs do format "Analyzing and manipulating % ...\n" real_obj.name
			
			local facecount = obj.faces.count
	 		local is_UVmapped = false
			
			if do_msgs do format "... % has % faces\n" real_obj.name facecount
		 
			material_info[o] = SMaterialInfo()
			
			local faces_cutplanes = #()
			if do_slicing do faces_cutplanes[facecount] = #()
		 
			-------------------------
			-------------------------
			-- Preparation: Test for UV faces - are their areas too small? Does it have a UV map?
			-------------------------
			
			if do_slicing do
			(
				-- look for modifiers ...
				if real_obj.modifiers.count > 0 do
					for mod in real_obj.modifiers do
						if (classOf mod) == Unwrap_UVW or (classOf mod) == Uvwmap do
						(
							if not do_ignore_errors do
							(
								local ss = stringStream ""
								format "% has at least one modifier which manipulates the meshes' UV coordinates. If you want to see TAG's effect, you probably will have to delete/deactivate it." real_obj.name to:ss
								messagebox (ss as string)
							)
							if do_msgs do format "... Warning: % has UVW modifier!\n" real_obj.name
						)
				
				-- map channel doesn't seem to be updated otherwise, hmm ...
				local uvwmod = Unwrap_UVW()
				addModifier obj uvwmod
				uvwmod.setMapChannel map_channel
				uvwmod.setConstantUpdate false
				uvwmod.setShowSelectedVertices false
				uvwmod.updateView()
				uvwmod.setTVSubObjectMode 3

				-- first test: is the object uv mapped?
				local x, y, width, height, areaUVW, areaGeom
				uvwmod.getArea #{1..facecount} &x &y &width &height &areaUVW &areaGeom
				is_UVmapped = ((x >= 0.001) and (x+width <= 0.999) and (y >= 0.001) and (y+height <= 0.999))

				deleteModifier obj uvwmod

				if not is_UVmapped do
				(
					local error_faces = #{}
					local meshmod = Turn_to_Mesh() -- getting area with getArea() only works with mesh, not poly 
					addModifier obj meshmod
					uvwmod = Unwrap_UVW()
					addModifier obj uvwmod
					uvwmod.setMapChannel map_channel
					uvwmod.setConstantUpdate false
					uvwmod.setShowSelectedVertices false
					uvwmod.updateView()
					uvwmod.edit()
					uvwmod.setTVSubObjectMode 3
	
					local polycount = uvwmod.numberPolygons()
					for f = 1 to polycount do
					(
						uvwmod.getArea #{f} &x &y &width &height &areaUVW &areaGeom
						if (width < 0.0001 or height < 0.0001 or areaUVW < 0.0001) and areaGeom > 0.01 do
							append error_faces f
					)
					
					if error_faces.count > 0 then
					(
						local resume_process = true
						if not do_ignore_errors then resume_process = queryBox "Errors in UVWs! Do you want to continue? Press \"No\" to stop the process and check the problematic faces selected in an Unwrap Modifier. Click \"Yes\" to resume anyway, with the risk of a bad result."
						if not resume_process then
						(
							-- from the workaround
							addmodifier real_obj meshmod
							addmodifier real_obj uvwmod
							unhide real_obj
							select real_obj
							
							uvwmod.selectFaces error_faces
							uvwmod.edit()
							uvwmod.setTVSubObjectMode 3
							if do_msgs do format "Stopped because of % errors in %!\n" error_faces.count real_obj.name
							delete obj
							return -1
						)
						if do_msgs do format "Probably % errors in mesh(!) of %, i.e. those map faces are too small/thin!\n" error_faces.count real_obj.name
					)
				
					deleteModifier obj uvwmod
					deleteModifier obj meshmod
				)
			)
			
			------------------------
			------------------------
			-- First step: analyze the model and save the slice planes in an array
			------------------------
			
			setCommandPanelTaskMode #create
			
			if (do_slicing or do_force_padding) and not is_UVmapped then
			(
				local faces_cutplanes_count = 0
				local textures_used = 0
				if do_msgs do format "... analyzing %'s uvs and geometry ...\n" real_obj.name
				
				for f = 1 to facecount do with undo do_undo
				(
					-- it's likely that we need some sliceplanes for some faces
					faces_cutplanes[f] = #()

					local act_edges = (polyop_getfaceedges obj f)					
					if act_edges != undefined do
					(
						local edgecount = act_edges.count
						
						edge_cutpoints_x = #() -- count is same as edgecount at the end
						edge_cutpoints_y = #()
						
						local is_mirrored = checkMirror obj map_channel f
						
						-- build two tables: one with so called x-points, the other one with y-points
						-- e.g. x-points are all at texture uv with y = ...,-1.0,0.0,1.0,2.0,...
						-- so I have to save the min value (e.g. -1.0), in min_y
						--
						-- it has to be guaranteed that the table with the x-points
						-- will be filled correctly (no gaps), so find the right pos (e.g. [3] for 1.0)
						
						-- find the minimum texture coords		
						local absminx = 1000000
						local absminy = 1000000
						
						for i in act_edges do with undo do_undo
						(
							local vertices = (tag_getEdgeVerts obj f i)
				
							local tv1 = (tag_getMapVert obj map_channel f vertices[1])
							local tv2 = (tag_getMapVert obj map_channel f vertices[2])
							
							local minx = if tv1.x < tv2.x then tv1.x else tv2.x
							local miny = if tv1.y < tv2.y then tv1.y else tv2.y
							
							absminx = if absminx < minx then absminx else minx
							absminy = if absminy < miny then absminy else miny
						)
						
						absminx = (ceil(absminx)) as integer
						absminy = (ceil(absminy)) as integer
						
						-- save cutting points for every edge
						-- those cutting points are found at every x/y-axis of texture uvs
						for i in act_edges do with undo do_undo
						(
							local vertices = (tag_getEdgeVerts obj f i)
							
							local tv1 = (tag_getMapVert obj map_channel f vertices[1])
							local tv2 = (tag_getMapVert obj map_channel f vertices[2])
							tv1 = [tv1.x, tv1.y] -- convert to Point2
							tv2 = [tv2.x, tv2.y]
							local dir = tv2-tv1
							
							local minx = if tv1.x < tv2.x then tv1.x else tv2.x
							local maxx = if tv1.x >= tv2.x then tv1.x else tv2.x
							local miny = if tv1.y < tv2.y then tv1.y else tv2.y
							local maxy = if tv1.y >= tv2.y then tv1.y else tv2.y
							
							-- the x-axes ( ... -2, -1, 0, 1, ...)
							local tempx = (ceil(minx)) as float
							while tempx < ceil(maxx) do
							(
								local new_percent = (tempx-tv1.x)/dir.x
								local new_vect = dir*new_percent
								
								-- get the cutpoint in 3d space
								local new_dir = (tag_getVertex obj vertices[2]) - (tag_getVertex obj vertices[1])
								local new_point = (tag_getVertex obj vertices[1]) + (new_dir*new_percent)
								
								if edge_cutpoints_x[tempx-absminx+1] == undefined do
									edge_cutpoints_x[tempx-absminx+1] = #()
									
								append edge_cutpoints_x[tempx-absminx+1] #(i, new_point, tv1.y + new_vect.y, tempx) -- edgenumber, point, texcoords
									
								tempx += 1
							)
							
							-- the y-axes ( ... -2, -1, 0, 1, ...)			
							local tempy = (ceil(miny)) as integer
							while tempy < ceil(maxy) do with undo do_undo
							(
								local new_percent = (tempy-tv1.y)/dir.y
								local new_vect = dir*new_percent
								
								-- get the cutpoint in 3d space
								local new_dir = (tag_getVertex obj vertices[2]) - (tag_getVertex obj vertices[1])
								local new_point = (tag_getVertex obj vertices[1]) + (new_dir*new_percent)
								
								if edge_cutpoints_y[tempy-absminy+1] == undefined do
									edge_cutpoints_y[tempy-absminy+1] = #()
				
								append edge_cutpoints_y[tempy-absminy+1] #(i, new_point, tv1.x + new_vect.x, tempy) -- edgenumber, coord, texcoords
								
								tempy += 1
							)				
						)
						
						-- get the points, get their position in 3d-space, build a sliceplane
						-- we have to check if edges cross (they shouldn't)
						-- first: for y
						for i = 1 to edge_cutpoints_y.count do with undo do_undo
						(
							local allpoints = deepCopy edge_cutpoints_y[i]
							local points = edge_cutpoints_y[i]
							local act_point_i = 0
							
							while points.count > 1 do
							(
								act_point_i += 1
								local act_edge = copy points[1][1]
								local act_point = copy points[1][2]
								local act_TC = copy points[1][3]
								local act_TC2 = copy points[1][4]
								
								-- get the first point (the active one) out of the list
								deleteItem points 1
										
								-- and test it against every other point on the same "line"
								for other_points_i = 1 to points.count do with undo do_undo
								(
									local other_edge = points[other_points_i][1]
									local other_point = points[other_points_i][2]
									local other_TC = copy points[other_points_i][3]
									
									-- find out if other edges are crossing
									local is_near = true
									for test_points_i = 1 to allpoints.count while is_near do
									(
										if test_points_i != act_point_i and test_points_i != (act_point_i+other_points_i) do
										(
											local test_TC = allpoints[test_points_i][3]
											if act_TC < other_TC then
												if test_TC >= act_TC and test_TC <= other_TC do is_near = false
											else
												if test_TC <= act_TC and test_TC >= other_TC do is_near = false
										)
									)
									if is_near do
									(				
										-- angle between edges ...
										local verta = tag_getEdgeVerts obj f act_edge
										local verto = tag_getEdgeVerts obj f other_edge
								
										local tva1 = (tag_getMapVert obj map_channel f verta[1])
										local tva2 = (tag_getMapVert obj map_channel f verta[2])
										local tvo1 = (tag_getMapVert obj map_channel f verto[1])
										local tvo2 = (tag_getMapVert obj map_channel f verto[2])
					
										-- which one is on the left?
										local going_on = true
										if not is_mirrored then
										(
											if act_TC < other_TC then
												if (tva1.y <= tva2.y) do going_on = false
											else
												if (tvo1.y <= tvo2.y) do going_on = false
										)
										else
										(
											if act_TC < other_TC then
												if (tva1.y >= tva2.y) do going_on = false
											else
												if (tvo1.y >= tvo2.y) do going_on = false
										)
										
										if going_on do
										(
											local plane_normal = cross (polyop_getfacenormal obj f) (other_point-act_point)
											plane_normal = normalize plane_normal
																
											append faces_cutplanes[f] #(act_point, plane_normal, false, act_TC2) -- center, normal, is-x-axis, which axis
											faces_cutplanes_count += 1
										)
									)
								)
							)
						)
						
						-- the same for x
						for i = 1 to edge_cutpoints_x.count do with undo do_undo
						(
							local allpoints = deepCopy edge_cutpoints_x[i]
							local points = edge_cutpoints_x[i]
							local act_point_i = 0
							
							while points.count > 1 do
							(
								act_point_i += 1
								local act_edge = copy points[1][1]
								local act_point = copy points[1][2]
								local act_TC = copy points[1][3]
								local act_TC2 = copy points[1][4]
								
								-- get the first point (the active one) out of the list
								deleteItem points 1
										
								-- and test it against every other point on the same "line"
								for other_points_i = 1 to points.count do with undo do_undo
								(
									local other_edge = points[other_points_i][1]
									local other_point = points[other_points_i][2]
									local other_TC = points[other_points_i][3]
									
									-- find out if other edges are crossing
									local is_near = true
									for test_points_i = 1 to allpoints.count while is_near do
									(
										if test_points_i != act_point_i and test_points_i != (act_point_i+other_points_i) do
										(
											local test_TC = allpoints[test_points_i][3]
											if act_TC < other_TC then
												if test_TC >= act_TC and test_TC <= other_TC do is_near = false
											else
												if test_TC <= act_TC and test_TC >= other_TC do is_near = false
										)
									)
									
									if is_near do
									(
										-- angle between edges ...
										local verta = tag_getEdgeVerts obj f act_edge
										local verto = tag_getEdgeVerts obj f other_edge
								
										local tva1 = (tag_getMapVert obj map_channel f verta[1])
										local tva2 = (tag_getMapVert obj map_channel f verta[2])
										local tvo1 = (tag_getMapVert obj map_channel f verto[1])
										local tvo2 = (tag_getMapVert obj map_channel f verto[2])
					
										-- which one is on the left?
										local going_on = true
										if not is_mirrored then
										(
											if act_TC < other_TC then
												if (tva1.x >= tva2.x) do going_on = false
											else
												if (tvo1.x >= tvo2.x) do going_on = false
										)
										else
										(
											if act_TC < other_TC then
												if (tva1.x <= tva2.x) do going_on = false
											else
												if (tvo1.x <= tvo2.x) do going_on = false
										)
							
										if going_on do
										(
											local plane_normal = cross (polyop_getfacenormal obj f) (other_point-act_point)
											plane_normal = normalize plane_normal
											
											append faces_cutplanes[f] #(act_point, plane_normal, true, act_TC2) -- center, normal, is-x-axis, which axis
											faces_cutplanes_count += 1
										)
									)
								)
							)
						)
				
						if (classOf real_obj.material) == Multimaterial do
						(
							-- count materials, for later use
							local real_mat_id = obj.GetFaceMaterial f
							local id_in_mmat = findItem real_obj.material.materialIDList real_mat_id
							
							-- wasn't the material saved before?
							if material_info[o].mats_in_multi_used[id_in_mmat] == false do
							(
								material_info[o].mats_in_multi_used[id_in_mmat] = true
								append material_info[o].mmat_ids id_in_mmat
								local tex_id
								try
								(
									tex_id = findItem textures real_obj.material.materialList[id_in_mmat].diffuseMap.filename
								)
								catch
								(
									-- from the workaround
									select real_obj
									unhide real_obj
									delete obj

									messagebox "Error in materials! Are you really using multi and standard materials only?"
									return -1
								)
								if tex_id == 0 then
								(
									append textures real_obj.material.materialList[id_in_mmat].diffuseMap.filename
									material_info[o].mmatid_to_texid[id_in_mmat] = textures.count
									textures_used += 1
								)
								else
									material_info[o].mmatid_to_texid[id_in_mmat] = tex_id
								
								material_info[o].num_materials_used += 1
							)
						)
					)
				)

				if (classOf real_obj.material) == Multimaterial and do_msgs do format "...... found % materials with % new textures\n" material_info[o].num_materials_used textures_used		 
				if do_msgs do format "...... % slice planes need to be generated\n" faces_cutplanes_count
				
				obj.preserveUVs = true
		 
			)
			else -- if not do_slicing or is_UVmapped then
			(
				if (classOf real_obj.material) == Multimaterial do
				(
					local textures_used = 0
					
					for f = 1 to facecount do with undo do_undo
					(
						-- count materials, for later use
						local real_mat_id = obj.GetFaceMaterial f
						local id_in_mmat = findItem real_obj.material.materialIDList real_mat_id
						
						if id_in_mmat == 0 do
						(
							-- from the workaround
							select real_obj
							unhide real_obj
							delete obj
							
							messagebox "Multimaterial or object with multimaterial has errors!"
							format "Error: Material ID not found!\n"
							return -1
						)
						
						-- wasn't the material saved before?
						if material_info[o].mats_in_multi_used[id_in_mmat] == false do
						(
							material_info[o].mats_in_multi_used[id_in_mmat] = true
							append material_info[o].mmat_ids id_in_mmat
							local tex_id
							try
							(
								tex_id = findItem textures real_obj.material.materialList[id_in_mmat].diffuseMap.filename
							)
							catch
							(
								-- from the workaround
								select real_obj
								unhide real_obj
								delete obj

								messagebox "Error in materials! Are you really using multi and standard materials with bitmaps only?"
								return -1
							)
							if tex_id == 0 then
							(
								append textures real_obj.material.materialList[id_in_mmat].diffuseMap.filename
								material_info[o].mmatid_to_texid[id_in_mmat] = textures.count
								textures_used += 1
							)
							else
								material_info[o].mmatid_to_texid[id_in_mmat] = tex_id
							
							material_info[o].num_materials_used += 1
						)
					)			

					if do_msgs do format "...... % has % materials with % new textures\n" real_obj.name material_info[o].num_materials_used textures_used
				)
			)
			
			if (classOf real_obj.material) == Standardmaterial do
			(
				material_info[o].mats_in_multi_used[1] = true
				material_info[o].mmat_ids[1] = 1
				local tex_id
				try
				(
					tex_id = findItem textures real_obj.material.diffuseMap.filename
				)
				catch
				(
					if do_slicing or do_force_padding do
					(
						select real_obj
						unhide real_obj
						delete obj
					)
					messagebox "Error in materials! Are you really using multi and standard materials with bitmaps only?"
					return -1
				)				
				if tex_id == 0 then
				(
					append textures real_obj.material.diffuseMap.filename
					material_info[o].mmatid_to_texid[1] = textures.count
					if do_msgs do format "...... % has only one material with a new texture\n" real_obj.name
				)
				else
				(
					material_info[o].mmatid_to_texid[1] = tex_id
					if do_msgs do format "...... % has only one material with no new texture\n" real_obj.name
				)
					
				material_info[o].num_materials_used = 1
			)
			
			----------------------------
			----------------------------
			-- Second step: slice the geometry
			----------------------------

			if do_slicing and not is_UVmapped do
			(
				if do_msgs do format "... %: slicing geometry\n" real_obj.name
				
				-- the slicing begins
				for f = 1 to facecount do with undo do_undo
				(
					-- get the material and look if it's cutted ... to find out uvmaps, y'know?
					if faces_cutplanes[f].count > 0 then
					(
						local old_edgecount = obj.edges.count
						
						setFaceSelection obj #(f)
				
						local act_verts = obj.numVerts
						
						for i = 1 to faces_cutplanes[f].count do with undo do_undo
						(
							local active_faces = getFaceSelection obj
							local success = (tag_slice obj active_faces faces_cutplanes[f][i][2] faces_cutplanes[f][i][1])
							
							if success == false do
							(
								local going_on = true
								if not do_ignore_errors do going_on = querybox "A specific face couldn't be sliced, which will result in a incorrect UV map.\nCheck your UVs and Geometry, please. Continue anyway?"
								if not going_on do
								(
									-- from the workaround
									delete obj
									select real_obj
									obj = real_obj
								
									uvwmod = Unwrap_UVW()
									addModifier obj uvwmod
									uvwmod.setMapChannel map_channel
									uvwmod.updateView()
									uvwmod.selectFaces active_faces
									uvwmod.edit()
									uvwmod.setTVSubObjectMode 3
									return -1
								)
							)
								
							local xaxis = faces_cutplanes[f][i][3]
							local tc_val = faces_cutplanes[f][i][4]
							
							for j = act_verts+1 to obj.numVerts do with undo do_undo
							(
								local tv = (tag_getMapVert obj map_channel (getFaceSelection obj) j)
								if xaxis then tv.x = tc_val else tv.y = tc_val
								tag_setMapVert obj map_channel (getFaceSelection obj) j tv
							)			
							
							act_verts = obj.numVerts
						)
					)
				)
			)

			--------------------------
			--------------------------
			-- Intermission! Check if materials are cutted ...
			--------------------------

			setCommandPanelTaskMode #modify

			if do_slicing or (do_generate_ta and do_force_padding) do
			(
				select obj
				uvwmod = Unwrap_UVW()
				addModifier obj uvwmod
				uvwmod.setMapChannel map_channel
				uvwmod.updateView()
				uvwmod.setResetPivotOnSelection true
				uvwmod.setTVSubObjectMode 3
				
				if (classOf real_obj.material) == Multimaterial then
				(
					local x, y, width, height, temp
					-- iterate through all material ids to check if they need padding
					for i = 1 to material_info[o].num_materials_used do with undo do_undo
					(
						local bmp_id = material_info[o].mmatid_to_texid[material_info[o].mmat_ids[i]]
						if not cutted_textures[bmp_id] do
						(
							uvwmod.selectByMatID material_info[o].mmat_ids[i]
							uvwmod.getArea (uvwmod.getSelectedPolygons()) &x &y &width &height &temp &temp
							if not (((x >= 0.001) and (x+width <= 0.999) and (y >= 0.001) and (y+height <= 0.999))) do
								cutted_textures[bmp_id] = true
						)				
					)
				)
				else
				(
					local x, y, width, height, temp
					uvwmod.getArea #{1..facecount} &x &y &width &height &areaUVW &areaGeom
					if not (((x >= 0.001) and (x+width <= 0.999) and (y >= 0.001) and (y+height <= 0.999))) do
						cutted_textures[material_info[o].mmatid_to_texid[1]] = true
				)
						
				deleteModifier obj uvwmod
			)
			
			--------------------------
			--------------------------
			-- Third step: "normalize" the texture coords, i.e. break and move all chunks into the range 0.0..1.0
			--------------------------
			
			if do_slicing and not is_UVmapped do
			(
				select obj
				uvwmod = Unwrap_UVW()
				addModifier obj uvwmod
				uvwmod.setMapChannel map_channel
				uvwmod.updateView()
				uvwmod.setResetPivotOnSelection true
				-- uvwmod.setConstantUpdate false
				uvwmod.setShowSelectedVertices false
				uvwmod.edit()				
				uvwmod.setTVSubObjectMode 1				
				uvwmod.selectVertices #{1..uvwmod.numberVertices()}
				uvwmod.vertToEdgeSelect()
				local num_tedges = (uvwmod.getSelectedEdges()).count				

				if do_break_all then
				(
					uvwmod.setTVSubObjectMode 2
					if do_msgs do format "... %: normalizing tex coords, breaking all % edges\n" real_obj.name num_tedges
					uvwmod.breakSelected()
				)
				else
				(
					if do_msgs do format "... %: normalizing tex coords, analyzing % edges ...\n" real_obj.name num_tedges	
					uvwmod.selectVertices #{}
					uvwmod.setTVSubObjectMode 2
					local edges_to_break = #{}
					local vert_indices
					local vert1, vert2
					local uvwmod_selectedges = uvwmod.selectEdges
					local uvwmod_edgetovertselect = uvwmod.edgeToVertSelect
					local uvwmod_getselectedvertices = uvwmod.getSelectedVertices
					local uvwmod_getvertexposition = uvwmod.getVertexPosition

					-- find the edges to break
					-- this little piece of code is the (extreme) bottleneck in big meshes ...
					local start = timeStamp()
					for i = 1 to num_tedges do with undo do_undo
					(
						uvwmod_selectedges #{i}
						uvwmod_edgetovertselect()
						local vert_indices = uvwmod_getselectedvertices() as Array
						vert1 = (uvwmod_getvertexposition 0 vert_indices[1])
						vert2 = (uvwmod_getvertexposition 0 vert_indices[2])
						if (tag_equal_int (floor (vert1.x+0.5)) vert1.x) and (tag_equal_int vert1.x vert2.x) then
							edges_to_break[i] = true
						else if (tag_equal_int (floor (vert1.y+0.5)) vert1.y) and (tag_equal_int vert1.y vert2.y) do
							edges_to_break[i] = true
					)
					local end = timeStamp()
					
					uvwmod_selectedges edges_to_break
					uvwmod.breakSelected()
					
					if do_msgs do format "...... broke % of % texture edges in % secs\n" edges_to_break.numberSet num_tedges ((end - start)/1000)
				)

				convertTo obj PolyMeshObject
				-- maxOps.CollapseNodeTo obj 1 off
				
				uvwmod = Unwrap_UVW()
				addModifier obj uvwmod
				uvwmod.setMapChannel map_channel
				uvwmod.setResetPivotOnSelection true
				uvwmod.setConstantUpdate false
				uvwmod.setShowSelectedVertices false
				uvwmod.setTVSubObjectMode 3

				-- moving all the chunks
				local num_polys = uvwmod.numberPolygons()
				local x, y, temp
				if do_break_all then
				(
					for i = 1 to num_polys do with undo do_undo
					(
						uvwmod.selectFaces #{i}
						local x_move = 0.0
						local y_move = 0.0
						uvwmod.getArea #{i} &x &y &temp &temp &temp &temp
						while x < 0.0 do (x += 1.0; x_move += 1.0)
						while x >= 0.999 do (x -= 1.0; x_move -= 1.0)
						while y < 0.0 do (y += 1.0; y_move += 1.0)
						while y >= 0.999 do (y -= 1.0; y_move -= 1.0)
						uvwmod.moveSelected [x_move, y_move, 0.0]
					)
				)
				else
				(
					local poly_is_edited = #{}
					for i = 1 to num_polys do with undo do_undo
					(
						if not poly_is_edited[i] do
						(						
							uvwmod.selectFaces #{i}
							
							local do_expand = true
							local old_selected_number
							local selected_polys = #{}
							do
							(
								old_selected_number = (uvwmod.getSelectedPolygons()).numberSet
								uvwmod.expandSelection()
								selected_polys = uvwmod.getSelectedPolygons()
								if selected_polys.numberSet == old_selected_number do do_expand = false
							) while do_expand
							uvwmod.breakSelected() --- cleaning up - some vertices may have "survived" the breaking before
							
							join poly_is_edited selected_polys
							
							local x_move = 0.0
							local y_move = 0.0
							uvwmod.getArea selected_polys &x &y &temp &temp &temp &temp
							while x < 0.0 do (x += 1.0; x_move += 1.0)
							while x >= 0.999 do (x -= 1.0; x_move -= 1.0)
							while y < 0.0 do (y += 1.0; y_move += 1.0)
							while y >= 0.999 do (y -= 1.0; y_move -= 1.0)
							uvwmod.moveSelected [x_move, y_move, 0.0]
						)
					)
				)
				
				convertTo obj PolyMeshObject
				-- maxOps.CollapseNodeTo obj 1 off
			)
			
			if real_obj != obj do
			(
				-- continue the workaround, *sigh*
				real_obj.baseobject = obj.baseobject
				for geo in geometry do if geo.baseobject == save_obj then geo.baseobject = obj.baseobject
				delete obj
				unhide real_obj
			)
		)
			
		if do_msgs and (do_slicing or do_generate_ta) do format "TAG will make a texture atlas now.\n"

		--------------------------
		--------------------------
		-- Fourth step: rendering a texture atlas
		--------------------------
		
		local area_of_all_textures = 0	
		local num_textures = textures.count 
		struct SBitmap
		(
			bmp,
			filename,
			rotated = false, -- counterclockwise 90 degrees, or not
			area,
			height,
			width,
			x = -100,
			y = -100,
			is_cutted,
			fn rotate = ( (swap height width); rotated = not rotated )
		)
		bitmaps = #()
		bitmaps[num_textures] = undefined -- pre-size the array
		
		if do_slicing or do_generate_ta do
		(
			if do_msgs and do_generate_ta do format "Packing % textures\n" num_textures
		
			-- iterate through all material ids
			for i = 1 to num_textures do with undo do_undo
			(
				-- prepare the textures
				sbmp = SBitmap()
				try
				(
					sbmp.bmp = openBitmap textures[i]
				)
				catch
				(
					messagebox "One of the textures couldn't be found! (Probably wrong path.)\n Please select the correct one."
					local new_bmp = getOpenFileName caption:"Select Texture" filename:textures[i]
					if new_bmp == undefined then
					(
						if do_msgs do format "Aborted texture packing!\nError: % wasn't found.\n" textures[i]
						return -1
					)
					else
						sbmp.bmp = openBitmap new_bmp
				)
				
				sbmp.filename = textures[i]
				sbmp.width = sbmp.bmp.width
				sbmp.height = sbmp.bmp.height
				sbmp.is_cutted = cutted_textures[i]
				if sbmp.is_cutted do
				(
					sbmp.width += if not padding_tresize then (2*padding) else 0
					sbmp.height += if not padding_tresize then (2*padding) else 0
				)
				sbmp.area = sbmp.width * sbmp.height
				bitmaps[i] = sbmp
				
				area_of_all_textures += sbmp.area
			)
			
			-- sort the textures, biggest first
			fn compareSBMP v1 v2 =
			(
				if v1.area < v2.area then 1
				else if v1.area == v2.area then 0
				else -1
			)
			
			-- get the size of the texture atlas
			local size_of_texatlas_x = (sqrt area_of_all_textures)
			local size_of_texatlas_y
			local i = 0
			while size_of_texatlas_x > 0 do
			(
				size_of_texatlas_x = bit.shift size_of_texatlas_x -1
				i += 1
			)
			size_of_texatlas_y = size_of_texatlas_x = bit.shift 1 (i-1)
		
			-- manage the trunks and the textures
			fn add_to_trunk trunks_array trunk_index bitmaps_array bitmap_index =
			(
				-- bitmap fits exactly:
				if bitmaps_array[bitmap_index].width == trunks_array[trunk_index][3] and bitmaps_array[bitmap_index].height == trunks_array[trunk_index][4] then
				(
					bitmaps_array[bitmap_index].x = trunks_array[trunk_index][1]
					bitmaps_array[bitmap_index].y = trunks_array[trunk_index][2]
					deleteItem bitmaps_array bitmap_index
					deleteItem trunks_array trunk_index
				)
				else -- it's smaller
				(
					bitmaps_array[bitmap_index].x = trunks_array[trunk_index][1]
					bitmaps_array[bitmap_index].y = trunks_array[trunk_index][2]
					
					-- create a new trunk
					append trunks_array #(	trunks_array[trunk_index][1]+bitmaps_array[bitmap_index].width,
											trunks_array[trunk_index][2],
											trunks_array[trunk_index][3]-bitmaps_array[bitmap_index].width,
											bitmaps_array[bitmap_index].height)
					-- make the old one smaller
					trunks_array[trunk_index][2] += bitmaps_array[bitmap_index].height
					trunks_array[trunk_index][4] -= bitmaps_array[bitmap_index].height
		
					deleteItem bitmaps_array bitmap_index
				)
				
				-- sort the trunks
				fn compareTRUNKS v1 v2 =
				(
					if v1[3]*v1[4] > v2[3]*v2[4] then  1
					else if v1[3]*v1[4] == v2[3]*v2[4] then 0
					else -1
				)
				qsort trunks_array compareTRUNKS
			)
			
			-- fill the texture atlas, virtually
			local act_trk = 1
			local done_packing
			local resize_switch = true
			do with undo do_undo -- the packing
			(
				local free_trunks = #(#(0, 0, size_of_texatlas_x, size_of_texatlas_y)) -- x,y,w,h
				local rest_bitmaps = copy bitmaps #noMap
				qsort rest_bitmaps compareSBMP
			
				while true do
				(
					if rest_bitmaps.count == 0 do
					(
						done_packing = true
						exit
					)
					if free_trunks.count == 0 do
					(
						-- texture too small ...
						done_packing = false
						exit
					)
			
					local found_fitting_bitmap = false
					for act_bmp = 1 to rest_bitmaps.count while not found_fitting_bitmap do
					(
						-- get the smallest trunk & the biggest texture which fit
						if rest_bitmaps[act_bmp].width <= free_trunks[act_trk][3] and rest_bitmaps[act_bmp].height <= free_trunks[act_trk][4] then
						(
							add_to_trunk free_trunks act_trk rest_bitmaps act_bmp
							found_fitting_bitmap = true
						)
						else if rest_bitmaps[act_bmp].width <= free_trunks[act_trk][4] and rest_bitmaps[act_bmp].height <= free_trunks[act_trk][3] then
						(
							rest_bitmaps[act_bmp].rotate()
							add_to_trunk free_trunks act_trk rest_bitmaps act_bmp
							found_fitting_bitmap = true
						)
					)
					-- the trunk is too small (or slim) for any remaining texture
					if not found_fitting_bitmap do
						deleteItem free_trunks act_trk
				)
				if not done_packing do -- resize the tex texture
				(
					 if resize_switch then size_of_texatlas_y = 2*size_of_texatlas_y
					 else size_of_texatlas_x = 2*size_of_texatlas_x
						
					 resize_switch = not resize_switch
					 
					 for sbmp in bitmaps where sbmp.rotated do sbmp.rotate()					 	
				)
			) while done_packing == false
		)
		
		if do_generate_ta do
		(	
			-- create the texture atlas, at last
			local texture_atlas
			try
			(
				texture_atlas = Bitmap size_of_texatlas_x size_of_texatlas_y
			)
			catch
			(
				messagebox "The texture atlas couldn't be generated because Max ran out of Memory.\nTry restarting max, wireframe view and/or a renderfarm ..."
				format "Error! Couldn't generate bitmap for texture atlas with size %*%!\n" size_of_texatlas_x size_of_texatlas_y
				return -1
			)
			texture_atlas.filename = texture_atlas_filename
			
			if do_msgs do format "Drawing the texture atlas with size %*% ...\n" size_of_texatlas_x size_of_texatlas_y
			
			-- draw the textures into the atlas
			for sbmp in bitmaps do with undo do_undo
			(
				if do_msgs do format "... adding %\n" sbmp.filename
		
				if sbmp.x < 0 do continue -- should not happen, y'know?!
				
				-- no padding for uv mapped objects, right?
				local tp = padding
				if not sbmp.is_cutted do tp = 0
				
				-- but don't forget the padding!
				local temp_bitmap = sbmp.bmp
				if tp > 0 and padding_tresize then
				(
					if sbmp.bmp.width <= (tp*2) or sbmp.bmp.height <= (tp*2) do
					(
						messagebox "Padding number too big! Check your texture sizes!"
						return -1
					)
					temp_bitmap = Bitmap (sbmp.bmp.width-(tp*2)) (sbmp.bmp.height-(tp*2))
					copy sbmp.bmp temp_bitmap
				)
				local pixels
				
				if not sbmp.rotated then
				(
					for i = 0 to temp_bitmap.height-1 do
					(
						pixels = getPixels temp_bitmap [0, i] temp_bitmap.width
						setPixels texture_atlas [tp+sbmp.x, tp+sbmp.y+i] pixels
					)
				)
				else -- rotate the texture CCW
				(
					for i = 0 to temp_bitmap.height-1 do
					(
						local pixels = getPixels temp_bitmap [0, i] temp_bitmap.width
						for j = 0 to temp_bitmap.width-1 do
							setPixels texture_atlas [tp+sbmp.x+i, tp+sbmp.y+temp_bitmap.width-(j+1)] #(pixels[j+1])
					)			
				)
				close temp_bitmap
				
				-- the frame (padding)
				if tp > 0 do
				(
					local ox, oy, nw, nh
					ox = sbmp.x+tp -- origin x, y
					oy = sbmp.y+tp
					nw = sbmp.width-(tp*2) -- new width, height
					nh = sbmp.height-(tp*2)
					
					-- top
					pixels = getPixels texture_atlas [ox, oy] nw
					for i = 0 to tp-1 do
						setPixels texture_atlas [ox, sbmp.y+i] pixels
					-- bottom
					pixels = getPixels texture_atlas [ox, oy+nh-1] nw
					for i = 0 to tp-1 do
						setPixels texture_atlas [ox, oy+nh+i] pixels
					for i = 0 to nh-1 do
					(
						-- left
						pixels = getPixels texture_atlas [ox, oy+i] 1
						for j = 0 to tp-2 do append pixels pixels[1]
						setPixels texture_atlas [sbmp.x, oy+i] pixels
						-- right
						pixels = getPixels texture_atlas [ox+nw-1, oy+i] 1
						for j = 0 to tp-2 do append pixels pixels[1]
						setPixels texture_atlas [ox+nw, oy+i] pixels
					)
					-- the corners
					local pixels_lt = getPixels texture_atlas [ox, oy] 1
					local pixels_rt = getPixels texture_atlas [ox+nw-1, oy] 1
					local pixels_lb = getPixels texture_atlas [ox, oy+nh-1] 1
					local pixels_rb = getPixels texture_atlas [ox+nw-1, oy+nh-1] 1
					for j = 0 to tp-2 do
					(
						append pixels_lt pixels_lt[1]
						append pixels_rt pixels_rt[1]
						append pixels_lb pixels_lb[1]
						append pixels_rb pixels_rb[1]
					)
					for i = 0 to tp-1 do
					(
						setPixels texture_atlas [sbmp.x, sbmp.y+i] pixels_lt
						setPixels texture_atlas [ox+nw, sbmp.y+i] pixels_rt
						setPixels texture_atlas [sbmp.x, oy+nh+i] pixels_lb
						setPixels texture_atlas [ox+nw, oy+nh+i] pixels_rb
					)
				)
			)
			
			try
			(
				save texture_atlas quiet:true
			)
			catch
			(
				if not do_ignore_errors do messagebox "Could not save texture atlas!"
				if do_msgs do format "Error: texture atlas was not saved to any file.\n"
			)
			display texture_atlas
		)
		
		
		
		--------------------------
		--------------------------
		-- Fifth step: scale and position uvs
		--------------------------
		
		if do_slicing and do_msgs do format "TAG makes new UV coordinates.\n"
		
		if do_slicing do
		(
			local o = 0
			for real_obj in tag_objs do with undo do_undo
			(
				o += 1

				-- this is a workaround for max 9, because collapseNodeTo is buggy
				local obj = editable_mesh()
				obj.baseobject = copy real_obj.baseobject
				local save_obj = real_obj.baseobject
				hide real_obj

				if do_msgs do format "Rearrange %'s UVs\n" real_obj.name
				
				select obj
				uvwmod = Unwrap_UVW()
				addModifier obj uvwmod
				uvwmod.setMapChannel map_channel
				uvwmod.updateView()
				uvwmod.setResetPivotOnSelection true
				uvwmod.setTVSubObjectMode 3
				--uvwmod.edit()

				-- every chunk must be scaled, oriented and translated ...
				-- thus, iterate through all material ids
				for i = 1 to material_info[o].num_materials_used do with undo do_undo
				(
					local bmp_id = material_info[o].mmatid_to_texid[material_info[o].mmat_ids[i]]
					
					local cwidth = bitmaps[bmp_id].bmp.width
					local cheight = bitmaps[bmp_id].bmp.height
					local scale_factor_x
					local scale_factor_y
			
					local tp = padding
					-- no padding for uvmaps, eh
					if not cutted_textures[bmp_id] do tp = 0
					
					if padding_tresize do
					(
						cwidth -= (tp*2)
						cheight -= (tp*2)
					)
			
					if not bitmaps[bmp_id].rotated then
					(
						scale_factor_x = (cwidth as float) / (size_of_texatlas_x as float)
						scale_factor_y = (cheight as float) / (size_of_texatlas_y as float)
					)
					else
					(
						scale_factor_x = (cwidth as float) / (size_of_texatlas_y as float)
						scale_factor_y = (cheight as float) / (size_of_texatlas_x as float)
					)
		 
					if (classOf real_obj.material) == Multimaterial then
						uvwmod.selectByMatID real_obj.material.materialIDList[material_info[o].mmat_ids[i]]
					else if (classOf real_obj.material) == Standardmaterial then
						uvwmod.selectPolygons #{1..uvwmod.numberPolygons()}
					uvwmod.updateView()
					uvwmod.unwrap.breakSelected() -- cleaning up!
					uvwmod.detachEdgeVertices()

					local x, y, width, height, temp

					local new_selection = #{}
					local sel_polys = (uvwmod.getSelectedPolygons()) as Array
					for f in sel_polys do
					(
						uvwmod.getArea #{f} &x &y &width &height &temp &temp
						if ((x >= -0.001) and (x+width <= 1.002) and (y >= -0.001) and (y+height <= 1.002)) do
							new_selection[f] = true
					)
					uvwmod.selectPolygons new_selection
					
					-- scale the uvs
					uvwmod.scaleSelectedCenter scale_factor_x 1
					uvwmod.scaleSelectedCenter scale_factor_y 2
			
					-- rotate uvs (if needed)
					if bitmaps[bmp_id].rotated do
					(
						swap scale_factor_x scale_factor_y
						uvwmod.rotateSelectedCenter (pi/2.0)
					)
			
					-- the position should be absolutely centered now, because we move it relatively
					uvwmod.getArea (uvwmod.getSelectedFaces()) &x &y &width &height &temp &temp
					local tar_x = 0.5 - (width*0.5)
					local tar_y = 0.5 - (height*0.5)
					uvwmod.moveSelected [tar_x - x, tar_y - y, 0.0]
				
					-- move uvs	
					local move_x = ((bitmaps[bmp_id].x+tp) as float) / (size_of_texatlas_x as float) - 0.5 + (scale_factor_x * 0.5)
					local move_y = ((bitmaps[bmp_id].y+tp) as float) / (size_of_texatlas_y as float) - 0.5 + (scale_factor_y * 0.5)
					uvwmod.moveSelected [move_x, -move_y, 0.0]
				)
				
				--------------------------
				--------------------------
				-- Last step: finish the model
				--------------------------
			 
				convertTo obj PolyMeshObject
				
				-- continue the workaround, *sigh*
				real_obj.baseobject = obj.baseobject
				for geo in geometry do if geo.baseobject == save_obj then geo.baseobject = obj.baseobject
				delete obj
				unhide real_obj
			)		
		)
		
		select tag_objs
	 
		if do_msgs do format "TAG ended.\n"
	 
		return 1
	)

	--------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------

	rollout ro_tag "TexAtlasGen 1.0.3"
	(
		label lb_warning "WARNING: Save your work!"
		checkbox cb_do_undo "Disable Undo" checked:true
		checkbox cb_do_messages "Generate Messages" checked:true
		checkbox cb_do_auto_resume "Ignore Warnings" checked:false
		group "Object"
		(
			checkbox cb_ob_slicing "Slice Geometry and" checked:true
			label lb_ob_slicing "Generate UVs" pos:[31,119]
			checkbox cb_ob_breakall "Break all Edges" checked:false
			
			spinner sp_ob_map_channel "Map Channel:" range:[1,99,1] type:#integer
		)
		group "Texture Atlas"
		(
			checkbox cb_ta_create "Create" checked:true
			checkbox cb_ta_force_padding "No Padding" checked:false enabled:false
			edittext et_ta_filename ""
			button bn_ta_filename "Choose Path & Filename"
		)
		group "Textures"
		(
			spinner sp_tx_padding "Padding:" range:[0, 32, 2] type:#integer
			checkbox cb_tx_resize "Shrink in Atlas" checked:true
		)
		button bn_do_it "Generate Texture Atlas" height:25
		
		label lb_3d_io "2009 (c) 3d-io" pos:[43,394]
		
		------
			
		on cb_ob_slicing changed arg do
		(
			cb_ob_breakall.enabled = arg
			if cb_ta_create.checked do
			(
				cb_ta_force_padding.enabled = not arg
			)
			if cb_ta_force_padding.enabled do
			(
				sp_tx_padding.enabled = not cb_ta_force_padding.checked
				cb_tx_resize.enabled = not cb_ta_force_padding.checked
			)
		)
		
		on cb_ta_create changed arg do
		(
			et_ta_filename.enabled = arg
			bn_ta_filename.enabled = arg
			if not arg or (arg and not cb_ob_slicing.checked) do
			(
				cb_ta_force_padding.enabled = arg
			)
		)
		
		on cb_ta_force_padding changed arg do
		(
			sp_tx_padding.enabled = not arg
			cb_tx_resize.enabled = not arg
		)
		
		on bn_ta_filename pressed do
		(
			local output_name = getSaveFileName caption:"Image File" \
												types:"Targa (*.tga)|*.tga|BMP (*.bmp)|*.bmp|JPEG (*.jpg)|*.jpg|All Files (*.*)|*.*|" \
												initialDir:"$images"
			if output_name != undefined do
			(
				et_ta_filename.text = output_name
			)
		)
		
		on bn_do_it pressed do
		(
			if selection.count > 0 do
			(
				TAG  selection  map_channel:sp_ob_map_channel.value \
								padding:sp_tx_padding.value \
								padding_tresize:cb_tx_resize.checked \
								texture_atlas_filename:et_ta_filename.text \
								do_undo:(not cb_do_undo.checked) \
								do_slicing:cb_ob_slicing.checked \
								do_generate_ta:cb_ta_create.checked \
								do_break_all:cb_ob_breakall.checked \
								do_msgs:cb_do_messages.checked \
								do_force_padding:(not cb_ta_force_padding.checked) \
								do_ignore_errors:cb_do_auto_resume.checked
			)
		)
		
		on ro_tag open do
		(
			file = openFile filename mode:"rt"
			
			if file == undefined then
			(
				-- create a new ini file because it doesn't exist
				file = createFile filename

				format "%\n%\n%\n" true true false
				format "%\n%\n%\n" true false true
				format "1\n"
				format "%\n%\n%\n" true false false
				format "C:\\TEMP\\TEXTUREATLAS.tga\n"
				format "%\n%\n"  true true
				format "2\n%\n%\n%\n" true true true
				
				--
				
				cb_do_undo.checked = true
				cb_do_messages.checked = true
				cb_do_auto_resume.checked = false

				cb_ob_slicing.checked = true
				cb_ob_breakall.checked = false
				cb_ob_breakall.enabled = true
				
				sp_ob_map_channel.value = 1

				cb_ta_create.checked = true
				cb_ta_force_padding.checked = false
				cb_ta_force_padding.enabled = false
				et_ta_filename.text = "C:\\TEMP\\TEXTUREATLAS.tga"
				et_ta_filename.enabled = true
				bn_ta_filename.enabled = true
				
				sp_tx_padding.value = 2
				sp_tx_padding.enabled = true
				cb_tx_resize.checked = true
				cb_tx_resize.enabled = true
			)
			else
			(
				cb_do_undo.checked = execute (readLine file)
				cb_do_messages.checked = execute (readLine file)
				cb_do_auto_resume.checked = execute (readLine file)

				cb_ob_slicing.checked = execute (readLine file)
				cb_ob_breakall.checked = execute (readLine file)
				cb_ob_breakall.enabled = execute (readLine file)
				
				sp_ob_map_channel.value = (readLine file) as integer

				cb_ta_create.checked = execute (readLine file)
				cb_ta_force_padding.checked = execute (readLine file)
				cb_ta_force_padding.enabled = execute (readLine file)
				et_ta_filename.text = readLine file
				et_ta_filename.enabled = execute (readLine file)
				bn_ta_filename.enabled = execute (readLine file)
				
				sp_tx_padding.value = (readLine file) as integer
				sp_tx_padding.enabled = execute (readLine file)
				cb_tx_resize.checked = execute (readLine file)
				cb_tx_resize.enabled = execute (readLine file)
			) 
		)
		on ro_tag  close do
		(
			if file != undefined then
				close file
			deleteFile filename
			file = createFile filename
			
			format "%\n" cb_do_undo.checked to:file
			format "%\n" cb_do_messages.checked to:file
			format "%\n" cb_do_auto_resume.checked to:file
			
			format "%\n" cb_ob_slicing.checked to:file
			format "%\n" cb_ob_breakall.checked to:file
			format "%\n" cb_ob_breakall.enabled to:file
			
			format "%\n" sp_ob_map_channel.value to:file
			
			format "%\n" cb_ta_create.checked to:file
			format "%\n" cb_ta_force_padding.checked to:file
			format "%\n" cb_ta_force_padding.enabled to:file
			format "%\n" et_ta_filename.text to:file
			format "%\n" et_ta_filename.enabled to:file
			format "%\n" bn_ta_filename.enabled to:file
			
			format "%\n" sp_tx_padding.value to:file
			format "%\n" sp_tx_padding.enabled to:file
			format "%\n" cb_tx_resize.checked to:file
			format "%\n" cb_tx_resize.enabled to:file
			
			close file
		)
	)
	 
	createDialog ro_tag 150 415
)
