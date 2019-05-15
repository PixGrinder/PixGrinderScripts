-- DirectX Converter --


	clearListener()


	fn myConverter mat = 
	(
		myDx = DirectX_9_Shader()
		myDx.useshaderfx = 2
		myDx.TEX_global_diffuse_cube = undefined
		myDx.TEX_global_specular_cube = undefined
		myDx.TEX_brdf_lut = undefined
		myDx.roughness = 0.8

		if classof mat == StandardMaterial then
		(
			if mat.maps[2] != undefined then 
			(
				myDx.use_color_map = 1.0
				myDx.TEX_color_map = mat.maps[2].bitmap
				myDx.base_color = (color 255.0 255.0 255.0)
			) else (
				myDx.use_color_map = 0.0
				myDx.base_color = mat.diffuse
			)

			if mat.opacity < 100 then
			(
				myDx.use_color_map = 1.0
				theWindow = bitmaptexture name:"myTex" filename:"D:/10 - Helicopters/Textures_Common/win.tga"
				myDx.TEX_color_map = theWindow.bitmap
				myDx.base_color = (color 255.0 255.0 255.0)
			)

			myDx.name = mat.name
			return myDx
		) else (
			return mat
		)
	)


	--$.material = (myConverter $.material)



	for obj in geometry where classof obj.material == StandardMaterial do 
	(
		--print obj.name
		obj.material = myConverter obj.material
	)


	for obj in geometry where classof obj.material == MultiMaterial do
	(
		print obj.name
		for i = 1 to obj.material.count where obj.material[i] != undefined do
		(
			obj.material[i] = myConverter obj.material[i]
		)

	)







/*

show meditmaterials[2]
theWindow = bitmaptexture name:"myTex" filename:"D:/10 - Helicopters/Textures_Common/win.tga"
x1.bitmap
theWindow = bitmap 64 64 filename:"D:/10 - Helicopters/Textures_Common/win.tga"
meditmaterials[2].TEX_color_map = theWindow
show meditmaterials[1]
meditmaterials[2].technique = 0
classof myDx
meditmaterials[2]
classof meditmaterials[2].TEX_color_map
meditmaterials[1].maps
meditmaterials[1].maps[2]
myDx.TEX_color_map = meditmaterials[1].maps[2]
show meditmaterials[1].maps[2]
classof meditmaterials[1].maps[2]
meditmaterials[1].maps[2].bitmap


-- Brouillon --

x1 = $
y1 = $.material
y1.

$.material[1].maps
classof $.material[1]



*/



