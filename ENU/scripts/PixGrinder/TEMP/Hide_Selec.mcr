-- Pix_Hide -- 
-- Hide_Selec.ms--

macroScript Hide_Selec ------- 
category:"-- PixGrinder --"
toolTip:"Hide_Selec" ------- 
buttonText:"Hide_Selec" ------- 
--icon:#("UVWUnwrapModes",15)
silentErrors:true
autoUndoEnabled:true

(
	clearListener()
	max modify mode

	if selection.count > 1 do (for obj in selection do obj.isHidden = true)

	if selection.count == 1 then
	(	
		if superClassOf selection[1] == GeometryClass then 
		(
			if subobjectlevel == 0 then 
			(
				selection[1].isHidden = true
				clearSelection()
			)
			if subobjectlevel == 1 then
			(
			-- 	if classof selection[1] == Editable_Poly then selection[1].EditablePoly.Hide #Vertex
				if classof selection[1] == Editable_Poly then polyop.setHiddenVerts $ (polyop.getHiddenVerts $ + (polyop.getVertSelection $))
				if classof selection[1] == Editable_mesh then meshop.setHiddenVerts $ (meshop.getHiddenVerts $ + (getVertSelection $))
			)

			if subobjectlevel == 3 then
			(
				if classof selection[1] == Editable_mesh then meshop.setHiddenFaces $ (meshop.getHiddenFaces $ + (getFaceSelection $))
			)

			if subobjectlevel == 4 or subobjectlevel == 5 then
			(
				if classof selection[1] == Editable_Poly then polyop.setHiddenFaces $ (polyop.getHiddenFaces $ + (polyop.getFaceSelection $))
				if classof selection[1] == Editable_mesh then meshop.setHiddenFaces $ (meshop.getHiddenFaces $ + (getFaceSelection $))
			)
			redrawViews()
		) else (
				selection[1].isHidden = true
		)	
	)

	/*
	-- Mesh Edge Visibility --
	
	-- Not working for the moment--

	setEdgeVis $ (getEdgeSelection $) false
	-- see "edge_method_temp.ms" for the tests.  
	*/
)
