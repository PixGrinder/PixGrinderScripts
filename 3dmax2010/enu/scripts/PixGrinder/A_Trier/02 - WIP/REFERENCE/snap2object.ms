/*
Maxscript to align an Object to the face normal of a geometry object (Mesh, Poly, Patch or NURBS).
Similar to AutoGrid, but for existing custom objects.

Category: Modeling Tool

Author: P.G.Preeth, Senior Technical Artist, Exigent Game Art Pvt. Ltd. India
Ideas by: Borislav Petrov, Martin Coven, Adrian Tysoe, Martin Breidt

Created on 26.02.2010

v1: Added a new feature .. You can now snap in any object without having to select the target object. You can also specify a target object to snap with.

*/
---------------------------------------------------------------------------------------------------------------------------------------------------------
rollout SnapObjects "Snap2Object Tool"
(
	group "Snap2Object options"
	(
		label txt0 "1. Specify the Clone surface" align:#left
		pickbutton CloneObj "<Pick Clone Object>" width:100
		label txt01 "--------------------------------------------------------------------" align:#left
		label txt1 "2. Specify the target surface" align:#left
		radiobuttons Multi_Rad  labels:#("Any Object", "Target Object" ) default:1
		pickbutton TargetObj "<Pick Target Object>" width:100 enabled:false
		label txt02 "--------------------------------------------------------------------" align:#left
		label txt03 "3. Select the clone type and hit the button" align:#left
		radiobuttons InsCopy_Rad  labels:#("Instance", "Copy" ) default:1
		checkbutton Clone_But "CLONE SNAP TOOL" tooltip:"Clones the object and snaps to the face of the other object" width:210 highlightColor:orange
	)
	
	group "Help"
	(
		label Help1 "> Press Alt or Ctrl to select an other axis" align:#left
		label Help2 "> Press SHIFT to flip the current axis" align:#left
		label Help3 "> Click-drag to rotate the clone object" align:#left
		label Help4 "> Visit www.pgpreeth.com" align:#left
	)
	on CloneObj picked obj do
	(
		CloneObj.text = obj.name
		Global CloneObjNode = obj
		clearSelection()
		global selObj = #()
	)
	on TargetObj picked obj do
	(
		TargetObj.text = obj.name
		Global TargetObjNode = obj
		clearSelection()
		global selObj = #()
	)
	on Multi_Rad changed thestate do
	(
		if Multi_Rad.state == 1 then
		(
			TargetObj.enabled = false
			)else
		(
			TargetObj.enabled = true
		)
	)
	on Clone_But changed thestate do
	(
		try
		(
			if Multi_Rad.state == 1 then 
			(
				select geometry
				deselect CloneObjNode
				NoofGeo = getCurrentSelection()
				clearSelection()
				Global TargetObjNode = NoofGeo
			)

			global  Obj_to_align = CloneObjNode
			global AO2F_surface_obj = TargetObjNode --pickobject filter:filter_geometry
			global Obj_Initial_Pos = Obj_to_align.transform
			---------------------------------------------------------------------------------------------------------------------------
			fn filter_geometry obj = superclassof obj == GeometryClass and classof obj != TargetObject
			---------------------------------------------------------------------------------------------------------------------------
			fn get_normal_function_Ins msg ir obj faceNum shift ctrl alt = -- Function to track the mouse and instance the clone object
			(
				if msg == #freeMove then
				(
					if ir != undefined then
					(
						Obj_to_align.pos = ir.pos 
						Obj_to_align.dir = ir.dir
						global NormalDirection = ir.dir
						-- Addition by Martin Breidt
						if ctrl then in coordsys local (rotate Obj_to_align (eulerangles 90 0 0))
						if alt then in coordsys local (rotate Obj_to_align (eulerangles 0 90 0))
						if shift then Obj_to_align.dir *= -1
						-- End Addition 
						return #continue
					)
					else(return #continue)
				)
				if msg == #mouseAbort then 
				(
					Obj_to_align.transform = Obj_Initial_Pos 
					print "Align Object To Face Aborted!\n" 
					Clone_But.state = false
					return #end
				)
				if msg == #mousePoint --then (return #continue)
				then
				(
					maxops.clonenodes CloneObjNode newNodes:&newClonedObj cloneType:#instance
					print "Align Object To Face Finished.\n" 
					return #continue
				)
				if msg == #mouseMove then 
				(
					if NormalDirection[1] != 0 then rotate CloneObjNode (eulerangles NormalDirection[1] 0 0)
					if NormalDirection[2] != 0 then rotate CloneObjNode (eulerangles 0 NormalDirection[2] 0)
					if NormalDirection[3] != 0 then rotate CloneObjNode (eulerangles 0 0 NormalDirection[3])
					return #continue
				)
			)
			---------------------------------------------------------------------------------------------------------------------------
			fn get_normal_function_copy msg ir obj faceNum shift ctrl alt = -- Function to track the mouse and copy the clone object
			(
				if msg == #freeMove then
				(
					if ir != undefined then
					(
						Obj_to_align.pos = ir.pos 
						Obj_to_align.dir = ir.dir
						global NormalDirection = ir.dir
						-- Addition by Martin Breidt
						if ctrl then in coordsys local (rotate Obj_to_align (eulerangles 90 0 0))
						if alt then in coordsys local (rotate Obj_to_align (eulerangles 0 90 0))
						if shift then Obj_to_align.dir *= -1
						-- End Addition 
						return #continue
					)
					else(return #continue)
				)
				if msg == #mouseAbort then 
				(
					Obj_to_align.transform = Obj_Initial_Pos 
					print "Align Object To Face Aborted!\n" 
					Clone_But.state = false
					return #end
				)
				if msg == #mousePoint --then (return #continue)
				then
				(
					maxops.clonenodes CloneObjNode newNodes:&newClonedObj cloneType:#copy
					print "Align Object To Face Finished.\n" 
					return #continue
				)
				if msg == #mouseMove then 
				(
					if NormalDirection[1] != 0 then rotate CloneObjNode (eulerangles NormalDirection[1] 0 0)
					if NormalDirection[2] != 0 then rotate CloneObjNode (eulerangles 0 NormalDirection[2] 0)
					if NormalDirection[3] != 0 then rotate CloneObjNode (eulerangles 0 0 NormalDirection[3])					
					return #continue
				)
			)	
			---------------------------------------------------------------------------------------------------------------------------
			fn get_normal_function_end msg ir obj faceNum shift ctrl alt = -- Function to track the mouse and copy the clone object
			(
					Obj_to_align.transform = Obj_Initial_Pos 
					print "Align Object To Face Aborted!\n" 
					Clone_But.state = false
					return #end
			)	
			---------------------------------------------------------------------------------------------------------------------------
			if InsCopy_Rad.state == 1 then
			(
				if Clone_But.state == true then(MouseTrack_Var = mouseTrack on:AO2F_surface_obj trackCallBack:get_normal_function_ins)
				else
				(
					MouseTrack_Var = mouseTrack trackCallBack:get_normal_function_end
					Clone_But.state = false
				)
			)
			else
			(
				if Clone_But.state == true then(MouseTrack_Var = mouseTrack on:AO2F_surface_obj trackCallBack:get_normal_function_copy)	
				else
				(
					MouseTrack_Var = mouseTrack trackCallBack:get_normal_function_end
					Clone_But.state = false
				)
			)			
		)
		catch
		(
			messageBox "Please check whether you have selected the nodes" title:"Clone Tool Error. help at pg.preeth@gmail.com"
			Clone_But.state = false
		)
	)
)
createDialog SnapObjects width:230
---------------------------------------------------------------------------------------------------------------------------------------------------------
-- @ pg.preeth@gmail.com