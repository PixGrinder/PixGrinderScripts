	(
	try(destroyDialog SplineFiberCreator)catch()
	rollout SplineFiberCreator "Spline Fiber" (
 
subrollout subRoll "the containter" height:790
)
		
(
-- VAR --	
global sf_rollout_floater, ps_pc_rlt_sf, grw_rlt_sf, ccontrol_rlt_sf, col_mtl_rlt_sf, sp_stp_rlt_sf, gen_rlt_sf, abt_rlt_sf
global obj_shp_arr=#(undefined,undefined)
global arrp_sf=#()
global arrsp_sf=#()
global start_point_sf=#()
global ccontrol_arr_sf=#(#(),#(),#())
global reg_rdrw_view_callback
global reg_rdrw_view_callback_enabled=false
-- /VAR --
-- 	
-- Functions --
-- 	
fn create_start_point_fn = (
	local point_pos
	local random_offset=([1,1,1]*ps_pc_rlt_sf.rand_ofs_p_spn.value)
	local point_cloud_type=ps_pc_rlt_sf.pc_type_ddl.selection
	local xc=ps_pc_rlt_sf.xc_spn.value
	local yc=ps_pc_rlt_sf.yc_spn.value
	local zc=ps_pc_rlt_sf.zc_spn.value
	local sides=ps_pc_rlt_sf.sides_spn.value
	local density=ps_pc_rlt_sf.dnst_spn.value
	local fsp_count=ps_pc_rlt_sf.fsp_count_spn.value
	local rad_offset=ps_pc_rlt_sf.rad_offset_spn.value
	local max_xyz=(amax #(xc,yc,zc))
	local point_grid_scale=ps_pc_rlt_sf.pnt_gps_spn.value
	local inner_radius=ps_pc_rlt_sf.inr_spn.value
	local outer_radius=ps_pc_rlt_sf.outr_spn.value
	seed ps_pc_rlt_sf.seed_pos_spn.value
	if isvalidnode obj_shp_arr[1] then (
		local tm=(matrixFromNormal (pathtangent obj_shp_arr[1] 0.0))
		local tm_pos=(pathinterp obj_shp_arr[1] 0.0)
		
		start_point_sf=#()
			
		case point_cloud_type of (
			1:( -- Grid
				for x=1 to xc do (
					for y=1 to yc do (
						for z=1 to zc do (
							point_pos=([(x-(1+(xc-1)/2.)),(y-(1+(yc-1)/2.)),(z-(1+(zc-1)/2.))]*point_grid_scale)
							point_pos=((transmatrix point_pos)*tm).pos
							point_pos+=(random (random_offset*(-1)) random_offset)*(point_grid_scale/50.)
							point_pos/=max_xyz
							if (length point_pos)>outer_radius or (length point_pos)<inner_radius then continue()
							append start_point_sf point_pos
						)
					)
				)
			)
			2:(	-- Radial
				for j=1 to density do (
					for i=1 to (j*sides) do (
						point_pos=([((j*sides*(point_grid_scale))/10),0,0]*point_grid_scale)
						rot=(quat (360./(j*sides)*i+(rad_offset*j)) [0,0,1]) as matrix3
						point_pos*=rot
						point_pos/=density
						point_pos=((transmatrix point_pos)*tm).pos
						point_pos+=((random (random_offset*(-1)) random_offset)*(point_grid_scale/50.))
						point_pos/=sides
						if (length point_pos)>outer_radius or (length point_pos)<inner_radius then continue()
						append start_point_sf point_pos
					)
				)
			)
			3:( --Fermat's spiral

					for i=1 to fsp_count do (
						multi_phi=(i*137.508)
						r=((point_grid_scale/100)*sqrt(multi_phi))
						point_pos=[(cos(multi_phi)*r),(sin(multi_phi)*r),0]
						point_pos=(((transmatrix point_pos)*tm).pos+tm_pos)
						point_pos+=((random (random_offset*(-1)) random_offset)*(point_grid_scale/50.))
						if (length (point_pos-tm_pos))>outer_radius or (length (point_pos-tm_pos))<inner_radius then continue()
						append start_point_sf point_pos
					)
			)
			4:(	-- by Mesh (Vertex)
				if isvalidnode obj_shp_arr[2] then (
					vert_sel_arr=(PolyOp.GetVertSelection obj_shp_arr[2]) as array
					if vert_sel_arr.count==0 then (
						for i=1 to (PolyOp.GetNumVerts obj_shp_arr[2]) do (
							point_pos=(PolyOP.GetVert obj_shp_arr[2] i)
							point_pos+=((random (random_offset*(-1)) random_offset)*(point_grid_scale/50.))
							if (length (obj_shp_arr[2].center-point_pos))>outer_radius or (length (obj_shp_arr[2].center-point_pos))<inner_radius then continue()
							append start_point_sf point_pos
						)
					) else (
						for i in vert_sel_arr do (
							point_pos=(PolyOP.GetVert obj_shp_arr[2] i)
							point_pos+=((random (random_offset*(-1)) random_offset)*(point_grid_scale/50.))
							if (length (obj_shp_arr[2].center-point_pos))>outer_radius or (length (obj_shp_arr[2].center-point_pos))<inner_radius then continue()
							append start_point_sf point_pos
						)
						
					)
				)
			)
		)
	)
	max views redraw
)

fn preview_start_point_fn = (
	if (isvalidnode obj_shp_arr[1]==true) then (
		local add_pos
		if ps_pc_rlt_sf.pc_type_ddl.selection!=3 and ps_pc_rlt_sf.pc_type_ddl.selection!=4 then (add_pos=(lengthinterp obj_shp_arr[1] 0.0)) else (
		add_pos=[0,0,0])
		if reg_rdrw_view_callback_enabled then (
			max views redraw
			for i in start_point_sf do (
				gw.SetTransform (matrix3 1)
				gw.Marker (i+add_pos) #smallcircle color:ps_pc_rlt_sf.clp1.color
			)
			gw.enlargeUpdateRect #whole
		)
	)
	gw.updateScreen()
)

fn Save_CC_fn cctrl = (
	ccontrol_arr_sf=#(#(),#(),#())
	for i=1 to cctrl[1].points.count do (
		ccontrol_arr_sf[1][i]=cctrl[1].points[i].value
		ccontrol_arr_sf[2][i]=cctrl[1].points[i].inTangent
		ccontrol_arr_sf[3][i]=cctrl[1].points[i].OutTangent
	)
)

fn Load_CC_fn cctrl = (
	
	for i=1 to (ccontrol_arr_sf[1].count-2) do (
		insertpoint cctrl[1] 1 cctrl[1].points[1]
	)
		
	for j=1 to ccontrol_arr_sf[1].count do (
		for i=1 to cctrl[1].points.count do (
			cctrl[1].points[i].value=ccontrol_arr_sf[1][i]
			cctrl[1].points[i].inTangent=ccontrol_arr_sf[2][i]
			cctrl[1].points[i].OutTangent=ccontrol_arr_sf[3][i]
		)
	)
)

fn preview_end_point_fn = (
	for i in arrp_sf do (
		gw.SetTransform (matrix3 1)
		gw.Marker i #point color:ps_pc_rlt_sf.clp1.color
	)
	gw.enlargeUpdateRect #whole
	gw.updateScreen()
)

fn create_shapes_fn = (
	local display_in_vp=sp_stp_rlt_sf.spl_in_vp_chk.checked
	local renderable=sp_stp_rlt_sf.spl_in_rnd_chk.checked
	local thickness=sp_stp_rlt_sf.spl_thcks_spn.value
	local steps_interp=sp_stp_rlt_sf.spl_steps_spn.value
	local adaptive=sp_stp_rlt_sf.spl_adpt_chk.checked
	local sides=sp_stp_rlt_sf.spl_sides_spn.value
	local thresh=sp_stp_rlt_sf.spl_thresh_spn.value
	local colsp=col_mtl_rlt_sf.cp1.color
	local shp
	local progress=gen_rlt_sf.prog_bar
	local point_cloud_type=ps_pc_rlt_sf.pc_type_ddl.selection
	arrp_sf=#()
	arrsp_sf=#()
	for i=1 to start_point_sf.count do (
		progress.value=(100./start_point_sf.count*i)
		if point_cloud_type!=3 and point_cloud_type!=4 then (
			append arrp_sf ((lengthinterp obj_shp_arr[1] 0.0)+start_point_sf[i])
		) else (append arrp_sf start_point_sf[i])
		shp=splineshape()
		shp.pos=((lengthinterp obj_shp_arr[1] 0.0)+start_point_sf[i])
		shp.render_renderable=renderable 
		shp.render_displayRenderMesh=display_in_vp
		shp.steps=steps_interp
		shp.thickness=thickness 
		shp.sides=sides
		shp.adaptive=adaptive
		shp.render_threshold=thresh
		shp.wirecolor=colsp
		shp.name=(uniquename "gen_shape_")
		append arrsp_sf shp
						
		addnewspline arrsp_sf[i]
	)
)

fn removing_first_knot_fn = (
	for p=1 to arrp_sf.count do (
		for k=1 to 2 do (
			addknot arrsp_sf[p] 1 #smooth #curve arrp_sf[p]
		)
		deleteknot arrsp_sf[p] 1 1
	)
)

fn generate_shapes_fn = (
	local turns_strench=grw_rlt_sf.trns_str_spn.value
	local turns_rand=grw_rlt_sf.trns_rand_spn.value
	local s_k=1
	local step_knot=sp_stp_rlt_sf.step_knot_spn.value
	local update_in_viewport=gen_rlt_sf.upd_in_vp_chk.checked
	local update_in_viewport_only_ep=gen_rlt_sf.upd_in_vp_end_p_chk.checked
	local length_splines=grw_rlt_sf.ln_spn.value
	local length_rand_splines=grw_rlt_sf.ln_rand_spn.value
	local grow_rate=grw_rlt_sf.grwr_spn.value
	local grow_rand=grw_rlt_sf.grwrrand_spn.value
	local rand_dir_enabled=grw_rlt_sf.rand_dir_chk.checked
	local rand_dir_arr=#((-1),1)
	local progress=gen_rlt_sf.prog_bar
	local direct_curves=ccontrol_rlt_sf.cv.curves[1]
	
	seed (timestamp())
	local seed_iter=(random 1 1000000)
	
	for i=0 to length_splines do (
		progress.value=(100./length_splines*i)
		if keyboard.escpressed==true then return(
			if i<1 then (
			delete arrsp_sf
			arrsp_sf=#()	
			)
			progress.value=0
		)
		for p=1 to arrp_sf.count do (
			seed (p+seed_iter)
			if i>(length_splines-(random 0. length_rand_splines)) then continue()
			npp=(nearestpathparam obj_shp_arr[1] 1 arrp_sf[p])
			pti=pathinterp obj_shp_arr[1] 1 npp
			vec=(arrp_sf[p]-pti)
			ln_vec=(length vec)
			cval1=((GetValue direct_curves 1 npp))
			grow_vec=pathtangent obj_shp_arr[1] 1 npp
			cross_vec=(cross (arrp_sf[p]-pti) grow_vec)
			if rand_dir_enabled then (cross_vec*=rand_dir_arr[random 1 2])
			rot_vec=(cross_vec*cval1*(turns_strench/10.)*(random 1. (1+turns_rand)))
			--
			arrp_sf[p]+=rot_vec
			vec2=(arrp_sf[p]-pti)
			inner_vec=(vec2-(normalize vec2)*ln_vec)
			arrp_sf[p]+=(grow_vec*(grow_rate/(random 1. (1+grow_rand))))
			arrp_sf[p]-=inner_vec
			if i==(-1) then (setknotpoint arrsp_sf[p] 1 1 arrp_sf[p]) else (
				if s_k>(step_knot-1) then (
					addknot arrsp_sf[p] 1 #smooth #curve arrp_sf[p]
				)
			)
		)
		
		if update_in_viewport_only_ep==true then (
			if step_knot>(step_knot-1) then (
			preview_end_point_fn()
			)
		)
		
		if update_in_viewport==true and update_in_viewport_only_ep==false then (
			if step_knot>(step_knot-1) then (
				if numknots arrsp_sf[1]>1 then (
					updateshape arrsp_sf	
				)
			)
			max views redraw
		)
		
		if i>0 then (s_k+=1)
		
		if s_k>step_knot then s_k=1
	)
	progress.value=0
)

fn set_color_fn = (
	local rand_seed=col_mtl_rlt_sf.col_seed_spn.value
	local col=col_mtl_rlt_sf.cp1.color
	local rand_col=col_mtl_rlt_sf.rand_col_chk.checked
	local rand_hue=(255./100.*col_mtl_rlt_sf.col_rand_hue.value)
	local rand_hue_arr=#((-1),1)
	seed rand_seed
	local iter=(random 1 100000)
	
	if rand_col then (
		for i in arrsp_sf do (
			i.wirecolor=(random black white)
		)
	) else (
		if rand_hue==0 then arrsp_sf.wirecolor=col else (
			arrsp_sf.wirecolor=col
			for i in arrsp_sf do (
				seed iter
				col_hue=i.wirecolor
				col_hue.hue+=((random 0 (col_hue.hue/255.*rand_hue))*rand_hue_arr[random 1 2])
				i.wirecolor=col_hue
				iter+=1
			)
		)
	)
	
)

fn set_material_fn = (
	local mtlshp=col_mtl_rlt_sf.btn1.material
	local mtlID=1
	local mtlIDspn=col_mtl_rlt_sf.mtl_id_spn.value
	local mtlRangeEnabled=col_mtl_rlt_sf.mtl_range_chk.checked
	local mtlRangespn=col_mtl_rlt_sf.mtl_id_range_spn.value
	local rng_type=col_mtl_rlt_sf.mtl_range_type_ddl.selection
	local rng_nn=mtlIDspn
	seed col_mtl_rlt_sf.mtl_id_seed_spn.value
	for i in arrsp_sf do (
		case mtlRangeEnabled of (
			false:(mtlID=mtlIDspn)
			true:(
					case rng_type of (
						1:(mtlID+=1
							if mtlID>mtlRangespn then mtlID=rng_nn
							)
						2:(mtlID=(Random mtlIDspn mtlRangespn))
					)
				)
		)
		for j=1 to (NumSegments i 1) do (
		setMaterialID i 1 j mtlID)
	)
	arrsp_sf.material=mtlshp
	updateshape arrsp_sf
	max views redraw
)
-- /Functions --
	
	
rollout shapeSelect "Pick Shape / Point Cloud" 
(
	fn shp_filt shp=(SuperClassOf shp==Shape)
	fn geom_filt obj=(SuperClassOf obj==GeometryClass)
	
	GroupBox grp1 "Shape" pos:[8,8] width:208 height:48 
		pickbutton pick_btn "Pick Shape" pos:[16,24] width:192 height:24 filter:shp_filt
		label pc_type_lbl "Type of cloud:" pos:[16,92] width:74 height:16
		dropdownList pc_type_ddl "" pos:[96,88] width:112 height:21 items:#("Grid", "Radial", "Fermat's Spiral", "Mesh (Vertex)")
		label mesh_lbl "Mesh:" pos:[16,124] width:74 height:16 enabled:false
		pickbutton btn5 "Pick Object" pos:[96,119] width:112 height:24 filter:geom_filt enabled:false toolTip:"Only Editable Poly!"
	
	GroupBox grp2 "Point Cloud" pos:[8,64] width:208 height:440
		label lbl2 "X:" pos:[16,152] width:16 height:16
		spinner xc_spn "" pos:[152,152] width:56 height:16 range:[1,10000,5] type:#integer
		label lbl3 "Y:" pos:[16,176] width:16 height:16
		spinner yc_spn "" pos:[152,176] width:56 height:16 range:[1,10000,5] type:#integer
		label lbl4 "Z:" pos:[16,200] width:16 height:16
		spinner zc_spn "" pos:[152,200] width:56 height:16 range:[1,10000,1] type:#integer
		label lbl5 "Random Position:" pos:[16,344] width:88 height:16 
		spinner rand_ofs_p_spn "" pos:[152,344] width:56 height:16 range:[-100000,100000,0] scale:0.1
		label lbl21 "Scale Point Cloud:" pos:[16,320] width:96 height:16
		spinner pnt_gps_spn "" pos:[152,320] width:56 height:16 range:[0,100000,10]
		label lbl6 "Inner radius:" pos:[16,392] width:72 height:16 
		spinner inr_spn "" pos:[152,392] width:56 height:16 range:[0,100000,0]
		label lbl7 "Outer radius:" pos:[16,416] width:72 height:16 
		spinner outr_spn "" pos:[152,416] width:56 height:16 range:[0,100000,50]
		label lbl18 "Sides:" pos:[16,224] width:40 height:16 enabled:false
		spinner sides_spn "" pos:[152,224] width:56 height:16 enabled:false range:[1,100000,5] type:#integer
		label lbl19 "Density:" pos:[16,248] width:40 height:16 enabled:false
		spinner dnst_spn "" pos:[152,248] width:56 height:16 enabled:false range:[0,100000,3] type:#integer
		label lbl20 "Seed:" pos:[16,368] width:32 height:16 
		spinner seed_pos_spn "" pos:[152,368] width:56 height:16 range:[0,100000,1] type:#integer
		label lbl12 "Radial Offset:" pos:[16,272] width:72 height:16 enabled:false
		spinner rad_offset_spn "" pos:[152,272] width:56 height:16 enabled:false range:[-100000,100000,0] type:#float
		label lbl13 "Count:" pos:[16,296] width:48 height:16 enabled:false
		spinner fsp_count_spn "" pos:[152,296] width:56 height:16 range:[0,100000,100] enabled:false type:#integer
		label sp1_lbl "------------------------------------------------" pos:[16,434] width:192 height:16 enabled:false
		checkbox chk5 "Show Point Cloud" pos:[16,450] width:104 height:15
		label col_pc_lbl "Color:" pos:[114,476] width:64 height:15 enabled:false
		colorPicker clp1 "" pos:[148,472] width:60 height:24 color:(color 0 255 0) enabled:false
		button pc_upd_btn "Update" pos:[16,472] width:86 height:24 enabled:false
	
	on pick_btn picked obj do (
		try (for o in $gen_shape* do o.name="old_gen_shape")catch()
		
		if (superclassof obj)==shape then (
			obj_shp_arr[1]=obj
			arrsp_sf=#()
			create_start_point_fn()
			pick_btn.caption=obj.name
			
			if reg_rdrw_view_callback==undefined then (
				registerredrawviewscallback preview_start_point_fn
				reg_rdrw_view_callback=true
			)
		) else obj_shp_arr[1]=undefined
	)
	
	on pc_type_ddl selected sel do (
		create_start_point_fn()
		case sel of (
		1:(
			mesh_lbl.enabled=btn5.enabled=false
			lbl2.enabled=xc_spn.enabled=true
			lbl3.enabled=yc_spn.enabled=true
			lbl4.enabled=zc_spn.enabled=true
			lbl18.enabled=sides_spn.enabled=false
			lbl19.enabled=dnst_spn.enabled=false
			lbl12.enabled=rad_offset_spn.enabled=false
			lbl21.enabled=pnt_gps_spn.enabled=true
			lbl13.enabled=fsp_count_spn.enabled=false
			)
		2:(
			mesh_lbl.enabled=btn5.enabled=false
			lbl2.enabled=xc_spn.enabled=false
			lbl3.enabled=yc_spn.enabled=false
			lbl4.enabled=zc_spn.enabled=false
			lbl18.enabled=sides_spn.enabled=true
			lbl19.enabled=dnst_spn.enabled=true
			lbl12.enabled=rad_offset_spn.enabled=true
			lbl21.enabled=pnt_gps_spn.enabled=true
			lbl13.enabled=fsp_count_spn.enabled=false
			)
		3:(
			mesh_lbl.enabled=btn5.enabled=false
			lbl2.enabled=xc_spn.enabled=false
			lbl3.enabled=yc_spn.enabled=false
			lbl4.enabled=zc_spn.enabled=false
			lbl18.enabled=sides_spn.enabled=false
			lbl19.enabled=dnst_spn.enabled=false
			lbl12.enabled=rad_offset_spn.enabled=false
			lbl21.enabled=pnt_gps_spn.enabled=true
			lbl13.enabled=fsp_count_spn.enabled=true
			)
		4:(
			mesh_lbl.enabled=btn5.enabled=true
			lbl2.enabled=xc_spn.enabled=false
			lbl3.enabled=yc_spn.enabled=false
			lbl4.enabled=zc_spn.enabled=false
			lbl18.enabled=sides_spn.enabled=false
			lbl19.enabled=dnst_spn.enabled=false
			lbl12.enabled=rad_offset_spn.enabled=false
			lbl21.enabled=pnt_gps_spn.enabled=false
			lbl13.enabled=fsp_count_spn.enabled=false
			)
		)
	)
	
	on btn5 picked obj do (
		if (classOf obj)!=Editable_Poly then (
			if (querybox "Object is not Editable_Poly!\nConvert to EditablePoly?" title:"Spline-Fibers") then (
				ConvertToPoly obj
				obj_shp_arr[2]=obj
				btn5.caption=obj.name
				create_start_point_fn()
			)
		) else (
			obj_shp_arr[2]=obj
			btn5.caption=obj.name
			create_start_point_fn()
			
		)
	)

	on xc_spn changed val do (
		create_start_point_fn()
	)
		
	on yc_spn changed val do (
		create_start_point_fn()
	)
		
	on zc_spn changed val do (
		create_start_point_fn()
	)
		
	on sides_spn changed val do (
		create_start_point_fn()
	)
	
	on dnst_spn changed val do (
		create_start_point_fn()
	)
	
	on rad_offset_spn changed val do (
		create_start_point_fn()
	)
	on fsp_count_spn changed val do (
		create_start_point_fn()
	)
		
	on rand_ofs_p_spn changed val do (
		create_start_point_fn()
	)
	
	
	on seed_pos_spn changed val do (
		create_start_point_fn()
	)

	on pnt_gps_spn changed val do (
		create_start_point_fn()
	)
	
	on inr_spn changed val do (
		if val>outr_spn.value then outr_spn.value=val
		create_start_point_fn()
	)
		
	on outr_spn changed val do (
		if val<inr_spn.value then inr_spn.value=val
		create_start_point_fn()
	)
	
	on chk5 changed state do (
		reg_rdrw_view_callback_enabled=state
		create_start_point_fn()
		col_pc_lbl.enabled=clp1.enabled=pc_upd_btn.enabled=state
		max views redraw
	)
	
	on pc_upd_btn pressed do (
		create_start_point_fn()
	)
	
	on clp1 changed col do (
		max views redraw
	)

	on ps_pc_rlt_sf close do (
		unregisterredrawviewscallback preview_start_point_fn
		reg_rdrw_view_callback=undefined
		max views redraw
	)
)

rollout ccontrol_rlt_sf "Spline-Fibers | Curve Control" width:480
(

	GroupBox grp7 "Direction turns ( CW / CCW )" pos:[8,4] width:464 height:236
		CurveControl cv "" pos:[16,24] width:448 height:200 numCurves:1 zoomValues:[374.545,60] scrollValues:[-18,-5] y_range:[-1,1] uiFlags:#(#drawBG, #upperToolbar, #showReset, #lowerToolbar, #ruler, #constrainY, #xvalue, #drawGrid)
		
	on ccontrol_rlt_sf open do (
		cv.curves[1].width=3
		cv.curves[1].disabledwidth=3
		cv.curves[1].color=(color 0 109 235)
		cv.curves[1].disabledColor=((color 0 109 235)/2)
		cv.curves[1].points[1].value=[0,1]
		cv.curves[1].points[1].outtangent=[0.0,0.0]
		cv.curves[1].points[2].value=[1,1]
		cv.curves[1].points[2].intangent=[-0.0,-0.0]
		Load_CC_fn cv.curves
	)
		
	on cv reset ci do ( -- ======= RESET CC ======= --
		while cv.curves[ci].numpoints>=3 do (deletePoint cv.curves[ci] 1)
			if cv.curves[ci].numpoints==2 then (
				case ci of (
					1:( cv.curves[ci].points[1].value=[0,1]
						cv.curves[ci].points[1].outtangent=[0.0,0.0]
						cv.curves[ci].points[2].value=[1,1]
						cv.curves[Ci].points[2].intangent=[-0.0,-0.0])
				)
			)
	)
	
	on ccontrol_rlt_sf close do (
		Save_CC_fn cv.curves
	)
)
CreateDialog ccontrol_rlt_sf pos:[-500,-500]
DestroyDialog ccontrol_rlt_sf

rollout growRollout "Grow"
(
	GroupBox grp3 "Length" pos:[8,8] width:208 height:124
		label lbl8 "Length:" pos:[16,34] width:72 height:16
		spinner ln_spn "" pos:[152,34] width:56 height:16 range:[0,100000,100]
		label lbl19 "Random:" pos:[32,58] width:80 height:16
		spinner ln_rand_spn "" pos:[152,58] width:56 height:16 range:[0,100000,0]
		label lbl9 "Growth rate:" pos:[16,82] width:72 height:16
		spinner grwr_spn "" pos:[152,82] width:56 height:16 range:[0,100000,1] scale:0.005
		label lbl10 "Random:" pos:[32,106] width:72 height:16 
		spinner grwrrand_spn "" pos:[152,106] width:56 height:16 range:[0,100000,0] scale:0.005
	
	GroupBox grp5 "Turns" pos:[8,136] width:208 height:96	
		label lbl15 "Stretch:" pos:[16,160] width:72 height:16
		spinner trns_str_spn "" pos:[152,160] width:56 height:16 enabled:true range:[0,1000,1] scale:0.01
		label lbl16 "Random:" pos:[32,184] width:72 height:16 
		spinner trns_rand_spn "" pos:[152,184] width:56 height:16 range:[0,100000,0] scale:0.005
		checkbox rand_dir_chk "Random direction" pos:[16,208] width:152 height:16
	
	GroupBox grp6 "Curve Control" pos:[8,236] width:208 height:60
		button show_cc_btn "Show Curve Control" pos:[16,256] width:192 height:32

	on ln_spn changed val do (
		if val<ln_rand_spn.value then ln_rand_spn.value=val
	)
	
	on ln_rand_spn changed val do (
		if val>ln_spn.value then ln_spn.value=val
	)
	
	on show_cc_btn pressed do (
		CreateDialog ccontrol_rlt_sf
	)
)

rollout colorMat "Color and Material"
(
	GroupBox grp1 "Color" pos:[8,8] width:208 height:120
		colorPicker cp1 "" pos:[152,24] width:56 height:24 color:(color 26 174 217)
		label lbl1 "Spline Color:" pos:[16,32] width:64 height:16
	
	GroupBox grp2 "Material" pos:[8,136] width:208 height:152
		label lbl2 "Spline Material:" pos:[16,160] width:80 height:16
		button del_mtl " Del." pos:[94,152] width:26 height:24 tooltip:"Delete Material"
		materialButton btn1 "Material" pos:[124,152] width:84 height:24
		label lbl3 "Material ID:" pos:[16,184] width:64 height:16
		spinner mtl_id_spn "" pos:[152,184] width:56 height:16 range:[1,1000000,1] type:#integer
		checkbox mtl_range_chk "Range" pos:[16,208] width:64 height:16 
		spinner mtl_id_range_spn "" pos:[152,208] width:56 height:16 enabled:false range:[1,10000,2] type:#integer
		label lbl5 "Type of range:" pos:[16,236] width:74 height:16 enabled:false
		dropdownList mtl_range_type_ddl "" pos:[98,232] width:110 height:21 enabled:false items:#("in Order", "Random")
		spinner mtl_id_seed_spn "" pos:[144,264] width:64 height:16 enabled:false range:[1,1000000,1] type:#integer 
		button mtl_id_seed_btn "Seed" pos:[96,264] width:42 height:16 enabled:false
		checkbox rand_col_chk "Random Color" pos:[16,80] width:96 height:16
		spinner col_rand_hue "" pos:[152,56] width:56 height:16 range:[0,100,0]
		label lbl7 "Variation of hue (%):" pos:[16,56] width:110 height:16
		label lbl6 "Seed:" pos:[16,264] width:48 height:16 enabled:false
		spinner col_seed_spn "" pos:[145,104] width:64 height:16 range:[1,1000000,1] type:#integer
		button btn3 "Seed" pos:[97,104] width:42 height:16
		label lbl8 "Seed:" pos:[16,104] width:48 height:16
		
	on cp1 changed col do (
		set_color_fn()
	)
	
	on col_rand_hue changed val do (
		set_color_fn()	
	)
	
	on rand_col_chk changed state do (
		case state of (
		true:lbl7.enabled=col_rand_hue.enabled=false
		false:lbl7.enabled=col_rand_hue.enabled=true
		)
		set_color_fn()
	)
	
	on btn3 pressed do (
		seed (timestamp())
		col_seed_spn.value+=(random 1 20)
		set_color_fn()	
	)
	
	on col_seed_spn changed val do (
		set_color_fn()
	)
	
	on del_mtl pressed do (
		arrsp_sf.material=undefined
		btn1.material=undefined
		btn1.caption="Material"
	)
	
	on btn1 picked mtl do (
		try(set_material_fn())catch()
		btn1.caption=mtl.name
	)
	
	on mtl_id_spn changed val do (
		if val>mtl_id_range_spn.value then mtl_id_range_spn.value=val
		try(set_material_fn())catch()	
	)
	
	on mtl_range_chk changed state do (
		lbl5.enabled=lbl6.enabled=mtl_id_range_spn.enabled=mtl_range_type_ddl.enabled=state
		lbl6.enabled=mtl_id_seed_btn.enabled=mtl_id_seed_spn.enabled=if mtl_range_type_ddl.selection==2 and state then true else false
		try(set_material_fn())catch()	
	)
	
	on mtl_id_range_spn changed val do (
		if val<mtl_id_spn.value then mtl_id_spn.value=val
		try(set_material_fn())catch()	
	)
	
	on mtl_range_type_ddl selected sel do (
		try(set_material_fn())catch()
		lbl6.enabled=mtl_id_seed_btn.enabled=mtl_id_seed_spn.enabled=if sel==2 then true else false
	)
	
	on mtl_id_seed_btn pressed do (
		seed (timestamp())
		mtl_id_seed_spn.value+=(random 1 50)
		try(set_material_fn())catch()
	)
	
	on mtl_id_seed_spn changed val do (
		try(set_material_fn())catch()
	)
)

rollout splineSetup "Spline Setup" 
(
	GroupBox grp4 "Spline:" pos:[8,0] width:208 height:218
		label lbl11 "Steps (Knot):" pos:[16,20] width:64 height:16
		spinner step_knot_spn "" pos:[152,20] width:56 height:16 range:[1,100000,1] type:#integer
		label sp1_lbl "------------------------------------------------" pos:[16,34] width:192 height:16 enabled:false
		checkbox spl_in_rnd_chk "Enabled In Renderer" pos:[16,48] width:136 height:16	
		checkbox spl_in_vp_chk "Enabled In Viewport" pos:[16,64] width:136 height:16	
		label lbl12 "Thickness:" pos:[16,88] width:64 height:16 
		spinner spl_thcks_spn "" pos:[152,88] width:56 height:16 range:[0,100000,1] scale:0.01
		label lbl13 "Sides:" pos:[16,112] width:64 height:16
		spinner spl_sides_spn "" pos:[152,112] width:56 height:16 range:[0,100000,6] type:#integer
		label lbl14 "Steps:" pos:[16,144] width:64 height:16	
		spinner spl_steps_spn "" pos:[152,144] width:56 height:16 range:[0,100000,5] type:#integer
		checkbox spl_adpt_chk "Adaptive" pos:[16,168] width:72 height:16
		label lbl15 "Threshold" pos:[16,194] width:72 height:16
		spinner spl_thresh_spn "" pos:[152,194] width:56 height:16 range:[0,100000,80]
	
	GroupBox grp3 "Other:" pos:[8,224] width:208 height:75
		checkbox add_shp_to_grp_chk "Add to Group" pos:[16,248] width:128 height:16
		editText edt3 "" pos:[100,272] width:108 height:16 text:"Spl_Fbr_Group" enabled:false
		label lbl9 "Group Name:" pos:[16,272] width:72 height:16 enabled:false
	
	on spl_in_rnd_chk changed state do (
		try(arrsp_sf.render_renderable=state)catch()
	)
	
	on spl_in_vp_chk changed state do (
		try(arrsp_sf.render_displayRenderMesh=state)catch()	
	)
	
	on spl_thcks_spn changed val do (
		try(arrsp_sf.thickness=val)catch()
	)
	
	on spl_sides_spn changed val do (
		try(arrsp_sf.sides=val)catch()
	)
	
	on spl_steps_spn changed val do (
		try(arrsp_sf.steps=val)catch()
		)
	
	on spl_adpt_chk changed state do (
		try(arrsp_sf.adaptive=state)catch()
		case state of (
			true:(spl_steps_spn.enabled=false)
			false:(spl_steps_spn.enabled=true)
		)
	)
	
	on spl_thresh_spn changed val do (
		try(arrsp_sf.render_threshold=val)catch()	
	)
	
	on add_shp_to_grp_chk changed state do (
		lbl9.enabled=edt3.enabled=state
	)
)

rollout generateFiber "Generation" width:224 height:168
(
	GroupBox grp6 "Generation" pos:[8,8] width:208 height:153
		checkbox upd_in_vp_chk "Update in Viewport" pos:[16,28] width:110 height:15
		checkbox upd_in_vp_end_p_chk "Only Points" pos:[30,46] width:100 height:15 enabled:false
		button generate_btn "Generate" pos:[16,64] width:120 height:56
		button apl_btn "Apply" pos:[144,96] width:64 height:24
		button clr_btn "Clear" pos:[143,64] width:65 height:24
		progressBar prog_bar "" pos:[15,125] width:193 height:8 color:(color 230 10 30)
		edittext edt1 "Elapsed time:                " pos:[16,136] width:192 height:16 readOnly:true
	
	on generate_btn pressed do (
		t1=timestamp()
		try(delete arrsp_sf)catch()
		if ps_pc_rlt_sf.pc_type_ddl.selection!=4 and (isvalidnode obj_shp_arr[1]) or ps_pc_rlt_sf.pc_type_ddl.selection==4 and (isvalidnode obj_shp_arr[1]) and (IsValidNode obj_shp_arr[2]) then (
			create_start_point_fn()
			create_shapes_fn()
			removing_first_knot_fn()
			generate_shapes_fn()
			updateshape arrsp_sf
			set_color_fn()
			set_material_fn()
			if sp_stp_rlt_sf.add_shp_to_grp_chk.checked then (
				(group arrsp_sf name:sp_stp_rlt_sf.edt3.text)
			)
		) else messagebox "Pick shape or object!" title:"Spline-Fibers"
	
		t2=timestamp()
		edt1.text=((((t2-t1)/1000.) as string)+" sec.")
	)
		
	on clr_btn pressed  do (
		try (delete arrsp_sf)catch()
	)
	
	on apl_btn pressed do (
		arrsp_sf=#()
	)
	
	on upd_in_vp_chk changed state do (
		upd_in_vp_end_p_chk.enabled=state
		if state==false then upd_in_vp_end_p_chk.checked=state
	)
)

)

createdialog SplineFiberCreator  width:250 height:800 pos:[140,210] bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)
AddSubRollout SplineFiberCreator.subRoll shapeSelect rolledup:false
-- AddSubRollout SplineFiberCreator.subRoll ccontrol_rlt_sf rolledup:false
AddSubRollout SplineFiberCreator.subRoll growRollout rolledup:true
AddSubRollout SplineFiberCreator.subRoll colorMat rolledup:true
AddSubRollout SplineFiberCreator.subRoll splineSetup rolledup:true
AddSubRollout SplineFiberCreator.subRoll generateFiber rolledup:false
)