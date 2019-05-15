macroScript EasyPivot category:"- Gueshni -" Icon:#("g9_easypivot", 1) tooltip:"Easy Pivot"
(
rollout Pivot_tool "Easy Pivot" width:240 height:150
(
	GroupBox functions "Controls" pos:[8,5] width:224 height:136
	dropdownList droplist1 "" pos:[96,49] width:128 height:21 items:#("Center", "Bottom", "Top", "Right", "Left", "Front", "Back", "Top Right", "Top Left", "Top Front", "Top Back", "Bottom Right", "Bottom Left", "Bottom Front", "Bottom Back") selection:1 toolTip:"Choose a position to place the pivot"
	label lbl1 "Pivot Position : " pos:[16,53] width:75 height:16
	button Reset_Pivot "Reset" pos:[128,93] width:96 height:32 toolTip:"Change pivot position."
	button apply "Apply" pos:[16,93] width:96 height:32 toolTip:"Change pivot position."
	
	local ConvertClass = dotnetclass "system.convert"
	local ImageClass = dotnetclass "system.drawing.image"
	local ColorClass =dotnetclass "system.drawing.color"
	local Align = dotnetclass "System.Drawing.ContentAlignment"

	--Conversion String
	fn String2Image string =
(
	bytearr = convertclass.FromBase64String string
	memstream = dotnetobject "System.IO.MemoryStream" bytearr
	DecodedImg = ImageClass.fromstream memstream
	memstream.close()
	return DecodedImg
)	

	on Reset_Pivot pressed do
	(
		if $ == undefined do 
		(
			messageBox "No object is selected!" title:"Easy Pivot Error !" beep:true
		)
		
		if $ != undefined do 
		(
			for obj in $ do
		(
			--Variables for positions
			ResetPivot obj
		)
			
		)
	)
	on apply pressed do
	(
		if $ == undefined do 
		(
			messageBox "No object is selected!" title:"Easy Pivot Error !" beep:true
		)
		
		if $ != undefined do 
		(
			for obj in $ do
		(
			--Variables for positions
			CenterPivot obj
			CurPos = obj.position
			MaxPos = obj.max
			MinPos = obj.min
			
			
			if droplist1.selection == 1 do
			(
				--Placing the picot at the CENTER if the object
				CenterPivot obj
			)
				
			if droplist1.selection == 2 do
			(
				--Placing the pivot at the BOTTOM of the object
				obj.pivot = [CurPos.x,CurPos.y,MinPos.z]
			)
				
			-- Function based on selection
			if droplist1.selection == 3 do
			(
				--Placing the pivot at the TOP of the object
				obj.pivot = [CurPos.x,CurPos.y,MaxPos.z]
			)
			
			-- Function based on selection
			if droplist1.selection == 4 do
			(
				--Placing the pivot at the RIGHT of the object
				obj.pivot = [MaxPos.x,CurPos.y,CurPos.z]
			)
			
			-- Function based on selection
			if droplist1.selection == 5 do
			(
				--Placing the pivot at the LEFT of the object
				obj.pivot = [MinPos.x,CurPos.y,CurPos.z]
			)
			
			-- Function based on selection
			if droplist1.selection == 6 do
			(
				--Placing the pivot at the FRONT of the object
				obj.pivot = [CurPos.x,MinPos.y,CurPos.z]
			)
			
			-- Function based on selection
			if droplist1.selection == 7 do
			(
				--Placing the pivot at the BACK of the object
				obj.pivot = [CurPos.x,MaxPos.y,CurPos.z]
			)
			
			-- Function based on selection
			if droplist1.selection == 8 do
			(
				--Placing the pivot at the TOP RIGHT of the object
				obj.pivot = [MaxPos.x,CurPos.y,MaxPos.z]
			)
			
			-- Function based on selection
			if droplist1.selection == 9 do
			(
				--Placing the pivot at the TOP LEFT of the object
				obj.pivot = [MinPos.x,CurPos.y,MaxPos.z]
			)
			
			-- Function based on selection
			if droplist1.selection == 10 do
			(
				--Placing the pivot at the TOP FRONT of the object
				obj.pivot = [CurPos.x,MinPos.y,MaxPos.z]
			)
			
			-- Function based on selection
			if droplist1.selection == 11 do
			(
				--Placing the pivot at the TOP BACK of the object
				obj.pivot = [CurPos.x,MaxPos.y,MaxPos.z]
			)
			
			-- Function based on selection
			if droplist1.selection == 12 do
			(
				--Placing the pivot at the BOTTOM RIGHT of the object
				obj.pivot = [MaxPos.x,CurPos.y,MinPos.z]
			)
			
			-- Function based on selection
			if droplist1.selection == 13 do
			(
				--Placing the pivot at the BOTTOM LEFT of the object
				obj.pivot = [MinPos.x,CurPos.y,MinPos.z]
			)
			
			-- Function based on selection
			if droplist1.selection == 14 do
			(
				--Placing the pivot at the BOTTOM FRONT of the object
				obj.pivot = [CurPos.x,MinPos.y,MinPos.z]
			)
			
			-- Function based on selection
			if droplist1.selection == 15 do
			(
				--Placing the pivot at the BOTTOM BACK of the object
				obj.pivot = [CurPos.x,MaxPos.y,MinPos.z]
			)
				
				
		)
			
		)
	)
)
createdialog Pivot_tool
)