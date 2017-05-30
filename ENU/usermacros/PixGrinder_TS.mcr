-------------------------------------------------------------------------------
-- PixGrinder.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( pixgrinder@gmail.com )
-- 05/04/2016
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
(
	
	macroScript AutoSavePixGrinder
	category:"-- PixGrinder --"
	toolTip:"AutoSave - PixGrinder"
	buttonText:"AutoSave - PixGrinder"
	icon:#("FileLinkActionItems",9)
	silentErrors:false
	autoUndoEnabled:false
	(
		FileIn "$userScripts/PixGrinder/AutoSave_PixGrinder.ms"
	)


	macroScript BboxTrueMaker
	category:"-- PixGrinder --"
	toolTip:"Bbox True Maker"
	buttonText:"Bbox True Maker"
	--icon:#("FileLinkActionItems",9)
	silentErrors:false
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/Bbox_TrueMaker.ms"
	)



	macroScript NamesTransfer
	category:"-- PixGrinder --"
	toolTip:"Names Transfert"
	buttonText:"NamesTransfer"
	--icon:#("FileLinkActionItems",9)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/NamesTransfer.ms"
	)




	macroScript Collapse_Selected
	category:"-- PixGrinder --"
	toolTip:"Collapse Hierarchy on Selection"
	buttonText:"Collapse Selected"
	icon:#("PixGrinder",1)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/Collapse.mse"
	)
	
	macroScript ResetXForm
	category:"-- PixGrinder --"
	toolTip:"ResetXForm on Selection"
	buttonText:"ResetXForm"
	icon:#("PixGrinder",4)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/ResetXform.mse"
	)
	
	macroScript Select_Previous_Object
	category:"-- PixGrinder --"
	toolTip:"Select Previous Object"
	buttonText:"Select Previous Object"
	icon:#("PixGrinder",3)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Select_Prev_v6.ms"
	)
	
	macroScript Select_Next_Object
	category:"-- PixGrinder --"
	toolTip:"Select Next Object"
	buttonText:"Select Next Object"
	icon:#("PixGrinder",2)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Select_Next_v6.ms"
	)
	
	macroScript Duplicator
	category:"-- PixGrinder --"
	toolTip:"Duplicator"
	buttonText:"Duplicator"
	icon:#("PixGrinder",15)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Duplicator_v2.mse"
	)
	
	macroScript Select_Hierarcy
	category:"-- PixGrinder --"
	toolTip:"Select Hierarchy"
	buttonText:"Select Hierarchy"
	icon:#("PixGrinder",16)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/Select_Hierarchy.mse"
	)
	
	macroScript Rotation_Activator
	category:"-- PixGrinder --"
	toolTip:"Rotation_Activator"
	buttonText:"Rotation_Activator"
	icon:#("FileLinkActionItems",1)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Rotation_Activator.mse"
	)
	
	macroScript CleanLayers
	category:"-- PixGrinder --"
	toolTip:"Clean Layers"
	buttonText:"Clean Layers"
	icon:#("PixGrinder",8)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/CleanLayers_v2.ms"
	)

	macroScript AssignCurrentMaterial
	category:"-- PixGrinder --"
	toolTip:"Assign Current Material"
	buttonText:"Assign Current Material"
	icon:#("PixGrinder",19)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/AssignCurrentMaterial.ms"
	)
	
	
	macroScript FaceMode
	category:"-- PixGrinder --"
	toolTip:"FaceMode - PixGrinder"
	buttonText:"FaceMode"
	icon:#("EditMesh",4)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/FaceMode_v2.ms"
	)
	
	macroScript ShapeSelectOptimizer
	category:"-- PixGrinder --"
	toolTip:"ShapeSelectOptimizer - PixGrinder"
	buttonText:"ShapeSelectOptimizer"
	icon:#("bip_curve",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/ShapeSelectOptimizer_v1.ms"
	)
	
	macroScript LayersViewToggle
	category:"-- PixGrinder --"
	toolTip:"Layers View Toggle - PixGrinder"
	buttonText:"Layers View Toggle"
	icon:#("AnimLayerToolbar",11)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Layers_view_Toggle_v2.ms"
	)	
	
	macroScript LayersFreezeToggle
	category:"-- PixGrinder --"
	toolTip:"Layers Freeze Toggle - PixGrinder"
	buttonText:"Layers Freeze Toggle"
	icon:#("TrackViewTools",115)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Layers_freeze_Toggle_v2.ms"
	)
	
	macroScript CableRetopology
	category:"-- PixGrinder --"
	toolTip:"Cable Retopology - PixGrinder"
	buttonText:"CableRetopology"
	icon:#("Splines",11)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Cable_Retopology.ms"
	)
	
	macroScript LocksToggler
	category:"-- PixGrinder --"
	toolTip:"Toggles Transforms locks"
	buttonText:"Animation Locks Toggler"
	icon:#("SnapsControls",1)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/LocksToggler_V1.ms"
	)
	
	macroScript TrisToQuad
	category:"-- PixGrinder --"
	toolTip:"Triangle To Quads"
	buttonText:"TrisToQuad"
	icon:#("EditMesh",2)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/polyquad2.ms"
	)
	
	macroScript PivotCenter
	category:"-- PixGrinder --"
	toolTip:"PivotCenter"
	buttonText:"PivotCenter"
	icon:#("Maintoolbar",33)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Pivot_Center.ms"
	)
	
	macroScript PivotPerObject
	category:"-- PixGrinder --"
	toolTip:"PivotPerObject"
	buttonText:"PivotPerObject"
	icon:#("Maintoolbar",31)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Pivot_PerObject.ms"
	)
	
	macroScript PivotExternal
	category:"-- PixGrinder --"
	toolTip:"PivotExternal"
	buttonText:"PivotExternal"
	icon:#("Maintoolbar",35)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Pivot_External.ms"
	)
	
	macroScript WireColorChanger
	category:"-- PixGrinder --"
	toolTip:"Wire Color Changer"
	buttonText:"Wire Color Changer"
	icon:#("Material_Modifiers",3)
	silentErrors:false
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/WireColorChanger_v2.ms"
	)
	
	macroScript PivotAlignator
	category:"-- PixGrinder --"
	toolTip:"Pivot Alignator"
	buttonText:"PivotAlignator"
	icon:#("Helpers",1)
	silentErrors:false
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Pivot_Alignator_V3.ms"
	)
	
	macroScript MaterialRemove
	category:"-- PixGrinder --"
	toolTip:"Material Remove"
	buttonText:"Material Remove"
	icon:#("UVWUnwrapOption",2)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/MaterialRemove.ms"
	)
	
	macroScript SearchByName
	category:"-- PixGrinder --"
	toolTip:"SearchByName"
	buttonText:"Srch"
	icon:#("Maxscript",2)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/search_by_Name.ms"
	)
	
	macroScript LayerFromSelection
	category:"-- PixGrinder --"
	toolTip:"Layer Isolate Objects's layer"
	buttonText:"Layer Isolate Objects's layer"
	icon:#("AnimLayerToolbar",4)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/LayerShowFromSelec.ms"
	)
	
	macroScript SymY
	category:"-- PixGrinder --"
	toolTip:"Symmetry on Y"
	buttonText:"Symmetry on Y"
	icon:#("UVWUnwrapTools",42)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/Symmetry_Y.ms"
	)
	
	
	macroScript XRefMulti
	category:"-- PixGrinder --"
	toolTip:"Xref multiple max files on the fly !"
	buttonText:"XRefMulti"
	-- icon:#("UVWUnwrapTools",42)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/XrefScene_multi.ms"
	)
	
	macroScript BS_CollapseMultiMaterial
	category:"-- PixGrinder --"
	toolTip:"Collapse MultiSubObjects Material"
	buttonText:"Collapse MultiMat"
	icon:#("BlurScripts",51)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/Blur_CollapseSubObjectMaterial_v1.ms"
	)
	
	macroScript Reveal_MaxFile
	category:"-- PixGrinder --"
	toolTip:"Reveal Current Scene in Windows Explorer"
	buttonText:"Reveal Scene..."
	--icon:#("BlurScripts",51)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Reveal_Maxfile_In_Explorer.ms"
	)

	macroScript MaxScript_Help
	category:"-- PixGrinder --"
	toolTip:"MaxScript Help Offline"
	buttonText:"MaxScript Help Offline"
	icon:#("MaxScript",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/MaxScript_Offline_Help.ms"
	)
	

	macroScript AssetsFinder
	category:"-- PixGrinder --"
	toolTip:"AssetsFinder"
	buttonText:"Search..."
	icon:#("Maxscript",2)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Assets_Finder.ms"
	)
	
	
	macroScript CustAttribTransfer
	category:"-- PixGrinder --"
	toolTip:"Transfer Custom Attribs"
	buttonText:"AttribTransfer"
	--icon:#("Maxscript",2)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/CustAttribTransfer.ms"
	)

	macroScript BitmapFuckingUpdate
	category:"-- PixGrinder --"
	toolTip:"Bitmap Force Update !!"
	buttonText:"Bitmap Force Update"
	icon:#("PixGrinder",20)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/BitmapFuckingUpdate.ms"
	)

	macroScript SplineSelectMiddlePoints
	category:"-- PixGrinder --"
	toolTip:"Selects Middle points on a Spline"
	buttonText:"SplinePoints"
	icon:#("Splines",3)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/SplineSelectMiddlePoints.ms"
	)

	macroScript RefPlaneAutoRatio
	category:"-- PixGrinder --"
	toolTip:"Adjust Reference plane to its bitmap"
	buttonText:"Ref Plane AutoRatio"
	-- icon:#("Splines",3)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/Ref_Plane_AutoRatio.ms"
	)


	macroScript SelectSmallObjects
	category:"-- PixGrinder --"
	toolTip:"Select small objects"
	buttonText:"Select small objects"
	-- icon:#("Splines",3)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/Select_Small_Objects.ms"
	)


	macroScript CornerVertex
	category:"-- PixGrinder --"
	toolTip:"Corner"
	buttonText:"Corner"
	-- icon:#("Splines",3)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/Corner_Vertex.ms"
	)


	macroScript DoublonFinder
	category:"-- PixGrinder --"
	toolTip:"DoublonFinder"
	buttonText:"DoublonFinder"
	-- icon:#("Splines",3)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Doublon_Finder.ms"
	)

	macroScript UV1Detector
	category:"-- PixGrinder --"
	toolTip:"UV 1 Detector"
	buttonText:"UV 1 Detector"
	-- icon:#("Splines",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/UV1_Detector.ms"
	)
	
	macroScript FullNameDisplay
	category:"-- PixGrinder --"
	toolTip:"Full Name Display"
	buttonText:"Full Name Display"
	icon:#("Splines",5)
	silentErrors:false
	autoUndoEnabled:false
	(
		FileIn "$userScripts/PixGrinder/FullNameDisplay.ms"
	)


	macroScript Attach100
	category:"-- PixGrinder --"
	toolTip:"Attach100"
	buttonText:"Attach100"
	-- icon:#("Splines",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Attach100.ms"
	)

	macroScript listSelected
	category:"-- PixGrinder --"
	toolTip:"List Selected"
	buttonText:"List Selected"
	-- icon:#("Splines",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/listSelected.ms"
	)

	macroScript listHierarchy
	category:"-- PixGrinder --"
	toolTip:"List Hierarchy"
	buttonText:"List Hierarchy"
	-- icon:#("Splines",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/List_Hierarchy.ms"
	)

	macroScript listHierarchy
	category:"-- PixGrinder --"
	toolTip:"List To File"
	buttonText:"ListToFile"
	-- icon:#("Splines",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/ListSelectedToFile.ms"
	)

	macroScript listHierarchy
	category:"-- PixGrinder --"
	toolTip:"Select Small Objects"
	buttonText:"Select Small Objects"
	-- icon:#("Splines",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Small_Objects_Select.ms"
	)


)