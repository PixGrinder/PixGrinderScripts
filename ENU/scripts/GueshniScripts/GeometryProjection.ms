	
	multi_selection = ""
	fn geometry_filter obj = isKindOf obj GeometryClass
		
	try
	(
		destroydialog Projectionroll
	)
	catch
	(
		
	)
	
	fn get_y_axis t_obj =
	(
		temp_point = point pos:t_obj.pos
		temp_point.transform = t_obj.transform
		in coordsys t_obj 
		(
			temp_point.rotation.x_rotation = -90
			temp_point.rotation.y_rotation = 0
			temp_point.rotation.z_rotation = 0
		)
		return_axis = temp_point.dir
		delete temp_point
		return_axis
	)
	
	fn get_x_axis t_obj =
	(
		temp_point = point pos:t_obj.pos
		temp_point.transform = t_obj.transform
		in coordsys t_obj 
		(
			temp_point.rotation.x_rotation = 0
			temp_point.rotation.y_rotation = 90
			temp_point.rotation.z_rotation = 180
		)
		return_axis = temp_point.dir
		delete temp_point
		-return_axis
	)
	
	fn getViewDirectionRay =

(
	local coordSysTM = Inverse(getViewTM())
	local viewDir = -coordSysTM.row3
	local viewPt = coordSysTM.row4
	return viewDir
)
	
	fn proection old_obj old_relef pb Rb=
	(
		curViewDir = getViewDirectionRay()
		relef = copy old_relef
		obj = copy old_obj
		convertToMesh relef
		convertToMesh obj
		colv = getNumVerts obj
		v=0
		selected_verts = #()
		selected_verts =  ((getVertSelection obj)as array)
		select_all_verts = #()
		if selected_verts[1] == undefined then
		(
			for i=1 to colv do
			(
				selected_verts[i] = i
			)
			
		)
		for i=1 to colv do
		(
			select_all_verts[i] = i
		)

		verts_offsets = #()	
		for tempvert in selected_verts do
		(	
			v += 1
			pb.value = v*100/selected_verts.count
			
			vert = getVert obj tempvert
			
			xx = case Rb of
			(
				1: ray vert [(relef.pos.x-obj.pos.x)/(abs (relef.pos.x-obj.pos.x)),0,0]
				2: ray vert [0,(relef.pos.y-obj.pos.y)/(abs (relef.pos.y-obj.pos.y)),0]
				3: ray vert [0,0,(relef.pos.z-obj.pos.z)/(abs (relef.pos.z-obj.pos.z))]
			)
				
			xxx = intersectRay relef xx
			if xxx != undefined then
			(
				case Rb of
				(
					1: (vert.x = xxx.pos.x + vert.x-obj.pos.x)
					2: (vert.y = xxx.pos.y + vert.y-obj.pos.y)
					3: (vert.z = xxx.pos.z + vert.z-obj.pos.z)
				)
				--vert.x = xxx.pos.x + (vert.x-obj.pos[1])*curViewDir[1]
				--vert.y = xxx.pos.y + (vert.y-obj.pos[2])*curViewDir[2]
				--vert.z = xxx.pos.z + (vert.z-obj.pos[3])*curViewDir[3]
			)
			else
			(
				case Rb of
				(
					1: vert.x = relef.pos.x + (vert.x-obj.pos[1])
					2: vert.y = relef.pos.y + (vert.y-obj.pos[2])
					3: vert.z = relef.pos.z + (vert.z-obj.pos[3])
				)
				--vert.x = xxx.pos.x + (vert.x-obj.pos[1])
				--vert.y = xxx.pos.y + (vert.y-obj.pos[2])
				--vert.z = xxx.pos.z + (vert.z-obj.pos[3])
				
			)
			setVert obj selected_verts[v] vert
		)
		update obj
		delete relef
		
		select old_obj

		addModifier old_obj (Edit_Poly())
		old_obj.modifiers[1].SetEPolySelLevel #Vertex
		old_obj.modifiers[1].Select #Vertex (select_all_verts as bitarray)
		old_obj.modifiers[1].currentOperation = 10
		old_obj.modifiers[1].SetEPolySelLevel #Object
		old_obj.modifiers[1].RefreshScreen()
		select old_obj
		obj
	)
	
	fn proection_local old_obj old_relef pb Rb=
	(
		curViewDir = getViewDirectionRay()
		relef = copy old_relef
		obj = copy old_obj
		convertToMesh relef
		convertToMesh obj
		colv = getNumVerts obj
		v=0
		selected_verts = #()
		selected_verts =  ((getVertSelection obj)as array)
		select_all_verts = #()
		if selected_verts[1] == undefined then
		(
			for i=1 to colv do
			(
				selected_verts[i] = i
			)
			
		)
		for i=1 to colv do
		(
			select_all_verts[i] = i
		)

		verts_offsets = #()	
		 
			
		obj_dir_z = case Rb of
		(
			1: ((get_x_axis obj)*(in coordsys obj((relef.pos.x-obj.pos.x)/(abs (relef.pos.x-obj.pos.x)))))
			2: ((get_y_axis obj)*(in coordsys obj((relef.pos.y-obj.pos.y)/(abs (relef.pos.y-obj.pos.y)))))
			3: (obj.dir*(in coordsys obj((relef.pos.z-obj.pos.z)/(abs (relef.pos.z-obj.pos.z)))))
		)
		
		obj_rel_dist = obj_dir_z*abs(dot obj_dir_z (relef.pos-obj.pos))
			
		for tempvert in selected_verts do
		(
			v += 1
			pb.value = v*100/selected_verts.count
			
			vert = getVert obj tempvert
			
			xx = case Rb of
			(
				1: ray vert (obj_dir_z)
				2: ray vert (obj_dir_z)
				3: ray vert (obj_dir_z)
			)
			--print xx
			
			try 
			(
				xxx = (intersectRay relef xx).pos
			)
			catch
			(
				xxx = undefined
			)
			--vert_dist = abs (length (vert - xxx))
			--print xxx
			--print vert_dist
				
			if xxx != undefined then
			(
				case Rb of
				(
					1: (vert = xxx+(obj_dir_z*(dot obj_dir_z (vert-obj.pos))))
					2: (vert = xxx+(obj_dir_z*(dot obj_dir_z (vert-obj.pos))))
					--3: (vert.z = xxx.pos.z + vert.z-obj.pos.z)
					3: (vert = xxx+(obj_dir_z*(dot obj_dir_z (vert-obj.pos))))
				)
				--vert.x = xxx.pos.x + (vert.x-obj.pos[1])*curViewDir[1]
				--vert.y = xxx.pos.y + (vert.y-obj.pos[2])*curViewDir[2]
				--vert.z = xxx.pos.z + (vert.z-obj.pos[3])*curViewDir[3]
			)
			else
			(
				case Rb of
				(
					1: (vert = vert + obj_rel_dist)
					2: (vert = vert + obj_rel_dist)
					--3: vert.z = relef.pos.z + (vert.z-obj.pos[3])
					3: (vert = vert + obj_rel_dist)-- obj_rel_dist+(obj_dir_z*(dot obj_dir_z (vert-obj.pos))))
				)
				--vert.x = xxx.pos.x + (vert.x-obj.pos[1])
				--vert.y = xxx.pos.y + (vert.y-obj.pos[2])
				--vert.z = xxx.pos.z + (vert.z-obj.pos[3])
				
			)
			setVert obj selected_verts[v] vert
		)
		update obj
		delete relef
		
		select old_obj

		addModifier old_obj (Edit_Poly())
		old_obj.modifiers[1].SetEPolySelLevel #Vertex
		old_obj.modifiers[1].Select #Vertex (select_all_verts as bitarray)
		old_obj.modifiers[1].currentOperation = 10
		old_obj.modifiers[1].SetEPolySelLevel #Object
		old_obj.modifiers[1].RefreshScreen()
		select old_obj
		obj
		
	)

	rollout Projectionroll "GPojection" width:140 height:224
	(
		pickbutton btn1 "Object" pos:[2,20] width:113 height:16 filter:geometry_filter
		button obj_list "..." pos:[117,20] width:20 height:16
		pickbutton btn2 "Relief " pos:[2,55] width:135 height:16 filter:geometry_filter
		progressBar pb1 "" pos:[2,200] width:135 height:16 orient:#horizontal
		
		label lbl1 "Script will project:" pos:[25,3] width:101 height:14
		
		label lbl2 "onto:" pos:[56,38] width:32 height:14
		label lbl3 "by:" pos:[60,74] width:32 height:14
		label lbl4 "LOCAL" pos:[8,89] width:32 height:14
		label lbl5 "GLOBAL" pos:[8,144] width:46 height:14
		button btn4 "X" pos:[6,106] width:40 height:30
		button btn5 "Y" pos:[50,106] width:40 height:30
		button btn6 "Z" pos:[94,106] width:40 height:30
		button btn7 "Z" pos:[94,160] width:40 height:30
		button btn8 "Y" pos:[50,160] width:40 height:30
		button btn9 "X" pos:[6,160] width:40 height:30
		
		on Projectionroll open do
		(
			if (selection[2] != undefined)and(selection[3] == undefined) then
			(
				btn1.object = selection[1]
				btn1.text = btn1.object.name
				btn2.object = selection[2]
				btn2.text = btn2.object.name
			)
			
		)
		
		on obj_list pressed do
		(
			
			multi_selection = ""
			multi_selection = selectByName title:"select ojects to project" filter:geometry_filter
			if multi_selection != undefined then
			(
				if multi_selection.count == 1 then
				(
					btn1.text = multi_selection[1].name
				)
				else
				(
					btn1.text = (multi_selection.count as string)+" objects"
					btn1.object = undefined
				)
			)
			else
			(
				multi_selection = ""
			)
		)
		
		on btn1 picked obj do
		(
			btn1.text = obj.name
		)
		on btn2 picked obj do
		(
			btn2.text = obj.name
		)
		
		on btn9 pressed do
		(
			undo "projection" on
			(
				try
				(
					if (multi_selection == "") or (multi_selection == undefined) then multi_selection = btn1.object
					for mult_obj in multi_selection do
					(
						if mult_obj != btn2.object then
						(
							select mult_obj
							select btn2.object
							obj = proection mult_obj btn2.object pb1 1
							$.modifiers[1].Attach obj
							$.modifiers[1].RefreshScreen()
						)
					)
				)
				catch
				(
					
				)
			)
		)
		
		on btn8 pressed do
		(
			undo "projection" on
			(
				try
				(
					if (multi_selection == "") or (multi_selection == undefined) then multi_selection = btn1.object
					for mult_obj in multi_selection do
					(
						if mult_obj != btn2.object then
						(
							select mult_obj
							select btn2.object
							obj = proection mult_obj btn2.object pb1 2
							$.modifiers[1].Attach obj
							$.modifiers[1].RefreshScreen()
						)
					)
				)
				catch
				(
					
				)
			)
		)
		
		on btn7 pressed do
		(
			undo "projection" on
			(
				try
				(
					if (multi_selection == "") or (multi_selection == undefined) then multi_selection = btn1.object
					for mult_obj in multi_selection do
					(
						if mult_obj != btn2.object then
						(
							select mult_obj
							select btn2.object
							obj = proection mult_obj btn2.object pb1 3
							$.modifiers[1].Attach obj
							$.modifiers[1].RefreshScreen()
						)
					)
				)
				catch
				(
					
				)
			)
		)
		
		on btn6 pressed do
		(
			undo "projection" on
			(
				try
				(
					if (multi_selection == "") or (multi_selection == undefined) then multi_selection = btn1.object
					for mult_obj in multi_selection do
					(
						if mult_obj != btn2.object then
						(
							select mult_obj
							select btn2.object
							obj = proection_local mult_obj btn2.object pb1 3
							$.modifiers[1].Attach obj
							$.modifiers[1].RefreshScreen()
						)
					)
				)
				catch
				(
					
				)
			)
		)
		
		on btn5 pressed do
		(
			undo "projection" on
			(
				try
				(
					if (multi_selection == "") or (multi_selection == undefined) then multi_selection = btn1.object
					for mult_obj in multi_selection do
					(
						if mult_obj != btn2.object then
						(
							select mult_obj
							select btn2.object
							obj = proection_local mult_obj btn2.object pb1 2
							$.modifiers[1].Attach obj
							$.modifiers[1].RefreshScreen()
						)
					)
				)
				catch
				(
					
				)
			)
		)
		
		on btn4 pressed do
		(
			undo "projection" on
			(
				try
				(
					if (multi_selection == "") or (multi_selection == undefined) then multi_selection = btn1.object
					for mult_obj in multi_selection do
					(
						if mult_obj != btn2.object then
						(
							select mult_obj
							select btn2.object
							obj = proection_local mult_obj btn2.object pb1 1
							$.modifiers[1].Attach obj
							$.modifiers[1].RefreshScreen()
						)
					)
				)
				catch
				(
					
				)
			)
		)
		
	)

	createdialog Projectionroll pos:[140,210] bgcolor:(color 84 101 120)  fgcolor:(color 248 113 45)
-- 	createdialog Projectionroll pos:(mouse.screenpos)