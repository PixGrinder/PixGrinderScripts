-------------------------------------------------------------------------------
-- PixGrinder.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( pixgrinder@gmail.com )
-- 31/05/2016
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
(
	

	macroScript HideByClick
	category:"-- PixGrinder --"
	toolTip:"Hide by Click"
	buttonText:"Hide by Click"
	-- icon:#("FileLinkActionItems",9)
	silentErrors:false
	autoUndoEnabled:false
	(
		FileIn "$userScripts/PixGrinder/Hide_by_click.ms"
	)

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


	macroScript BboxGeoMaker
	category:"-- PixGrinder --"
	toolTip:"Bbox Geo Maker"
	buttonText:"Bbox Geo Maker"
	--icon:#("FileLinkActionItems",9)
	silentErrors:false
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/bbox_GeoMaker.ms"
	)

	macroScript BboxDummyMaker
	category:"-- PixGrinder --"
	toolTip:"Bbox Dummy Maker"
	buttonText:"Bbox Dummy Maker"
	--icon:#("FileLinkActionItems",9)
	silentErrors:false
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/Bbox_DummyMaker.ms"
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

	macroScript MaterialTransfer
	category:"-- PixGrinder --"
	toolTip:"Material Transfert"
	buttonText:"Material Transfert"
	--icon:#("FileLinkActionItems",9)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/MaterialTransfert.ms"
	)


	macroScript Collapse_Selected
	category:"-- PixGrinder --"
	toolTip:"Collapse Hierarchy on Selection"
	buttonText:"Collapse Selected"
	icon:#("PixGrinder",1)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/CollapseSelected.ms"
	)
	
	macroScript ResetXFormPixGrinder
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
		FileIn "$userScripts/PixGrinder/Select_Prev.ms"
	)
	
	macroScript Select_Next_Object
	category:"-- PixGrinder --"
	toolTip:"Select Next Object"
	buttonText:"Select Next Object"
	icon:#("PixGrinder",2)
	silentErrors:false
	autoUndoEnabled:false
	(
		FileIn "$userScripts/PixGrinder/Select_Next.ms"
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
		Include "$userScripts/PixGrinder/FaceMode.ms"
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
	
	macroScript PivotCenterPixGrinder
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
		Include "$userScripts/PixGrinder/Pivot_Alignator.ms"
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

	macroScript Reveal_BakFolder
	category:"-- PixGrinder --"
	toolTip:"Reveal Current Scene Backup Folder "
	buttonText:"Reveal Bak Folder..."
	--icon:#("BlurScripts",51)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Reveal_BackupFolder_In_Explorer.ms"
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
	buttonText:"Assets Finder"
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
	toolTip:"Full Name Display - ABC"
	buttonText:"Full Name Display - ABC"
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
	icon:#("Maxscript",1)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/listSelected.ms"
	)


	macroScript listSelected_comma
	category:"-- PixGrinder --"
	toolTip:"List Selected Comma"
	buttonText:"List Selected Comma"
	icon:#("Maxscript",1)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/ListSelected_comma.ms"
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

	macroScript listToFile
	category:"-- PixGrinder --"
	toolTip:"List To File"
	buttonText:"ListToFile"
	-- icon:#("Splines",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/ListSelectedToFile.ms"
	)

	macroScript selectSmallObjects
	category:"-- PixGrinder --"
	toolTip:"Select Small Objects"
	buttonText:"Select Small Objects"
	-- icon:#("Splines",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Small_Objects_Select.ms"
	)

	macroScript FindMatFromSlot
	category:"-- PixGrinder --"
	toolTip:"Find Material From Slot"
	buttonText:"FindMatFromSlot"
	-- icon:#("Splines",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Material_SlotFinder.ms"
	)

	macroScript SelectByList
	category:"-- PixGrinder --"
	toolTip:"Select by List"
	buttonText:"SelectByList"
	-- icon:#("Splines",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Select_by_List.ms"
	)

	macroScript NormalFlip
	category:"-- PixGrinder --"
	toolTip:"NormalFlip"
	buttonText:"NormalFlip"
	-- icon:#("Splines",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Normals_QuickFlip.ms"
	)

	macroScript CableSplinePreset
	category:"-- PixGrinder --"
	toolTip:"CableSplinePreset"
	buttonText:"CableSplinePreset"
	icon:#("Splines",10)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Cable_SplinePreset.ms"
	)

	macroScript Select_Previous_Object_Zoom
	category:"-- PixGrinder --"
	toolTip:"Select Previous Object Zoom"
	buttonText:"Select Previous Object Zoom"
	icon:#("PixGrinder",3)
	silentErrors:true
	autoUndoEnabled:false
	(
		FileIn "$userScripts/PixGrinder/Select_Prev_Zoomed.ms"
	)
	
	macroScript Select_Next_Object_Zoom
	category:"-- PixGrinder --"
	toolTip:"Select Next Object Zoom"
	buttonText:"Select Next Object Zoom"
	icon:#("PixGrinder",2)
	silentErrors:false
	autoUndoEnabled:false
	(
		FileIn "$userScripts/PixGrinder/Select_Next_Zoomed.ms"
	)

	macroScript CrossSurface
	category:"-- PixGrinder --"
	toolTip:"CrossSurface"
	buttonText:"CrossSurface"
	icon:#("Surface_tools",2)
	silentErrors:false
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/CrossSurface.ms"
	)


	macroScript UvBox
	category:"-- PixGrinder --"
	toolTip:"UV Box"
	buttonText:"UV Box"
	icon:#("PixGrinder",21)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/UV_Box.ms"
	)


	macroScript ObjectQuickReset
	category:"-- PixGrinder --"
	toolTip:"Object Quick Reset"
	buttonText:"QuickReset"
	icon:#("PixGrinder",4)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/Object_QuickReset.ms"
	)

	macroScript CopyWireColor
	category:"-- PixGrinder --"
	toolTip:"CopyWireColor"
	buttonText:"QCopyWireColor"
	icon:#("Material_Modifiers",3)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/CopyWireColor.ms"
	)

	macroScript Welder_Advanced
	category:"-- PixGrinder --"
	toolTip:"WelderAdvanced"
	buttonText:"Welder"
	icon:#("UVWUnwrapTools",4)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/Welder_Advanced.ms"
	)

	macroScript AttachSelected
	category:"-- PixGrinder --"
	toolTip:"AttachSelected"
	buttonText:"AttachSelected"
	icon:#("UVWUnwrapTools",4)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/AttachSelected.ms"
	)

	macroScript ViewFaceAlign
	category:"-- PixGrinder --"
	toolTip:"ViewFaceAlign"
	buttonText:"ViewFaceAlign"
	icon:#("Maintoolbar",76)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/ViewFaceAlign.ms"
	)

	macroScript PerspAdvanced
	category:"-- PixGrinder --"
	toolTip:"PerspAdvanced"
	buttonText:"PerspAdvanced"
	--icon:#("Maintoolbar",76)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/PerspectiveViewAdvanced.ms"
	)


	macroScript PivotFromSubObject
	category:"-- PixGrinder --"
	toolTip:"PivotFromSubObject"
	buttonText:"PivotFromSubObject"
	--icon:#("Maintoolbar",76)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/PivotFromSubObject.ms"
	)


	macroScript ScaleSwitch
	category:"-- PixGrinder --"
	toolTip:"ScaleSwitch"
	buttonText:"ScaleSwitch"
	icon:#("Maintoolbar",26)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/ScaleSwitch.ms"
	)

	macroScript Coord_Parent
	category:"-- PixGrinder --"
	toolTip:"pix_Parent"
	buttonText:"pix_Parent"
	-- icon:#("Maintoolbar",26)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/CoordSys_Parent.ms"
	)



	macroScript Coord_View
	category:"-- PixGrinder --"
	toolTip:"pix_View"
	buttonText:"pix_View"
	-- icon:#("Maintoolbar",26)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/CoordSys_View.ms"
	)


	macroScript Coord_Screen
	category:"-- PixGrinder --"
	toolTip:"pix_Screen"
	buttonText:"pix_Screen"
	-- icon:#("Maintoolbar",26)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/CoordSys_Screen.ms"
	)


	macroScript Coord_Local
	category:"-- PixGrinder --"
	toolTip:"pix_Local"
	buttonText:"pix_Local"
	-- icon:#("Maintoolbar",26)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/CoordSys_Local.ms"
	)


	macroScript Coord_World
	category:"-- PixGrinder --"
	toolTip:"pix_World"
	buttonText:"pix_World"
	-- icon:#("Maintoolbar",26)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/CoordSys_World.ms"
	)

	macroScript ProBooleanQuick
	category:"-- PixGrinder --"
	toolTip:"ProBoolean_Quick"
	buttonText:"ProBoolean_Quick"
	icon:#("PowerBoolean",7)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/ProBoolean_Quick.ms"
	)


	macroScript CopyWithName ------- 
	category:"-- PixGrinder --"
	toolTip:"CopyWithName" ------- 
	buttonText:"CopyWithName" ------- 
	icon:#("PowerBoolean",7)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/CopyWithName.ms" ------- 
	)


	macroScript SelectByAngle ------- 
	category:"-- PixGrinder --"
	toolTip:"SelectByAngle" ------- 
	buttonText:"SelectByAngle" ------- 
	--icon:#("PowerBoolean",7)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/SelectByAngle.ms" ------- 
	)

	macroScript Section_Perpendiculaire ------- 
	category:"-- PixGrinder --"
	toolTip:"Section_Perpendiculaire" ------- 
	buttonText:"Section_Perpendiculaire" ------- 
	icon:#("Splines",7)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/Section_Perpendiculaire.ms" ------- 
	)

	macroScript DetachByElt ------- 
	category:"-- PixGrinder --"
	toolTip:"DetachByElt" ------- 
	buttonText:"DetachByElt" ------- 
	icon:#("Polytools",6)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/DetachByElt.ms" ------- 
	)


	macroScript ReplaceObjects ------- 
	category:"-- PixGrinder --"
	toolTip:"ReplaceObjects" ------- 
	buttonText:"ReplaceObjects" ------- 
	icon:#("Systems",3)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/ReplaceObjects.ms" ------- 
	)

	macroScript PivotFromNormal ------- 
	category:"-- PixGrinder --"
	toolTip:"PivotFromNormal" ------- 
	buttonText:"PivotFromNormal" ------- 
	--icon:#("Maintoolbar",6)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/PivotFromNormal.ms" ------- 
	)

	macroScript CylinderFromSelec ------- 
	category:"-- PixGrinder --"
	toolTip:"CylinderFromSelec" ------- 
	buttonText:"CylinderFromSelec" ------- 
	icon:#("Standard",8)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/CylinderFromSelec.ms" ------- 
	)

	macroScript DetachQuick ------- 
	category:"-- PixGrinder --"
	toolTip:"DetachQuick" ------- 
	buttonText:"DetachQuick" ------- 
	--icon:#("Standard",8)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/DetachQuick.ms" ------- 
	)

	macroScript DetachClone ------- 
	category:"-- PixGrinder --"
	toolTip:"DetachClone" ------- 
	buttonText:"DetachClone" ------- 
	--icon:#("Standard",8)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/DetachClone.ms" ------- 
	)

	macroScript CreateShapeQuick ------- 
	category:"-- PixGrinder --"
	toolTip:"CreateShapeQuick" ------- 
	buttonText:"CreateShapeQuick" ------- 
	icon:#("Splines",1)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/CreateShapeQuick.ms" ------- 
	)


	macroScript WireTransfer ------- 
	category:"-- PixGrinder --"
	toolTip:"WireTransfer" ------- 
	buttonText:"WireTransfer" ------- 
	--icon:#("Splines",1)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/WireTransfer.ms" ------- 
	)

	macroScript SymetryMod ------- 
	category:"-- PixGrinder --"
	toolTip:"SymetryMod" ------- 
	buttonText:"SymetryMod" ------- 
	icon:#("UVWUnwrapModes",15)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/SymetryMod.ms" ------- 
	)


	macroScript Hide_Selec ------- 
	category:"-- PixGrinder --"
	toolTip:"Hide_Selec" ------- 
	buttonText:"Hide_Selec" ------- 
	--icon:#("UVWUnwrapModes",15)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/Hide_Selec.ms" ------- 
	)

	macroScript ShapeFromPoly ------- 
	category:"-- PixGrinder --"
	toolTip:"ShapeFromPoly" ------- 
	buttonText:"ShapeFromPoly" ------- 
	--icon:#("UVWUnwrapModes",15)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder/ShapeFromPoly.ms" ------- 
	)

	macroScript MXP
	category:"-- PixGrinder --"
	toolTip:"MXP Folder"
	buttonText:"MXP..."
	--icon:#("BlurScripts",51)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/MXP.ms"
	)


	macroScript Bitmap_Missing_Highlight
	category:"-- PixGrinder --"
	toolTip:"Bitmap Missing Highlight"
	buttonText:"Bitmap Missing Highlight"
	--icon:#("BlurScripts",51)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Bitmap_Missing_Highlight.ms"
	)

	macroScript SelectAnimated
	category:"-- PixGrinder --"
	toolTip:"Select Animated"
	buttonText:"Select Animated"
	--icon:#("BlurScripts",51)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Select_Animated.ms"
	)

	macroScript Linear_Controller_Assign
	category:"-- PixGrinder --"
	toolTip:"Linear Controllers Assign"
	buttonText:"Linear Controllers Assign"
	--icon:#("BlurScripts",51)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Linear_Controller_Assign.ms"
	)


	macroScript SlateRename
	category:"-- PixGrinder --"
	toolTip:"SlateRename"
	buttonText:"SlateRename"
	--icon:#("BlurScripts",51)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/SlateRename.ms"
	)


	macroScript SlateRename
	category:"-- PixGrinder --"
	toolTip:"Export Custom..."
	buttonText:"Export Custom..."
	--icon:#("BlurScripts",51)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Export_Custom.ms"
	)


	macroScript UniversalWeld
	category:"-- PixGrinder --"
	toolTip:"Weld"
	buttonText:"Weld"
	--icon:#("BlurScripts",51)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/UniversalWeld.ms"
	)


	macroScript SoftSelec
	category:"-- PixGrinder --"
	toolTip:"SoftSelec"
	buttonText:"SoftSelec"
	icon:#("UVWUnwrapSoftSelection",1)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/SoftSelectToggle.ms"
	)

	macroScript CopyObj
	category:"-- PixGrinder --"
	toolTip:"CopyObj"
	buttonText:"CopyObj"
	--icon:#("UVWUnwrapSoftSelection",1)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/CopyObject.ms"
	)


	macroScript PasteObj
	category:"-- PixGrinder --"
	toolTip:"PasteObj"
	buttonText:"PasteObj"
	--icon:#("UVWUnwrapSoftSelection",1)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/PasteObject.ms"
	)
	macroScript SmoothQuick
	category:"-- PixGrinder --"
	toolTip:"SmoothQuick"
	buttonText:"SmoothQuick"
	icon:#("Standard_Modifiers",23)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/Smooth_Quick.ms"
	)


	macroScript Usual_Materials
	category:"-- PixGrinder --"
	toolTip:"Usual_Materials"
	buttonText:"Usual_Materials"
	icon:#("Material_Modifiers",3)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/Usual_Materials.ms"
	)

	macroScript HideTextured
	category:"-- PixGrinder --"
	toolTip:"HideTextured"
	buttonText:"HideTextured"
	icon:#("UVWUnwrapOption",2)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/A_Trier/02 - WIP/Hide_Textured.ms"
	)

	macroScript PBR_MapSeeker
	category:"-- PixGrinder --"
	toolTip:"PBR_MapSeeker"
	buttonText:"PBR_MapSeeker"
	-- icon:#("UVWUnwrapOption",2)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/PBR_MapSeeker.ms"
	)

	macroScript UnwrapCustom
	category:"-- PixGrinder --"
	toolTip:"UnwrapCustom"
	buttonText:"UnwrapCustom"
	icon:#("Material_Modifiers",6)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/UnwrapCustom.ms"
	)

	macroScript History_Search
	category:"-- PixGrinder --"
	toolTip:"History_Search"
	buttonText:"History_Search"
	--icon:#("Material_Modifiers",6)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/Objects_History_Search.ms"
	)


)