/*
	-- DirectX Shader --

  .effectfile : filename
  .useshaderfx (Use_ShaderFX) : integer
  .shaderfxgraph (ShaderFX_Graph) : string
  .technique : integer
  .renderEnabled (Force_Software_Render) : boolean
  .renderMaterial : material
  .engineresource (Interactive_Engine_Resource) : string
  .presetmaterial (Interactive_Preset_Material) : integer
  .parentmaterial (Interactive_Parent_Material) : string
  .use_normal_map : float
  .uv_offset : point3
  .uv_scale : point3
  .use_color_map : float
  .base_color : fRGBA color
  .use_metallic_map : float
  .metallic : float
  .use_roughness_map : float
  .roughness : float
  .use_emissive_map : float
  .emissive : fRGBA color
  .emissive_intensity : float
  .use_ao_map : float
  .Light0Type : integer
  .TEX_global_diffuse_cube : bitmap
  .TEX_global_specular_cube : bitmap
  .TEX_brdf_lut : bitmap
  .TEX_normal_map : bitmap
  .TEX_color_map : bitmap
  .TEX_metallic_map : bitmap
  .TEX_roughness_map : bitmap
  .TEX_emissive_map : bitmap
  .TEX_ao_map : bitmap
  .Light0Pos : integer
  .Light0Dir : integer
  .effectFilename : filename
  .softwareBitmap : bitmap


  -- Standard -- 
  .shaderType (Shader_Type) : integer
  .wire : boolean
  .twoSided (Two_sided) : boolean
  .faceMap (Face_Map) : boolean
  .faceted : boolean
  .shaderByName (Shader_Name) : string
  .opacityType (Opacity_Type) : integer
  .opacity : percent
  .filterColor (Filter_Color) : RGB color
  .filterMap (Filter_Map) : texturemap
  .opacityFallOffType (Falloff_Type) : integer
  .opacityFallOff (Falloff) : percent
  .ior (Index_of_Refraction) : float
  .wireSize (Wire_Size) : float
  .wireUnits (Wire_Units) : integer
  .applyReflectionDimming (Apply_Reflection_Dimming) : boolean
  .dimLevel (Dim_Level) : float
  .reflectionLevel (Reflection_Level) : float
  .sampler (Pixel_Sampler) : integer
  .samplerQuality (Sampler_Quality) : float
  .samplerEnable (Sampler_Enable) : boolean
  .samplerAdaptThreshold (Adaptive_Threshold) : float
  .samplerAdaptOn (Adaptive_On) : boolean
  .subSampleTextureOn (SubSample_Textures) : boolean
  .samplerAdvancedOptions (Advanced_Options) : boolean
  .samplerByName (Sampler_Name) : string
  .UserParam0 (Optional_Param0) : float
  .UserParam1 (Optional_Param1) : float
  .samplerUseGlobal (Use_Global_Settings) : boolean
  .mapEnables (Map_Enables) : boolean array
  .maps : texturemap array
  .mapAmounts (Map_Amounts) : percent array
  .adTextureLock (Ambient_Diffuse_Texture_Lock) : boolean
  .ambientMap (alias for maps[0])
  .ambientMapAmount (alias for mapAmounts[0])
  .ambientMapEnable (alias for mapEnables[0])
  .bumpMap (alias for maps[8])
  .bumpMapAmount (alias for mapAmounts[8])
  .bumpMapEnable (alias for mapEnables[8])
  .diffuseMap (alias for maps[1])
  .diffuseMapAmount (alias for mapAmounts[1])
  .diffuseMapEnable (alias for mapEnables[1])
  .displacementMap (alias for maps[11])
  .displacementMapAmount (alias for mapAmounts[11])
  .displacementMapEnable (alias for mapEnables[11])
  .filterMap (alias for maps[7])
  .filterMapAmount (alias for mapAmounts[7])
  .filterMapEnable (alias for mapEnables[7])
  .glossinessMap (alias for maps[4])
  .glossinessMapAmount (alias for mapAmounts[4])
  .glossinessMapEnable (alias for mapEnables[4])
  .opacityMap (alias for maps[6])
  .opacityMapAmount (alias for mapAmounts[6])
  .opacityMapEnable (alias for mapEnables[6])
  .reflectionMap (alias for maps[9])
  .reflectionMapAmount (alias for mapAmounts[9])
  .reflectionMapEnable (alias for mapEnables[9])
  .refractionMap (alias for maps[10])
  .refractionMapAmount (alias for mapAmounts[10])
  .refractionMapEnable (alias for mapEnables[10])
  .selfIllumMap (alias for maps[5])
  .selfIllumMapAmount (alias for mapAmounts[5])
  .selfIllumMapEnable (alias for mapEnables[5])
  .specularLevelMap (alias for maps[3])
  .specularLevelMapAmount (alias for mapAmounts[3])
  .specularLevelMapEnable (alias for mapEnables[3])
  .specularMap (alias for maps[2])
  .specularMapAmount (alias for mapAmounts[2])
  .specularMapEnable (alias for mapEnables[2])
  .noExposureControl : boolean
  .exposureControlInvertSelfIllum : boolean
  .exposureControlInvertReflection : boolean
  .exposureControlInvertRefraction : boolean
  .ambient (Ambient_Color) : RGB color
  .diffuse (Diffuse_Color) : RGB color
  .specular (Specular_Color) : RGB color
  .adTextureLock (Ambient_Diffuse_Texture_Lock) : boolean
  .adLock (Ambient_Diffuse_Lock) : boolean
  .dsLock (Diffuse_Specular_Lock) : boolean
  .useSelfIllumColor (Use_Self_Illum_Color) : boolean
  .selfIllumAmount (Self_Illumination) : percent
  .selfIllumColor (Self_Illum_Color) : RGB color
  .specularLevel (Specular_Level) : percent
  .glossiness : percent
  .soften : float


*/