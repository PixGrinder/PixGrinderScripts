--========================================================================--
--FB SubobjPivot.mcr--version 0.98--
------------------------------------------
--Description:
	--Toggles align pivot to a single selected subobject on meshes and poly objects (vertex, edge, face)
--------------------------------------------------------------------------------------------------
--How To Use:
	--context sensitive, so 
		--if in 'Edit Pivot' mode it'll modify the object's pivot
		--Otherwise, it'll:
		--		just change the working pivot
		--		Or if already in working pivot mode, it'll return to the last stored coordsystem and coordcenter
	--SelectionTypes:
		-- 1 VERTEX: sets pivot to vertex, and points along the normal
		-- 2 VERTS: sets pivot to the average of the two verts and points along the average of their normals
		-- 1 EDGE: sets pivot to the center of the edge and points along edge direction
		-- # TRIANGLES: sets pivot to center of triangle selection and points along first face normal
--========================================================================--
--Installation:
	--drop this .mcr file into ProgramFiles/3dsMax/ui/macroscripts
	--then start 3ds max
	--will appear in the 'Funky Tools' category in Customize User Interface
--========================================================================--
--email me with any questions at Chris@FunkyBunnies3d.com
--========================================================================--

macroScript FB_SubobjPivot
	category:"Funky Tools"
	toolTip:"align working pivot to selected sub-Obj (TGL) v0.98"
	buttonText:"FBsub-Obj Piv"
