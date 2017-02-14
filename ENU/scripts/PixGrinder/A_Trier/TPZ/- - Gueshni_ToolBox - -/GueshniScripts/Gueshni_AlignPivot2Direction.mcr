macroScript AlignPivot2direction category:"- Gueshni -" Icon:#("g9_alignpivot2direction", 1) tooltip:"Align Pivot to Direction"
 (
	global miauuAlignObjectToVector
	local objToAlignArr = #()
	local pickedPoint
	
	tool miauuAlignPivotToVector
	(
		on mousePoint clickno do
		(
			if clickno == 1 do
			(
				pickedPoint = worldPoint
			)
		)
	)
	
	function TransformPivot obj vec dir =
	(
		vec = obj.transform[1]
		tm = obj.transform
		vec = normalize vec
		dir = normalize dir
		rtm = angleaxis (acos (dot vec dir)) (normalize (cross dir vec))
		tempObjTM = translate (rotate (scalematrix tm.scale) (tm.rotation*rtm)) tm.pos
		--
		worldAlignPivot obj
		rotation = inverse tempObjTM.rotation
		in coordsys local obj.rotation *= rotation
		obj.objectoffsetrot *= rotation
		obj.objectoffsetpos *= rotation	
		
	)
	
	function AlignPivotToVector axis: pos: =
	(	
		local curSnapMode = snapMode.active
		local curSnapType = snapMode.type
		snapMode.active = true
		snapMode.type = #3D
		p1 = startTool miauuAlignPivotToVector numPoints:1
		if p1 != undefined and p1 != #escale and p1 != #abort do
		(
			p1 = pickedPoint
			p2 = startTool miauuAlignPivotToVector numPoints:1			
			if p2 != undefined and p2 != #escale and p2 != #abort do
			(
				p2 = pickedPoint
				if axis == #xyz then
				(
					--	p1 and p2 define the X axis
					p3 = startTool miauuAlignPivotToVector numPoints:1
					if p3 != undefined and p3 != #escale and p3 != #abort do
					(
						p3 = pickedPoint
						p4 = startTool miauuAlignPivotToVector numPoints:1
						if p4 != undefined and p4 != #escale and p4 != #abort do
						(
							--	p3 and p4 define the Y axis
							p4 = pickedPoint
							p5 = startTool miauuAlignPivotToVector numPoints:1
							if p5 != undefined and p5 != #escale and p5 != #abort do
							(
								--	p5 and p6 define the Z axis
								p5 = pickedPoint
								p6 = startTool miauuAlignPivotToVector numPoints:1
								if p6 != undefined and p6 != #escale and p6 != #abort do
								(
									p6 = pickedPoint
									if classOf p1 == point3 and classOf p2 == point3 and classOf p3 == point3 and classOf p4 == point3 and classOf p5 == point3 and classOf p6 == point3 do
									(	
										
										dirX = normalize (p2 - p1)
										dirY = normalize (p4 - p3)
										dirZ = normalize (p6 - p5)
										for obj in objToAlignArr do
										(
											--	align X axis
											tm = obj.transform
											vec = normalize obj.transform[1]
											dir = normalize dirX
											rtm = angleaxis (acos (dot vec dir)) (normalize (cross dir vec))
											tempObjTM = translate (rotate (scalematrix tm.scale) (tm.rotation*rtm)) tm.pos
											worldAlignPivot obj
											rotation = inverse tempObjTM.rotation
											in coordsys local obj.rotation *= rotation
											obj.objectoffsetrot *= rotation
											obj.objectoffsetpos *= rotation
											--	align Y axis
											tm = obj.transform
											vec = normalize obj.transform[2]
											dir = normalize dirY
											rtm = angleaxis (acos (dot vec dir)) (normalize (cross dir vec))
											tempObjTM = translate (rotate (scalematrix tm.scale) (tm.rotation*rtm)) tm.pos
											worldAlignPivot obj
											rotation = inverse tempObjTM.rotation
											in coordsys local obj.rotation *= rotation
											obj.objectoffsetrot *= rotation
											obj.objectoffsetpos *= rotation
											--	align Z axis
											tm = obj.transform
											vec = normalize obj.transform[3]
											dir = normalize dirZ
											rtm = angleaxis (acos (dot vec dir)) (normalize (cross dir vec))
											tempObjTM = translate (rotate (scalematrix tm.scale) (tm.rotation*rtm)) tm.pos
											worldAlignPivot obj
											rotation = inverse tempObjTM.rotation
											in coordsys local obj.rotation *= rotation
											obj.objectoffsetrot *= rotation
											obj.objectoffsetpos *= rotation
											if pos == true do obj.pivot = p1
										)
									)
								)
							)
						)
					)
				)
				else
				(
					if classOf p1 == point3 and classOf p2 == point3 do
					(	
						dir = normalize (p2 - p1)
						for obj in objToAlignArr do
						(
							--	align the temporary matrix
							vec = case axis of
							(
								#x: obj.transform[1] 
								#y: obj.transform[2] 
								#z: obj.transform[3] 
							)
							tm = obj.transform
							vec = normalize vec
							dir = normalize dir
							rtm = angleaxis (acos (dot vec dir)) (normalize (cross dir vec))
							tempObjTM = translate (rotate (scalematrix tm.scale) (tm.rotation*rtm)) tm.pos
							--
							worldAlignPivot obj
							rotation = inverse tempObjTM.rotation
							in coordsys local obj.rotation *= rotation
							obj.objectoffsetrot *= rotation
							obj.objectoffsetpos *= rotation
							if pos == true do obj.pivot = p1
						)
					)
				)
				snapMode.active = curSnapMode
				try(snapMode.type = curSnapType)catch()				
			)
		)	
	)
		
	if selection.count != 0 then
	(
		objToAlignArr = selection as array
		try
		(
			rcMenu rcMapSize
			(
				menuItem alignX "Align X axis" checked:false
				menuItem alignY "Align Y axis" checked:false
				menuItem alignZ "Align Z axis" checked:false
				menuItem alignXYZ "Align XYZ axes" checked:false
				
				on alignX picked do with undo "Align Pivot to Vector" on
				(
					if keyboard.shiftPressed then
						AlignPivotToVector axis:#X pos:true
					else
						AlignPivotToVector axis:#X pos:false
				)
				on alignY picked do with undo "Align Pivot to Vector" on
				(
					if keyboard.shiftPressed then
						AlignPivotToVector axis:#Y pos:true
					else
						AlignPivotToVector axis:#Y pos:false
				)
				on alignZ picked do with undo "Align Pivot to Vector" on
				(
					if keyboard.shiftPressed then
						AlignPivotToVector axis:#Z pos:true
					else
						AlignPivotToVector axis:#Z pos:false
				)	
				on alignXYZ picked do with undo "Align Pivot to Vector" on
				(
					if keyboard.shiftPressed then
						AlignPivotToVector axis:#XYZ pos:true
					else
						AlignPivotToVector axis:#XYZ pos:false
				)
			) 
			rcPos = mouse.screenpos
			popUpMenu rcMapSize pos:rcPos
		)catch()		
	)
	else
		messagebox "Select some objects" title:"Invalid Selection"
)