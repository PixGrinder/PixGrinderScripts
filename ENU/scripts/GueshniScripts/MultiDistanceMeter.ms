
	try(destroyDialog mdm_rollout)catch()
	rollout mdm_rollout "Multi Distance Meter" --width:184 height:284
(
	global mdm_sel_arr_tmp=#()
	global mdm_arr=#()
	global mdm_list_arr=#()
	global mdm_show_lines=true
	global mdm_color_lines=(color 0 120 255)
	global mdm_show_dist=true
	global mdm_color_dist=(color 255 68 0)
	global mdm_show_name=false
	global gw_callback_enabled
	
	fn gw_callback_fn = (
		local dist_str
		max views redraw
		gw.SetTransform (matrix3 1)
		gw.setColor #line mdm_color_lines
		for i in mdm_arr do (
			if (IsValidNode i[1])==false or (IsValidNode i[2])==false then continue()
			dist_str=(distance i[1].pos i[2].pos) as string
			if mdm_show_lines then (
			gw.Polyline #(i[1].pos,i[2].pos) true)
			if mdm_show_dist then (
				if mdm_show_name==false then (
					gw.Text ((i[1].pos+i[2].pos)/2+[0,0,1]) dist_str color:mdm_color_dist) else (
					gw.Text ((i[1].pos+i[2].pos)/2+[0,0,1]) (dist_str+" | "+((i[1].name as string)+" - "+(i[2].name as string))) color:mdm_color_dist)
			)
		)
		gw.enlargeUpdateRect #whole
		gw.updateScreen()
	)
	
	listBox lbx1 "Objects" pos:[8,8] width:168 height:8
	button btn1 "Add" pos:[8,144] width:80 height:24
	button btn2 "Delete" pos:[96,144] width:80 height:24
	label lbl1 "------------------------------------------" pos:[8,169] width:168 height:8 enabled:false
	checkbox chk1 "Show Lines" pos:[8,184] width:104 height:16 checked:true
	colorPicker cp1 "" pos:[144,184] width:32 height:16 color:mdm_color_lines
	checkbox chk2 "Show Distance" pos:[8,208] width:104 height:16 checked:true
	colorPicker cp2 "" pos:[144,208] width:32 height:16 color: mdm_color_dist
	checkbox chk3 "Name objects" pos:[24,224] width:104 height:16 checked:false
-- 	label lbl2 "------------------------------------------" pos:[8,240] width:168 height:8 enabled:false
-- 	label lbl3 "Multi Distance Meter v1.0                                       by Bodyul Vladislav" pos:[14,253] width:170 height:32 
	
	on mdm_rollout open do (
		if gw_callback_enabled==undefined then (
			registerredrawviewscallback gw_callback_fn
			gw_callback_enabled=true
		)
	)
	
	on btn1 pressed do (
		if selection.count>1 then (
			mdm_sel_arr_tmp=selection as array
			while mdm_sel_arr_tmp.count>1 do (
				append mdm_arr #(mdm_sel_arr_tmp[1],mdm_sel_arr_tmp[2])
				append mdm_list_arr ((mdm_sel_arr_tmp[1].name as string)+" - "+(mdm_sel_arr_tmp[2].name as string))
				deleteitem mdm_sel_arr_tmp 1
			)
			lbx1.items=mdm_list_arr
			lbx1.selection=mdm_list_arr.count
		) else messageBox "Select two or more objects!" beep:false title:"Multi Distance Meter"
		max views redraw
	)
	
	on btn2 pressed do (
		if mdm_list_arr.count>0 then (
			deleteitem mdm_arr lbx1.selection
			deleteitem mdm_list_arr lbx1.selection
			lbx1.items=mdm_list_arr
			lbx1.selection=mdm_list_arr.count
		)
		max views redraw
	)
	
	on lbx1 selected sel do (
		select mdm_arr[lbx1.selection]
	)
	
	on chk1 changed state do (
		mdm_show_lines=state
		max views redraw
	)
	
	on cp1 changed col do (
		mdm_color_lines=col
		max views redraw
	)
	
	on chk2 changed state do (
		mdm_show_dist=state
		chk3.enabled=state
		max views redraw
	)
	
	on cp2 changed col do (
		mdm_color_dist=col
		max views redraw
	)
	
	on chk3 changed state do (
		mdm_show_name=state
		max views redraw
	)
	
	on mdm_rollout close do (
		unregisterredrawviewscallback gw_callback_fn
		gw_callback_enabled=undefined
		max views redraw
	)
	
)
createDialog mdm_rollout width:184 height:250 pos:[140,210] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)