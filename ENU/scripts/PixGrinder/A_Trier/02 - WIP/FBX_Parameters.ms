-- FBX Parameters --

-- OpenFbxSetting()

-- FbxExporterSetParam <String>arg <Value>val

-- FbxExporterGetParam "BakeResampleAnimation"
(
FbxExporterSetParam "Animation" on
FbxExporterSetParam "ASCII" off
FbxExporterSetParam "AxisConversionMethod" #Animation
FbxExporterSetParam "BakeAnimation" off
FbxExporterSetParam "Cameras" off
FbxExporterSetParam "EmbedTextures" off
FbxExporterSetParam "FileVersion" #FBX201900
FbxExporterSetParam "GenerateLog" off
FbxExporterSetParam "UseSceneName" off
FbxExporterSetParam "UpAxis" #y
FbxExporterSetParam "TangentSpaceExport" off
FbxExporterSetParam "Triangulate" off
FbxExporterSetParam "SplitAnimationIntoTakes" off
FbxExporterSetParam "SmoothMeshExport" off
FbxExporterSetParam "SmoothingGroups" on
FbxExporterSetParam "ShowWarnings" off
FbxExporterSetParam "Skin" on
FbxExporterSetParam "Shape" on
FbxExporterSetParam "SelectionSetExport" off
FbxExporterSetParam "ScaleFactor" 1.0
FbxExporterSetParam "Resampling" 30.0
FbxExporterSetParam "Removesinglekeys" off
FbxExporterSetParam "Preserveinstances" off
FbxExporterSetParam "PointCache" off
FbxExporterSetParam "NormalsPerPoly" off
FbxExporterSetParam "Lights" off
FbxExporterSetParam "GeomAsBone" off
FbxExporterSetParam "FilterKeyReducer" off
FbxExporterSetParam "ConvertUnit" #dm
FbxExporterSetParam "Convert2Tiff" off
FbxExporterSetParam "ColladaFrameRate" 30.0
FbxExporterSetParam "ColladaSingleMatrix" on
FbxExporterSetParam "ColladaTriangulate" on
FbxExporterSetParam "CAT2HIK" off
FbxExporterSetParam "BakeResampleAnimation" on
)


/*

"Animation"	True
True or False.

"ASCII"	
True or False.

"AxisConversionMethod"	
"None", "Animation", or "Fbx_Root".

"BakeAnimation"	
True or False.

"BakeFrameStart"	
Integer value.

"BakeFrameEnd"	
Integer value.

"BakeFrameStep"	
Integer value.

"BakeResampleAnimation"	
True or False.

"Cameras"	
True or False.

"CAT2HIK"	
True or False.

"ColladaTriangulate"	
True or False.

"ColladaSingleMatrix"	
True or False.

"ColladaFrameRate"	
Float (in frames).

"Convert2Tiff"	
True or False.

This converts non-TIFF-formatted texture images into TIFF format which makes them readable in other applications that do not support other image types.

"ConvertUnit"	
"mm" or "cm" or "dm" or "m" or "km" or "in" or "ft" or "mi" or "yd".

"EmbedTextures"	
True or False.

"FileVersion"	
"FBX201300" or "FBX201200" or FBX201100" or "FBX201000" or "FBX200900" or "FBX200611".

"FilterKeyReducer"	
True or False.

"GeomAsBone"	
True or False.

"GenerateLog"	
True or False.

"Lights"	
True or False.

"LoadExportPresetFile"	
The file name of the preset file.

"NormalsPerPoly"	
True or False.

"PointCache"	
True or False.

"PopSettings"	
This setting preserves the current state of the settings when you perform a One-Click operation.

FBXExporterSetParam "PopSettings" loads all I / OSettings.

"Preserveinstances"	
True or False.

"PushSettings"	
This setting preserves the current state of the settings when you perform a One-Click operation.

FBXExporterSetParam "PushSettings" saves all I / OSettings.

"Removesinglekeys"	
True or False.

"Resampling"	
Float.

"ResetExport"	
Loads the Autodesk Media & Entertainment export preset.

"ScaleFactor"	
Float.

"SelectionSet"	
Name of the selection set to use.

"SelectionSetExport"	
True or False.

"Shape"	
True or False.

"Skin"	
True or False.

"ShowWarnings"	
True or False.

"SmoothingGroups"	
True or False.

"SmoothMeshExport"	
True or False.

"SplitAnimationIntoTakes"	
"takename" which is the name of the take to use, followed by "frameStart", "frameEnd" to define the interval.

Use "-c|-clear" to clear the accumulator.

NOTE:Take001 exists regardless of how many splits are defined. Do not set a "frameEnd" < "frameStart". If "frameStart" and "frameEnd" do not define an interval with keys the split function will not validate it. If no animation keys are in the range, a take is created with no keys.
"TangentSpaceExport"	
True or False.

"Triangulate"	
True or False.

"UpAxis"	
"Y" or "Z".

"UseSceneName"	
True or False.


*/