(
	Fn FB_SubobjPivot=
	(
		if selection.count == 1 then
		(
			try
			(
				obj = selection[1]
				max modify mode
				currModifier = modPanel.getCurrentObject()
				affectObjPivot = (maxOps.pivotMode == #pivotOnly)
				--used to default to editing the object's pivot, so the following commented-out line checks to see if youre in any workingpivot modes
						--Not (WorkingPivot.UseMode==True or WorkingPivot.EditMode==True or getRefCoordSys() == undefined)
				initShowEndResult = undefined
				NurmsPreview = undefined
				Subobjmode = undefined
				normalIsAverage = False
				
			--Global vars to store::
			--		current coordinate system [view, local, screen, etc]
				Global FBpivot_previousCoordsys = getRefCoordSys()
			--		current coordinate center [pivot, center, individual]
				Global FBpivot_previousCoordcenter = getCoordCenter()
				
				with redraw off
				( --do a couple error checks to turn off features that might interfere with determining the pivot:
					
				--Show End Result --must be turned off
						initShowEndResult = showEndResult
						showEndResult = false
				--NURMS toggle [editable poly] --must be turned off if available
						try
						(
							NurmsPreview = (currModifier.surfSubdivide)
							currModifier.surfSubdivide = off
						)catch()
				)
				
				Subobjmode = (getSelectionLevel currModifier)
				objSnap = snapshotasmesh obj
				pos = undefined
				dir = undefined
				dirUp = undefined
				p = undefined


				with redraw off
				(
					--currently only supports mesh/poly
					--determine subobject mode and assign new pivot accordingly
					if Subobjmode == #vertex then
					(
						selVerts = ((getVertSelection objSnap) as Array)
						selVert = selVerts[1]
					--Different context based on the selected points:
						--if 1 vert is selected set it to the vertex normal and align to the first connected vertex according to ID
						if selVerts.count==1 then
						(
							pos = objSnap.Selectedverts[1].pos
							
							
							--For Dir, decide whether to take an existing normal or to average them
							if NormalIsAverage then
							(--IT ACTUALLY NEVER GETS TO THIS POINT AT THE MOMENT BECUASE NORMALISAVERAGE IS SET TO FALSE
								--but this is put here in case I want to add any sort of averaged normals for this shit
								facelist = (meshop.getFacesUsingVert  objSnap selVert) as Array
								facelist = (meshop.getPolysUsingFace objSnap facelist) as Array
								obj.selectedfaces = facelist
								dir = [0,0,0]
								for numFaces=1 to facelist.count do
								(
									print (getFaceNormal objSnap facelist[numfaces])
									dir = dir + (getFaceNormal objSnap facelist[numfaces])
								)
								--dir = (dir/facelist.count)
							)
							else
							(
								dir = getNormal objSnap selVert
							
								--include calculation from connected edge
								connectedEdge = (meshop.getEdgesUsingVert objSnap selVert as Array)[1]
								connectedVerts = (meshop.getVertsUsingEdge objSnap connectedEdge) as array
								for vertexIDtest in connectedVerts do
								(
									if vertexIDtest != selVert then
									(--take the first valid connected vertex and use the vector of selectedvert-->connected vert to calculate 'up' vector
										vert1pos = pos
										vert2pos = objSnap.verts[vertexIDtest].pos
										dirUp = normalize ([(vert1pos.x-vert2pos.x), (vert1pos.y-vert2pos.y), (vert1pos.z-vert2pos.z)])
										exit
									)
								)
							)
						)
						else if (selVerts.count >= 2) then
						(
							--if over 2 verts are selected, issue a warning and say the first 2 vertexID's were taken
							if (selVerts.count>2) then
								print "Warning: more than 2 verts selected!! Only first 2 vertID's were taken"
							
							selVert2 = selVerts[2]
							vert1pos = objSnap.verts[selVert].pos
							vert2pos = objSnap.verts[selVert2].pos
							
							--average position and vertex normal as Z vector
							pos = (vert1pos + vert2pos)/2
							dirUp = normalize (( (getNormal objSnap selVert) + (getNormal objSnap selVert2) )/2)
							
							--use direction of vert1 -> vert2 as main dir vector
							dir = normalize ([(vert1pos.x-vert2pos.x), (vert1pos.y-vert2pos.y), (vert1pos.z-vert2pos.z)])
						)
						
					)
					else if Subobjmode== #edge then
					(
						selEdges = (getEdgeSelection objSnap.mesh as Array)
						selEdge = selEdges[1]
						if selEdges.count>=1 then
						(
							--if over 1 edge is selected, issue a warning and say only the first edgeID was taken
							if selEdges.count>1 then
								print "Warning: more than 1 edge selected!! Only first edgeID's was taken"
								
							--initVertsel = getVertSelection objSnap.mesh
							connectedVerts = (meshop.getVertsUsingEdge objSnap selEdge) as array
							vert1pos = objSnap.verts[connectedVerts[1]].pos
							vert2pos = objSnap.verts[connectedVerts[2]].pos
							pos = [(vert1pos.x +vert2pos.x)/2, (vert1pos.y +vert2pos.y)/2, (vert1pos.z +vert2pos.z)/2]
							dir = normalize ([(vert1pos.x-vert2pos.x), (vert1pos.y-vert2pos.y), (vert1pos.z-vert2pos.z)])
							
							--include calculation from connected edge
							connectedFace = (meshop.getFacesUsingEdge objSnap selEdge as Array)[1]
							dirUp = getFaceNormal objSnap connectedFace
						)
						
					)
					else if Subobjmode== #face then
					(
						selFaces = (getFaceSelection objSnap as array)
						selFace = selFaces[1]
						--this will only return the first triangle of whatever polygon you have selected.
						--for now I'm simply taking this face's normal as the direction
						
						if selFaces.count>1 then
						(
							combinedPos = [0,0,0]
							for currFace in selFaces do
							(
								currFacePos = (meshOp.getFaceCenter objSnap currFace)
								combinedPos = (combinedPos + currFacePos)
							)
							pos = (combinedPos/selFaces.count)
						)
						else
						(
							pos = meshOp.getFaceCenter objSnap selFace
						)
						dir = getFaceNormal objSnap selFace
						
						--include calculation with connected edge
						connectedEdge = (meshop.getEdgesUsingFace objSnap selFace as Array)[1]
						connectedVerts = (meshop.getVertsUsingEdge objSnap connectedEdge) as array
						vert1pos = objSnap.verts[connectedVerts[1]].pos
						vert2pos = objSnap.verts[connectedVerts[2]].pos
						dirUp = normalize ([(vert2pos.x-vert1pos.x), (vert2pos.y-vert1pos.y), (vert2pos.z-vert1pos.z)])
					)
					else --otherwise no valid subobjects selected so abort
						return False
					
					p = point()
					p.dir = dir
					p.pos = pos
				
					if dirUp != undefined then
					(
						--As a quick final catch, just in case the vectors AREN'T perpendicular do a check with priority given to Dir so that vector is always correct, and rotate DirUp to be 90º to that
						-- X axis = [third orthogonal axis based on dirUp and dir]
						-- Y axis = dirUp
						-- Z axis = dir
						dirUp = ((dot dir dirUp) * -dir + dirUp)
						p.transform = orthogonalize (matrix3 (cross dirUp dir) dirUp dir pos)
					)

					newOO = obj.objectTransform * (inverse p.Transform) 
				)
				if (affectObjPivot) then
				(	
					obj.objectoffsetpos = newOO.translationpart 
					obj.objectoffsetrot = newOO.rotationpart
					obj.objectoffsetscale = newOO.scalepart
					
					obj.transform = p.transform
					toolMode.coordsys #parent
				)
				else
				(
						WorkingPivot.editMode = true
						WorkingPivot.setTM p.transform
						WorkingPivot.UseMode = true						
				)
				--Turn back on any settings that we disabled before this operation
					--Show End Result
						showEndResult = initShowEndResult
					--NURMS toggle [editable poly]
						try(currModifier.surfSubdivide = NurmsPreview)catch()
				delete objSnap
				delete p
				--lastly, delete temporary object P and object snapshot objSnap, then set the selection back to the original modifier on the original object selection
				modPanel.setCurrentObject currModifier node:obj
				update obj
			)catch(return False)
			
		)
		else
			return False
	)
	
	undo "FB Sub-Obj Pivot" on
	(	
		if (undefined==getRefCoordSys() and (maxOps.pivotMode != #pivotOnly)) then
		(
			try
			(
				if (FBpivot_previousCoordsys!=undefined) then
				(
					setrefCoordSys FBpivot_previousCoordsys
					setCoordCenter FBpivot_previousCoordcenter
				)
				else
				(
					toolMode.coordsys #view
					setCoordCenter FBpivot_previousCoordcenter
				)
				print "Reference Coord system reset"
			)
			catch(print "FAILED to reset reference coordinate system")
		)
		else
		(
			if selection.count == 1 then
			(
				if FB_SubobjPivot() == false then
					print "FAILED to align pivot to sub-obj"
				else
					print "FB Sub-obj Pivot successful"
			)
			else if selection.count > 1 then
				print "Aborted: Too many objects selected, FB Sub-obj Pivot supports only 1 object at a time"
			--else selection,count == 0, so just ignore
		)
	)
)