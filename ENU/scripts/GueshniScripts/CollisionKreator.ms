

try(destroyDialog CollisionKreatorRollout)catch()
rollout CollisionKreatorRollout "Collision Kreator" width:216 height:139
(
	GroupBox ConvexHullGoupBox "Convex Hull" pos:[8,8] width:200 height:121
	spinner VertLimit "Vertices max per Hull : " pos:[28,33] width:176 height:16 range:[4,100000,8] type:#integer
	spinner inflation "Inflation : " pos:[64,57] width:96 height:16 range:[-100000,100000,0]
	button CreateConvexHull "Create Convex Hull" pos:[48,81] width:112 height:40
	
	
	fn minimum a b =
	(
		if a > b then return b
			return a
	)
 
	fn maximum a b =
	(
		if a < b then return b
			return a
	)
	
	on CreateConvexHull pressed do
	(
		if selection.count == 1 then
		(
			if classOf $ == Editable_Poly then
			(
				selectedFaces = polyop.GetFaceSelection selection[1]
				if selectedFaces.isEmpty == false then
				(
					local InitialSubObjectLevel = SubObjectLevel
					local NewConvexHull
					polyop.detachFaces selection[1] selectedFaces delete:false asNode:true name:"NewName"
					NewConvexHull = getNodeByName "NewName"
					NewConvexHull.name = (uniqueName ("UCX_" + selection[1].name+"_"))
					ConvertToMesh NewConvexHull
					cvxHull = nvpx.CreateConvexHull NewConvexHull.mesh VertLimit.value Inflation.value
					NewConvexHull.mesh = cvxHull
					ConvertTo NewConvexHull Editable_Poly
					NewConvexHull.XRay = on
					subobjectLevel = InitialSubObjectLevel
				)
				else
				(
					MessageBox "No face selected :o"
				)
			)
			else
			(
				if QueryBox "The object must be an editable poly.\n\nConvert to editable poly now ?" do
				(
					ConvertTo $ Editable_Poly
					selectedFaces = polyop.GetFaceSelection selection[1]
					if selectedFaces.isEmpty == false then
					(
						local InitialSubObjectLevel = SubObjectLevel
						local NewConvexHull
						polyop.detachFaces selection[1] selectedFaces delete:false asNode:true name:"NewName"
						NewConvexHull = getNodeByName "NewName"
						NewConvexHull.name = (uniqueName ("Col_" + selection[1].name+"_"))
						ConvertToMesh NewConvexHull
						cvxHull = nvpx.CreateConvexHull NewConvexHull.mesh VertLimit.value 0
						NewConvexHull.mesh = cvxHull
						ConvertTo NewConvexHull Editable_Poly
						NewConvexHull.XRay = on
						subobjectLevel = InitialSubObjectLevel
					)
					else
					(
						MessageBox "No face selected :o"
					)
				)
			)
		)
		else
		(
			if selection.count == 0 do MessageBox "Selection is empty !"
			if selection.count > 1 do MessageBox "Please select only one object ;)"
		)
		
	)

)



CreateDialog CollisionKreatorRollout style:#(#style_titlebar, #style_sysmenu, #style_toolwindow) pos:[140,210] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)