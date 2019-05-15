macroScript DetachByID category:"- Gueshni -" Icon:#("g9_detachbyid", 1) tooltip:"Detach by ID"
 (
	try(destroyDialog detachByID)catch()
rollout detachByID "Detach by ID" width:140 height:250
(
local name_type = 1
local the_polyobj
local ran_color = true
local the_name
local the_mat_arr = #()
local id_list = #()


	label lbl_maxids "Max IDs:" pos:[10,190] width:55 height:15
	GroupBox grp_naming "Naming: " pos:[5,0] width:130 height:125
	GroupBox grp_prefix "" pos:[5,75] width:130 height:50
	GroupBox grp_ops "Options:" pos:[5,125] width:130 height:90
	
	radiobuttons rb_naming "" pos:[10,15] width:107 height:64 enabled:true labels:#("Object Name", "Material Name", "Bitmap Name", "Numbered") default:1 columns:1	
	checkbox chk_prefix "Use Prefix" pos:[10,85] width:70 height:15 checked:false
	edittext edt_prefix "" pos:[5,100] width:125
	checkbox chk_prop "Propagate Materials" pos:[10,140] width:120 height:15 checked:true
	checkbox btn_del "Delete Original" pos:[10,155] width:120 height:15 checked:true
	checkbox chk_rancolor "Random Wire Colors" pos:[10,170] width:120 height:15 checked:true
	spinner spn_maxids "" pos:[70,190] width:60 height:16 range:[0,99,99] type:#integer scale:0.05	
	button detach_bot "DETACH" pos:[5,220] width:130 height:25	
	
	fn getMaterialIDs obj =
	(
		id_arr = #()
		
		for i in 1 to spn_maxids.value do
		(
			obj.selectByMaterial i
			the_faces = getFaceSelection obj
			if (the_faces as array).count != 0 do
			(
				append id_arr i
			)
		)
		id_arr
	)
	
	fn getMatTextureName mat =
	(
		local the_map_name = the_polyobj.name
		
		try
		(			
			bmp = mat.diffusemap	
			if classof bmp == Bitmaptexture then
			(
				the_mapfile = mat.diffuseMap.bitmap.filename
				the_map_name = getFileNameFile the_mapfile
			)
			else
			(
				the_map_name = mat.name
			)
		)
		catch()
		
		the_map_name
	)	
	
	on rb_naming changed val do
	(
		name_type = val
		the_name = edt_prefix.text
	)
	
	on edt_prefix entered txt do
	(
		the_name = txt
	)
	
	on chk_rancolor changed val do
	(
		ran_color = val
	)

	on detach_bot pressed do
	(
		undo "Detach by ID" on
		(
			the_sel = selection as array
			if the_sel.count != 0 do
			(
				for obj in the_sel where \
				superclassof obj == GeometryClass and \
				obj.material != undefined do
				(
					try(convertToPoly obj)catch(exit; print "DetacByID: Error Occured on Object Conversion")
					the_orig = obj
					the_polyobj = copy the_orig

					the_mat = obj.material
					id_count = the_mat.numSubs
					id_list = getMaterialIDs the_polyobj
					
					-- start detaching
					for i in id_list do
					(	
						the_polyobj.selectByMaterial i
						the_faces = getFaceSelection the_polyobj
						
					 	case name_type of
						(
							1: the_name = uniquename (the_polyobj.name)
							2: the_name = uniquename (the_mat[i].name)
							3: the_name = uniquename (getMatTextureName the_mat[i])
							4: the_name = uniquename the_name
						)
						
						if chk_prefix.checked do the_name = edt_prefix.text + the_name
						polyOp.detachFaces the_polyobj the_faces asnode:true name:the_name
						theDetachedObj = (getnodebyname the_name)
						
						if isValidNode theDetachedObj do
						(
							if chk_prop.checked do theDetachedObj.material = the_mat[i]
							if ran_color do theDetachedObj.wirecolor = random black white
						)
						
					)-- end detach loop
					
					if btn_del.checked do delete the_orig
				)-- end object check loop
			)-- end selection loop
		)-- end Undo
	)-- end button press
	
)
createDialog detachByID style:#(#style_sysmenu,#style_toolwindow)
)