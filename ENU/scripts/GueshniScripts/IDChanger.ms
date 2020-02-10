 (
	global id_changer
	global id_changer_selectedFacesChanged
	con = dotNetClass "system.windows.Forms.Control"
	rollout id_changer "id_changer 1.5" width:162 height:185
	(
		label currentIDlabel "Selected ID:" pos:[2,3]
		label currentID "-" pos:[68,3]
		label select "select ID" pos:[117,3]
		label countIDlabel "#:" pos:[2,83]
		label countID "" pos:[15,83] align:#left
		label st "set ID" pos:[131,83]

		button b1 "1" pos:[0,20] width:20 height:20
		button b2 "2" pos:[20,20] width:20 height:20
		button b3 "3" pos:[40,20] width:20 height:20
		button b4 "4" pos:[60,20] width:20 height:20
		button b5 "5" pos:[80,20] width:20 height:20
		button b6 "6" pos:[100,20] width:20 height:20
		button b7 "7" pos:[120,20] width:20 height:20
		button b8 "8" pos:[140,20] width:20 height:20

		button b9 "9" pos:[0,40] width:20 height:20
		button b10 "10" pos:[20,40] width:20 height:20
		button b11 "11" pos:[40,40] width:20 height:20
		button b12 "12" pos:[60,40] width:20 height:20
		button b13 "13" pos:[80,40] width:20 height:20
		button b14 "14" pos:[100,40] width:20 height:20
		button b15 "15" pos:[120,40] width:20 height:20
		button b16 "16" pos:[140,40] width:20 height:20

		button b17 "17" pos:[0,60] width:20 height:20
		button b18 "18" pos:[20,60] width:20 height:20
		button b19 "19" pos:[40,60] width:20 height:20
		button b20 "20" pos:[60,60] width:20 height:20
		button b21 "21" pos:[80,60] width:20 height:20
		button b22 "22" pos:[100,60] width:20 height:20
		button b23 "23" pos:[120,60] width:20 height:20
		button b24 "24" pos:[140,60] width:20 height:20

		button m1 "1" pos:[0,100] width:20 height:20
		button m2 "2" pos:[20,100] width:20 height:20
		button m3 "3" pos:[40,100] width:20 height:20
		button m4 "4" pos:[60,100] width:20 height:20
		button m5 "5" pos:[80,100] width:20 height:20
		button m6 "6" pos:[100,100] width:20 height:20
		button m7 "7" pos:[120,100] width:20 height:20
		button m8 "8" pos:[140,100] width:20 height:20

		button m9 "9" pos:[0,120] width:20 height:20
		button m10 "10" pos:[20,120] width:20 height:20
		button m11 "11" pos:[40,120] width:20 height:20
		button m12 "12" pos:[60,120] width:20 height:20
		button m13 "13" pos:[80,120] width:20 height:20
		button m14 "14" pos:[100,120] width:20 height:20
		button m15 "15" pos:[120,120] width:20 height:20
		button m16 "16" pos:[140,120] width:20 height:20

		button m17 "17" pos:[0,140] width:20 height:20
		button m18 "18" pos:[20,140] width:20 height:20
		button m19 "19" pos:[40,140] width:20 height:20
		button m20 "20" pos:[60,140] width:20 height:20
		button m21 "21" pos:[80,140] width:20 height:20
		button m22 "22" pos:[100,140] width:20 height:20
		button m23 "23" pos:[120,140] width:20 height:20
		button m24 "24" pos:[140,140] width:20 height:20

		button ok "ok" width:150 height:16

		on ok pressed do
		(
			if($!=undefined) do	subobjectLevel = 0
		)

		fn clearCounters =
		(
			currentID.text = ""
			countID.text = ""
		)
		
		fn updateSelectedID_ePoly = 
		(
			sel=polyop.getFaceSelection $ as array
			
			--update count
			countID.text = sel.count as string
			
			--some faces must be selected
			if( sel.count<1) then
			(
				clearCounters()
				return false
			)

			--get first selected face setMaterialID
			matID = polyop.getFaceMatID $ sel[1]

			allSame = true
			for i = 1 to sel.count do 
			(
				if( polyop.getFaceMatID $ sel[i] != matID) then
				(
					allSame=false
					exit
				)
			)
			if(allSame) then currentID.text = matID as string else currentID.text = "--"
		)

		fn updateSelectedID_polyMesh =
		(
			sel = $.modifiers[#Edit_Poly].GetSelection #face
			countID.text = sel.numberSet as string
			
			currentID.text = "--"
			possibleID = 0
			sel=$.modifiers[#Edit_Poly].GetSelection #face

			for i = 1 to sel.count do
			(
				if (sel[i] == true AND possibleID == 0) do possibleID = (polyOp.getFaceMatID $ i)
				
				if (sel[i] == true AND (polyOp.getFaceMatID $ i) != possibleID) do return false
			)
			currentID.text = possibleID as string
		)
		
		fn updateSelectedID callback id =
		(
			--one ePoly must be selected
			if( selection.count!=1 OR subobjectLevel!=4 ) then 
			(
				clearCounters()
				return false
			)

			if( (classof $) == Editable_Poly ) do updateSelectedID_ePoly()
			
			if( (classof $) == PolyMeshObject ) do updateSelectedID_polyMesh()
		)
		
		fn removeFacesWithSpecificIDfromArray arr findId useBitArray:false =
		(
			for faceId = arr.count to 1 by -1 do
			(
				if (useBitArray == true) then
				(
					if (polyOp.getFaceMatID $ faceId == findId) do arr[faceId] = false
				)
				else
				(
					if (polyOp.getFaceMatID $ arr[faceId] == findId) do deleteItem arr faceId
				)
			)
		)
		
		fn selectID_ePoly id =
		(
			-- deselection
			if (con.modifierKeys == con.modifierKeys.Alt) then
			(
				sel = polyop.getFaceSelection $ as array
				removeFacesWithSpecificIDfromArray sel id
				polyop.setFaceSelection $ sel
			)
			else -- select new or add (with ctrl)
			(
				clearSelectionBool = (con.modifierKeys != con.modifierKeys.Control)
				$.EditablePoly.selectByMaterial id clearCurrentSelection:clearSelectionBool
			)
		)

		fn selectID_polyMesh id =
		(
			if (con.modifierKeys == con.modifierKeys.Alt) then
			(
				sel = $.modifiers[#Edit_Poly].GetSelection #Face --bitArray
				removeFacesWithSpecificIDfromArray sel id useBitArray:true
				$.modifiers[#Edit_Poly].SetSelection #Face sel
			)
			else -- select new or add to selection
			(
				if (con.modifierKeys != con.modifierKeys.Control) then
				(
					$.modifiers[#Edit_Poly].SetSelection #Face #{}
				)
				$.modifiers[#Edit_Poly].selectByMaterialID = id-1
				$.modifiers[#Edit_Poly].ButtonOp #SelectByMaterial
			)
		)
		
		fn selectID id =
		(
			if (ClassOf($) == Editable_Poly) then
			(
				if (subobjectLevel != 4) then subobjectLevel = 4
				selectID_ePoly id
			)
			
			if( ClassOf($) == PolyMeshObject) then
			(
				if (subobjectLevel != 4) then subobjectLevel = 4
				selectID_polyMesh id
			)
			redrawViews()
		)

		fn setID_ePoly id =
		(
			$.EditablePoly.setMaterialIndex id 1

			if( (polyop.getFaceSelection $ as array).count >= 1) do
			(
				currentID.text = id as string
			)
		)
		
		fn setID_polyMesh id =
		(
			$.modifiers[#Edit_Poly].SetOperation #SetMaterial
			$.modifiers[#Edit_Poly].materialIDToSet = id-1
			$.modifiers[#Edit_Poly].Commit ()	
			
			if( ($.modifiers[#Edit_Poly].GetSelection #face).count >= 1) do
			(
				currentID.text = id as string
			)
		)		
		
		fn setID id =
		(
			if (ClassOf($) == Editable_Poly) then
			(
				if (subobjectLevel != 4) then subobjectLevel = 4
				setID_ePoly id
			)
			if (ClassOf($) == PolyMeshObject) then
			(
				if (subobjectLevel != 4) then subobjectLevel = 4
				setID_polyMesh id
			)
		)

		on b1 pressed do ( selectID(1) )
		on b2 pressed do ( selectID(2) )
		on b3 pressed do ( selectID(3) )
		on b4 pressed do ( selectID(4) )
		on b5 pressed do ( selectID(5) )
		on b6 pressed do ( selectID(6) )
		on b7 pressed do ( selectID(7) )
		on b8 pressed do ( selectID(8) )
		on b9 pressed do ( selectID(9) )
		on b10 pressed do ( selectID(10) )
		on b11 pressed do ( selectID(11) )
		on b12 pressed do ( selectID(12) )
		on b13 pressed do ( selectID(13) )
		on b14 pressed do ( selectID(14) )
		on b15 pressed do ( selectID(15) )
		on b16 pressed do ( selectID(16) )
		on b17 pressed do ( selectID(17) )
		on b18 pressed do ( selectID(18) )
		on b19 pressed do ( selectID(19) )
		on b20 pressed do ( selectID(20) )
		on b21 pressed do ( selectID(21) )
		on b22 pressed do ( selectID(22) )
		on b23 pressed do ( selectID(23) )
		on b24 pressed do ( selectID(24) )
		on m1 pressed do ( setID(1) )
		on m2 pressed do ( setID(2) )
		on m3 pressed do ( setID(3) )
		on m4 pressed do ( setID(4) )
		on m5 pressed do ( setID(5) )
		on m6 pressed do ( setID(6) )
		on m7 pressed do ( setID(7) )
		on m8 pressed do ( setID(8) )
		on m9 pressed do ( setID(9) )
		on m10 pressed do ( setID(10) )
		on m11 pressed do ( setID(11) )
		on m12 pressed do ( setID(12) )
		on m13 pressed do ( setID(13) )
		on m14 pressed do ( setID(14) )
		on m15 pressed do ( setID(15) )
		on m16 pressed do ( setID(16) )
		on m17 pressed do ( setID(17) )
		on m18 pressed do ( setID(18) )
		on m19 pressed do ( setID(19) )
		on m20 pressed do ( setID(20) )
		on m21 pressed do ( setID(21) )
		on m22 pressed do ( setID(22) )
		on m23 pressed do ( setID(23) )
		on m24 pressed do ( setID(24) )

		on id_changer close do
		(
			id_changer_selectedFacesChanged = undefined
			gc()
		)
	)
	createDialog id_changer pos:[140,210] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)
	id_changer_selectedFacesChanged = NodeEventCallback mouseUp:true subobjectSelectionChanged:id_changer.updateSelectedID
)