--encryptScript "Vertex Distance Tape v1.1.ms" version:1.1
try (destroyDialog ::MainWin) catch()

global NameProject = " Vertex Distance Tape"

rollout MainWin NameProject
(	
	---------------------------------------------------------------------------------------------------VARIABLES
	local WidthWin = 196, HeightWin = 320, WidthGroup = 190, HeightBtn = 22, VerticalBtnPos = 5
	local ColorGroupText = [248.0,113.0,45.0]
	global oldSnapMode = #()
	global GlobalArrayLinePos1 = #()
	global GlobalArrayLinePos2 = #()	
	local DefaultAll = 1
	local DefaultCenter = 1
	local RadioSCALE = 2
	local CurrentColorSize = (color 0 255 0)
	local CurrentColorLine= (color 255 0 0)
	local BtnPick2VertName = "Build tape to choice any 2 vertex"
	local BtnVisibleName = "VISIBLE ON"
	local BtnCenterSizeName = "NoCenter"	
	local BtnSelectedLineName = "Selected"	
	local GetPickNameObject
	local Object1, Object2, Vertex1, Vertex2
	local sObj1 = undefined, sObj2 = undefined
	local TypeOBJ1, TypeOBJ2
	fn shapeFilt o = (classof o == Editable_mesh or classof o == Editable_Poly or classof o == Editable_Patch)
	
	---------------------------------------------------------------------------------------------------UI
	local Grp = 3
	local MoveCtrl = -45
	--dotnetcontrol lbl1 "Label" pos:[3,Grp] width:WidthGroup height:16
	--checkbutton BtnPick2Vert BtnPick2VertName pos:[VerticalBtnPos,Grp+19] width:(WidthWin-10) height:HeightBtn toolTip:"Works with types base:\nEditable (Poly, Mesh, Patch)" checked:false border:false
	
	dotnetcontrol lbl2 "Label" pos:[3,47+MoveCtrl] width:WidthGroup height:16
	pickbutton Obj1 "Object1" autoDisplay:true pos:[7,69+MoveCtrl] width:130 height:19 toolTip:"Select object for pick point1\nWorks with types base:\nEditable (Poly, Mesh, Patch)" checked:false filter:shapeFilt
	pickbutton Obj2 "Object2" autoDisplay:true pos:[7,89+MoveCtrl] width:130 height:19 toolTip:"Select object for pick point2\nWorks with types base:\nEditable (Poly, Mesh, Patch)" checked:false filter:shapeFilt
	spinner Vert1 "" pos:[140,70+MoveCtrl] range:[1 ,99999,1] toolTip:"Enter number vertex from Object1" type:#integer width:49 enabled:false
	spinner Vert2 "" pos:[140,90+MoveCtrl] range:[1 ,99999,1] toolTip:"Enter number vertex from Object2" type:#integer width:49 enabled:false
	button BtnSetTape "Set Tape" pos:[7,111+MoveCtrl] toolTip:"Auto connect spline from vertex1 to vertex2" width:(WidthGroup-8) height:22 tooltip:"" enabled:false
	
	dotnetcontrol lbl3 "Label" pos:[3,137+MoveCtrl] width:WidthGroup height:16
	
	button SizeCtrl "cm" pos:[5,159+MoveCtrl] width:30 height:20 toolTip:"Set unit scale metric"
	checkbutton BtnCenterSize BtnCenterSizeName pos:[36,159+MoveCtrl] width:54 height:20 toolTip:"" checked:false border:true	
	checkbutton BtnSelectedLine BtnSelectedLineName pos:[132,159+MoveCtrl] width:54 height:20 toolTip:"" checked:false border:true
	
	GroupBox grp_custom "" pos:[3,147+MoveCtrl] width:(WidthGroup) height:74
	
	colorPicker ChangeColorSize "Size:" pos:[10,178+MoveCtrl] width:80 height:15 color:CurrentColorSize modal:false
	colorPicker ChangeColorLine "Line:" pos:[106,178+MoveCtrl] width:80 height:15 color:CurrentColorLine modal:false	
	checkbutton BtnVisible BtnVisibleName pos:[VerticalBtnPos,197+MoveCtrl] width:(WidthWin-10) height:HeightBtn toolTip:"" checked:false border:true
	
	
	---------------------------------------------------------------------------------------------------FUNCTION
	fn ColorLabel param txt R G B =
	(
		param.BackColor = (dotNetClass "System.Drawing.Color").FromArgb R G B
		param.ForeColor = (dotNetClass "System.Drawing.Color").FromArgb ColorGroupText.x ColorGroupText.y ColorGroupText.z
		param.Text = txt ; param.TextAlign = param.TextAlign.MiddleCenter
	)
	
	fn FnGetSnapOldMode  =
	(	
		oldSnapMode[1] = snapMode.getOSnapItemActive 3 1
		oldSnapMode[2] = snapMode.getOSnapItemActive 3 2
		oldSnapMode[3] = snapMode.getOSnapItemActive 4 1
		oldSnapMode[4] = snapMode.getOSnapItemActive 4 2		
		oldSnapMode[5] = snapMode.getOSnapItemActive 5 1
		oldSnapMode[6] = snapMode.getOSnapItemActive 5 2
		oldSnapMode[7] = snapMode.getOSnapItemActive 6 1
		oldSnapMode[8] = snapMode.getOSnapItemActive 6 2			
		oldSnapMode[9] = snapMode.getOSnapItemActive 6 3
		oldSnapMode[10] = snapMode.getOSnapItemActive 6 4
		oldSnapMode[11] = snapMode.getOSnapItemActive 6 5
		oldSnapMode[12] = snapMode.getOSnapItemActive 6 6
		oldSnapMode[13] = snapMode.type
	)	

	fn AllGetArrayCountLines =
	(
		local AllArrayIDLines = #()
		if (DefaultAll == 0) then
		(
			for s in selection do
			(
				local Err=0
				try(if (s.render_angle2 >= 0) then Err=0) catch (Err=1)
				if (Err == 0) then
				(
					if ((s.render_angle2.controller as string) == "Controller:Float_Script") then
					(
						append AllArrayIDLines (materialID s 1 1)
					)
				)
			)				
		)
		else
		(
			for s in shapes do --for all shapes on scene
			(
				if ((s.render_angle2.controller as string) == "Controller:Float_Script") then
				(
					append AllArrayIDLines (materialID s 1 1)
				)			
			)
		)
		return AllArrayIDLines
	)
	
	
	fn FindMaxIDLine =
	(
		local FindID = #()
		local xMax
		for s in shapes do --for all shapes on scene
		(
			if ((s.render_angle2.controller as string) == "Controller:Float_Script") then
			(
				append FindID (materialID s 1 1)
			)			
		)
		xMax = amax FindID
		return xMax		
	)

	fn FnSetSnapOldMode  =
	(	
		format "Count: %\n" oldSnapMode.count
		snapMode.setOSnapItemActive 3 1 oldSnapMode[1] 
		snapMode.setOSnapItemActive 3 2 oldSnapMode[2] 
		snapMode.setOSnapItemActive 4 1 oldSnapMode[3] 
		snapMode.setOSnapItemActive 4 2 oldSnapMode[4] 
		snapMode.setOSnapItemActive 5 1 oldSnapMode[5] 
		snapMode.setOSnapItemActive 5 2 oldSnapMode[6] 
		snapMode.setOSnapItemActive 6 1 oldSnapMode[7] 
		snapMode.setOSnapItemActive 6 2 oldSnapMode[8] 			
		snapMode.setOSnapItemActive 6 3 oldSnapMode[9] 
		snapMode.setOSnapItemActive 6 4 oldSnapMode[10] 
		snapMode.setOSnapItemActive 6 5 oldSnapMode[11] 
		snapMode.setOSnapItemActive 6 6	oldSnapMode[12] 
		--if Error theen TRY
		try(snapMode.type = oldSnapMode[13])	catch ()
	)		

	fn snapinfo =
	(
		local snapinfo
		if snapmode.active do
		(
			struct snapinfo (hit, flags, hitpoint, worldhitpoint, screenHitPoint, OKForRelativeSnap, topRefPoint, refPoint, node)
			local out = snapinfo snapmode.hit (bit.intAsHex snapmode.flags) snapmode.hitPoint \
			snapmode.worldHitpoint snapmode.screenHitPoint snapmode.OKForRelativeSnap \
			snapmode.refPoint snapmode.topRefPoint snapmode.node
			GetPickNameObject = snapmode.node
			print out
		)
	)
	
	fn GridActivate  =
	(
		snapMode.active = true
		registerRedrawViewsCallback snapinfo
		snapMode.type = #3D
		snapMode.setOSnapItemActive 3 1 false --Grid Points
		snapMode.setOSnapItemActive 3 2 false --Grid Lines
		snapMode.setOSnapItemActive 4 1 false --Pivot
		snapMode.setOSnapItemActive 4 2 false --Bounding Box
		snapMode.setOSnapItemActive 5 1 false --Perpendicular
		snapMode.setOSnapItemActive 5 2 false --Tangent
		snapMode.setOSnapItemActive 6 1 true --Vertex
		snapMode.setOSnapItemActive 6 2 false --Endpoint
		snapMode.setOSnapItemActive 6 3 false --Edge/Segment
		snapMode.setOSnapItemActive 6 4 false --Midpoint
		snapMode.setOSnapItemActive 6 5 false --Face
		snapMode.setOSnapItemActive 6 6 false --Center Face
	)	
	
	fn DeactivateBuild  =
	(
		BtnPick2Vert.checked = false
		unregisterRedrawViewsCallback snapinfo
		snapMode.active = false
		BtnPick2Vert.text = BtnPick2VertName
		FnSetSnapOldMode()

	)
	
	fn ShowMsgBoxError AddText = 
	(
		local StringArray = #("No works with ", AddText, " type object!")
		CombineString = append StringArray[1] (append StringArray[2] StringArray[3])
		messagebox CombineString title:"Bad type object" beep:false
	)
	
	fn DetectTypeObject PutObject type: integer=
	(
		
		if (PutObject == undefined) then
		(
			messagebox "Need pick to object!" title:"Bad target" beep:false
			return 0
		)	
		
		if ((PutObject.modifiers).count > 0) then
		(
			messagebox "Current object - should work without modifiers (need delete all modifiers)!" title:"Bad object" beep:false
			return 0
		)
		
		if classof PutObject == Editable_mesh then return 3
		if classof PutObject == Editable_Poly then return 4
		if classof PutObject == Editable_Patch then return 5	
			
		--if this is Primitive
		if (superClassOf PutObject == GeometryClass) and (classof PutObject != Editable_mesh) and (classof PutObject != Editable_Poly) and (classof PutObject != Editable_Patch) and (classof PutObject != NURBSSurf) then
		(
			ShowMsgBoxError "Primitive"
			return 0
		)
		
		if (superClassOf PutObject == shape) then
		(
			ShowMsgBoxError "shape(spline)"
			return 0
		)
		
		if (classof PutObject == NURBSSurf) then
		(
			ShowMsgBoxError "NURBSSurf"
			return 0
		)
		
		messagebox "Need pick tape to object (MESH, POLY or PATCH) type" title:"Instruction" beep:false
		return 0		
	)

	
	fn GetVertexCurrentObject PutObject PutSearchCoord =
	(
		GetTypeObject = DetectTypeObject PutObject
		if (GetTypeObject == 0) then return 0
		--Need Get all vertex
		AllVert = PutObject.vertices.count
		--Need Count Vertex
		if  (GetTypeObject == 3) then --MESH
		(
			for n = 1 to AllVert do
			(
				VertPose = GetVert PutObject n
				if VertPose == PutSearchCoord then
				(
					format "OK - Find vertex %\n" n
					Return integer n
				)
			)
		)
		if  (GetTypeObject == 4) then --POLY
		(
			for n = 1 to AllVert do
			(
				VertPose = polyop.getVert PutObject n
				if VertPose == PutSearchCoord then
				(
					format "OK - Find vertex %\n" n
					Return integer n
				)
			)
		)		
		if  (GetTypeObject == 5) then --PATCH
		(
			for n = 1 to AllVert do
			(
				VertPose = patch.getVert PutObject n
				if VertPose == PutSearchCoord then
				(
					format "OK - Find vertex %\n" n
					Return integer n
				)
			)
		)				
	)

	fn AccessBtnSetTape =
	(
		if (Obj1.object != undefined) and (Obj2.object != undefined) then	BtnSetTape.enabled = true
	)
	
	fn ReturnCommandScript TypeOBJ =
	(
		if (TypeOBJ == 3) then --MESH
		(
			Return "getVert"
		)
		if (TypeOBJ == 4) then --POLY
		(
			Return "polyop.GetVert"
		)
		if (TypeOBJ == 5) then --PATCH
		(
			Return "patch.getVert"
		)
	)	
	
	fn AutoPresssBtnOBJ ObjName OBJTarget sOBJ P_Vert =
	(
		if isValidNode OBJTarget do (
			ObjName.Object = OBJTarget
			sOBJ = OBJTarget
			P_Vert.enabled = true
			AccessBtnSetTape()
			P_Vert.value = OBJTarget.vertices.count
			P_Vert.range = [1,P_Vert.value,P_Vert.value]			
		)		
	)
	
	fn GetFreeNumberLines =
	(	
		AllArrayIDLines = AllGetArrayCountLines()
		for n = 1 to 65535 do
		(
			FindN = 0
			for n2 = 1 to AllArrayIDLines.count do
			(
				if (AllArrayIDLines[n2] == n) then 
				(
					FindN = 1
					Exit
				)
			)
			if (FindN == 0) then
			(
				return n
			)
		)
		if (AllArrayIDLines.count == 0) then return 1
	return 0
	)
	
	fn ControlSpline =
	(
		NumberSpline= numSplines PickLine; format "NumberSpline: %\n" NumberSpline
		CountVertex = numKnots PickLine NumberSpline; format "CountVertex: %\n" CountVertex
		if CountVertex == 2 then	MessageBox "Line select only with 2 vertex" title:"ERROR!"
	)	
	
	
	fn BuildDistanceLine =
	(
		if (Obj1.object == Obj2.object) AND (Vert1.value == Vert2.value) then
		(
			messagebox "Not correctly selected vertices. Must be different" title:"Correct vertex" beep:false
			return 0
		)
		new_spline = splineShape ()
		FreeN = GetFreeNumberLines()
		addNewSpline new_spline
		new_spline.render_renderable = false
		new_spline.render_displayRenderMesh = false
		new_spline.render_useViewportSettings = false
		addKnot new_spline 1 #corner #curve [0,0,0]
		addKnot new_spline 1 #corner #curve [10,0,0]
		setMaterialID new_spline 1 1 FreeN
		FreeN = FreeN as string
		
		updateshape new_spline

		new_spline.pivot =[0,0,0]
		new_spline.pos = [0,0,0]	

		O1 = Obj1.object
		P1 = Vert1.value
		O2 = Obj2.object
		P2 = Vert2.value
		ThisLine = new_spline
		ctrl = float_script()
		new_spline.render_angle2.controller = ctrl
		ctrl.AddNode "PickObject1" O1
		ctrl.AddNode "PickObject2" O2
		ctrl.AddNode "ThisLine" ThisLine

		TypeOBJ = DetectTypeObject O1
		TXTCmd1 = ReturnCommandScript TypeOBJ
		TypeOBJ = DetectTypeObject O2
		TXTCmd2 = ReturnCommandScript TypeOBJ
		SetText1 = "P1 = "+TXTCmd1+" PickObject1 "+(P1 as string)
		SetText2 = "P2 = "+TXTCmd2+" PickObject2 "+(P2 as string)
		
		--false target )))	
		R1 = random 1 1000
		R2 = random 1 1000
		R3 = random 1 1000
		R4 = random 1 1000		
		txt = "Global_Track = "+(R1 as string)+"\n"
		txt += "rootScenes"+(R2 as string)+" = PickObject1\n"
		txt += "rootScenes"+(R3 as string)+" = PickObject2\n"
		txt += "rootScenes"+(R4 as string)+" = ThisLine\n"
		
		--easy hide script )))
		for n = 1 to 2000 do
		(
			txt += "\n"
		)
		-- this is script
		txt += "--Upss Sorry! Very more press ENTER (easy hide script))))\n"
		txt += "try(\n"
		txt += SetText1+"\n"
		txt += SetText2+"\n"			
		txt += "setknotpoint ThisLine 1 1 P1\n"
		txt += "setknotpoint ThisLine 1 2 P2\n"
		txt += "updateshape ThisLine\n"		
		txt += "GlobalArrayLinePos1["+FreeN+"] = P1\n"
		txt += "GlobalArrayLinePos2["+FreeN+"] = P2\n"		
		txt += "0) catch (0)"
		ctrl.script = txt
	)
	
	fn MakeCommandToLine=
	(
		AllArrayIDLines = AllGetArrayCountLines()
		
		Mx = FindMaxIDLine()
		if (Mx != undefined) then
		(
			gw.setTransform(Matrix3 1)
			for n = 1 to Mx do			
			(
				FindID = finditem AllArrayIDLines n
				if (FindID > 0) then
				(
					GetArrData = (distance GlobalArrayLinePos1[n] GlobalArrayLinePos2[n])
					if (RadioSCALE == 1) then GetArrData= GetArrData*10
					if (RadioSCALE == 3) then GetArrData = GetArrData/100
					if (RadioSCALE == 4) then GetArrData = GetArrData/1000
					AsString = formattedPrint GetArrData format:"#.2f" as string
					AsFloat = AsString as float
					DisF = formattedPrint AsFloat format:"0 g" as string	

					if (DefaultCenter == 1) then
					(
						gw.text ((GlobalArrayLinePos1[n]+GlobalArrayLinePos2[n])/2) DisF color:CurrentColorSize
					)
					else
					(
						gw.text GlobalArrayLinePos2[n] DisF color:CurrentColorSize
					)
					gw.setColor #line CurrentColorLine
					gw.Polyline #(GlobalArrayLinePos1[n], GlobalArrayLinePos2[n]) true
				)
				gw.enlargeUpdateRect #whole
				gw.updateScreen()
			)
		)
	)
	
	---------------------------------------------------------------------------------------------------CONTROL
	on MainWin open do
	(
	ColorLabel lbl2 "STEP BY STEP METHOD" 50 61 73	
	ColorLabel lbl3 "VISIBLE ON/OFF" 50 61 73		
	)
	
	on MainWin close do (
		unregisterRedrawViewsCallback MakeCommandToLine
		completeRedraw()
	)	

	on ChangeColorSize changed clr do (
		CurrentColorSize = clr
		MainWin.title = NameProject
		redrawViews()
	)
	
	on ChangeColorLine changed clr do (
		CurrentColorLine = clr
		MainWin.title = NameProject
		redrawViews()
	)	
	
	on Obj1 picked val do
	(
		Obj1.text = val.name
	)
	
	on Obj2 picked val do
	(
		Obj2.text = val.name
	)		
	
	on BtnPick2Vert changed theState do --No USE
	(
		FnGetSnapOldMode()
		if theState == true then
		(
			BtnPick2Vert.text = "The selection process now"
			GridActivate()
			--on isChecked do ThreePtAlignActive		
			clearListener()
			if (classOf (a01 = pickPoint prompt:"Pick 1st source point" snap:#3D) == Point3) then
			(	
				format "% OBJ: % \n" a01 GetPickNameObject
				Object1 = GetPickNameObject
				Vertex1 = GetVertexCurrentObject Object1 a01
				if Vertex1 == 0 then
				(
					DeactivateBuild()
					return undefined
				)
				--append CollectPoint (pointdata pos:a01 txt:"Point1" col:[255,0,0])
				if (classOf (a02 = pickPoint prompt:"Pick 2nd source point" snap:#3D rubberBand:a01) == Point3)  and (Vertex1 > 0) then
				(
					format "% OBJ: %\n" a02 GetPickNameObject
					Object2 = GetPickNameObject
					Vertex2 = GetVertexCurrentObject Object2 a02
					if Vertex2 == 0 then
					(
						DeactivateBuild()
						return undefined
					)
					--append CollectPoint (pointdata pos:a02 txt:"Point2" col:[0,255,0])
				)
			)
		)
		if canceled = true then
		(
			--#RightClick
			format "\n% - build method was canceled\n" NameProject
			DeactivateBuild()
		)
	)


	on BtnCenterSize changed theState do
	(
		if theState == true then	
		(	
			DefaultCenter = 0
			redrawViews()
		)
		else
		(
			DefaultCenter = 1
			redrawViews()
		)
	)
	
	on BtnSelectedLine changed theState do
	(
		if theState == true then	
		(
			DefaultAll = 0
			redrawViews()
		)
		else
		(
			DefaultAll = 1
			redrawViews()
		)
	)

	
	on BtnVisible changed theState do
	(
		if theState == true then
		(
			
		for s in shapes do --for all shapes on scene
		(
			if ((s.render_angle2.controller as string) == "Controller:Float_Script") then
			(
				ReWrite = s.render_angle2.controller.script
				s.render_angle2.controller.script = ReWrite
			)			
		)			
			RegisterRedrawViewsCallback MakeCommandToLine
			redrawViews()
		)
		else
		(
			unregisterRedrawViewsCallback MakeCommandToLine
			completeRedraw()
		)
	)
	
	on BtnSetTape pressed do 
	(
		BuildDistanceLine()
		redrawViews()
	)	
	
	on Obj1 picked obj do
	(
		AutoPresssBtnOBJ Obj1 obj sObj1 Vert1 
		if (Obj2.object == undefined) then
		(
			AutoPresssBtnOBJ Obj2 obj sObj2 Vert2
		)			
	)
	
	on Obj1 rightclick do
	(
		Obj1.object = sObj1 = undefined
		Vert1.enabled = false
		Vert1.value = 1
		BtnSetTape.enabled = false
	)

	on Obj2 picked obj do
	(
		AutoPresssBtnOBJ Obj2 obj sObj2 Vert2
	)	
	on Obj2 rightclick do
	(
		Obj2.object = sObj2 = undefined
		Vert2.enabled = false
		BtnSetTape.enabled = false
	)	
	
	
	----------------------------------------------------------------------
	on SizeCtrl pressed do
	(
		
		rollout SizeCTRL_Rol "Scale metric"
		(
			local NameRadionCh = #("mm", "cm", "m", "km")
			radiobuttons rad_buttons "" columns:1 default: RadioSCALE labels:#(NameRadionCh[1], NameRadionCh[2], NameRadionCh[3], NameRadionCh[4])
			on rad_buttons changed ValRd do
			(
				RadioSCALE = ValRd
				redrawViews()
				SizeCtrl.caption = NameRadionCh[ValRd]
			)
		)
		createDialog SizeCTRL_Rol 85 75 style:#(#style_titlebar, #style_sysmenu, #style_toolwindow)	modal:true
	)	

)
createdialog MainWin width:196 height:185 pos:[140,210] style:#(#style_titlebar, #style_sysmenu, #style_toolwindow) ; -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)