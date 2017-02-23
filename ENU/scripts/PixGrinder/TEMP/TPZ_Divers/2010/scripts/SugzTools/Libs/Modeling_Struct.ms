/*##############################################################################
SugzTools Modeling Struct
Version 1.08
Script By Clément "Sugz" Plantec
plantec.clement@gmail.com

#Required Components:
SugzTools Selection Struct

#Script infos:
Collection of functions to speed up the modeling workflow

*Use / Modify this script at your own risk !*
###############################################################################*/



struct ModelingStruct
(
	
	/* Convert selection to editable poly without breaking instances ********************************************************************************/
	fn ConvertToEditPolyFn = 
	(
		-- add editpoly modifier to the first instances of each object in the selection and collapse it
		for obj in (_sgz._sel.DeleteInstanceFromSelectionFn()) do 
		(
			addModifier obj (Edit_Poly())
			maxOps.CollapseNodeTo obj 1 off
		)
	),
	
	
	
	/* Create a box that fit a boundingbox *********************************************************************************************************************************/
	fn CreateBbBoxFn obj segs:1 =
	(
		/*<Function>
		Arguments:
			<Object> obj: The object from which the boundingbox Box have to be created
			<Optional> <Integer> segs: define the number of segment of the box
		Return:
			<Object> bbBox: the boundingbox Box
		</Function>*/
		
		boundingBox = nodeGetBoundingBox obj obj.transform
		bbSize = boundingBox[2] - boundingBox[1]
		bbBox = box width:bbSize[1] length:bbSize[2] height:bbSize[3] widthsegs:segs lengthsegs:segs heightsegs:segs
		centerPivot bbBox
		bbBox.transform = obj.transform
		
		bbBox
	),
	
	
	
	/* Get a single snapshot***************************************************************************************************************/
	fn SingleSnapShotFn objs = 
	(
		/*<Function>
		Arguments:
			<Array> objs: Objects to make a snapshot of
		Return:
			<Object> ss: The snapshot 
		</Function>*/
		
		local ss 									-- The snapshot to return
		if objs.count == 1 then			-- Snapshot for one object
		(
			ss = snapshot objs[1]
			resetPivot ss
			centerPivot ss
		)
		else 										-- Create a snapshot for each object then merge them into one mesh
		(
			snapShotArray = for obj in objs collect (SingleSnapShotFn #(obj))
			ss = Editable_Mesh()
			for i = 1 to snapShotArray.Count do 
			(
				if canConvertTo snapShotArray[i] Mesh then 
					meshop.attach ss snapShotArray[i]
				else
				(
					meshop.attach ss (CreateBbBoxFn snapShotArray[i])
					delete snapShotArray[i]
				)
				
			)
			centerPivot ss
		)
		
		ss
	),
	
	
	
	/* Return the size of a bouding box *********************************************************************************************************************************/
	fn WorldBBoxMinMaxFn nodes =
	(
		/*<Function>
		Arguments:
			<Object> nodes: The nodes to get the bouding box
			<Optional> <Bool> includeChildren : define if the bouding have to get children hierarchy
		Return:
			<Point3> size: Minimum and maximum of the bounding box
		Further Infos:
			function by Denis Trofimov aka DenisT
		</Function>*/
		
		bMin = [1e100, 1e100, 1e100]
		bMax = [-1e100, -1e100, -1e100]
		
		for n in nodes do 
		(
			nMin = n.min
			nMax = n.max
		
			bMin.x = amin bMin.x nMin.x
			bMin.y = amin bMin.y nMin.y
			bMin.z = amin bMin.z nMin.z

			bMax.x = amax bMax.x nMax.x
			bMax.y = amax bMax.y nMax.y
			bMax.z = amax bMax.z nMax.z
		)

-- 		modPanel.addModToSelection (XForm ()) ui:on
-- 		center = ((nodes[1].modifiers[1]).gizmo).position
-- 		bMin = (getModContextBBoxMin nodes[1] (nodes[1].modifiers[1]) + center )
-- 		bMax = (getModContextBBoxMax nodes[1] (nodes[1].modifiers[1]) + center )
-- 		for n in nodes do deleteModifier n 1
		
		 #(bMin, bMax)
	),
	


	/* Quickly change the pivot of selection *********************************************************************************************************************************/
	fn QuickPivotToolFn = 
	(
		-- Get the snapshot to create the selection boundingbox Box
		ss = SingleSnapShotFn (getCurrentSelection())
		bbBox = convertToPoly(CreateBbBoxFn ss segs:2)
		
		-- Create an empty array to store all points and splines
		pivotHelperArray = #() 	
		
		-- Create a point for each vertex							
		for i = 1 to polyop.getNumVerts bbBox do 
		(
			pos = polyop.getVert bbBox i
			thePoint = Point pos:pos cross:off box:on constantscreensize:on drawontop:on size:5 
			thePoint.wirecolor = color 0 255 0
			append pivotHelperArray thePoint
		)
		
		-- Create a line for each edge
		for i = 1 to polyop.getNumEdges bbBox do 
		(
			polyop.createShape bbBox i name: (uniqueName "PivotLine")
			$PivotLine*.wirecolor = color 0 0 255
			append pivotHelperArray $PivotLine*
		)
		
		-- Delete the box and snapshot
		delete bbBox
		delete ss
		
		-- Let the user pick a point to define the new pivot position
		fn pointFilter pt = (ClassOf pt == Point)
		thePoint = pickObject prompt:"Pick a point" filter:pointFilter 
		
		-- Add the possibility to cancel with escape
		if not keyboard.escPressed then 
		(
			
			if selection.count == 1 then			-- Set the object pivot to the selected point
				$.Pivot = thePoint.position
			else 												-- Turn on the working pivot and set its position to selected point
			(
				workingPivot.setTM thePoint.transform
				WorkingPivot.UseMode = true
			)
		)

		-- Delete all points and lines 
		for obj in pivotHelperArray do delete obj
	),
	
	

	/* Add Unwrap_UVW modifier, open the editor, set to face selection and freeform mode *****************************************************************************************************/
	fn UnwrapUVWModFn = 
	(
		if _sgz._sel.GetSelectionCountFn() then 
		(
			-- check selection count
-- 			if selection.count == 1 
-- 				then setUVWModifier $
-- 				else setUVWModifier $[1]
		)
	)
	
	
)

