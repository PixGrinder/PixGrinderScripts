macroScript TurnViewportMapsOn category:"- Gueshni -" Icon:#("g9_turnviewport", 1) toolTip:"Turn Viewport Maps On-Off"
	
(
	(
	rollout turnMap_roll "Turn viewport maps on/off" (

		group "Settings" (
			checkbox chk_ambient "Ambient Map" across:3 align:#left checked:True
			checkbox chk_diffuse "Diffuse Map" align:#center
			checkbox chk_selfillu "Self Illumin" align:#right
			checkbox chk_opacity "Opacity" across:3 align:#left
			checkbox chk_bump "Bump Map" pos:[109, 44]
			checkbox chk_reflection "Reflection" pos:[212, 44]
		)
		
		group "Actions" (
			checkbox chk_selectedObj "Selected Objects Only"
			button btn_on "Turn them On" across:2 width:135 pos:[13,120]
			button btn_off "Turn them Off" width:135 pos:[152,120]
			progressbar prg pos:[13,155]
		)
		
		global Matclasses = #(Mix, Falloff)
		
		fn calcPercent val total = (
			ret = 100.0*val/total
			prg.value = ret
		)
		
		fn collectingObj _state =
		(
			_coll = undefined
			if _state then(
				if (classof $) == ObjectSet then(
					_coll = $ as array
				)else if $ != undefined then(
					_coll = #()
					append _coll $
				)else(
					_coll = #()
				)
			)else(
				_coll = objects as array
			)
			_coll
		)
		
		fn turnOnBumpMaps state = (
			coll = collectingObj chk_selectedObj.state
			tot = coll.count
			inc = 0
			for o in coll do(
				inc +=1
				if o.material != undefiend then (
					if (classof o.material) == standardMaterial then(
						try(
							if o.material.bumpMap != undefined then(
								if finditem Matclasses (classof (o.material.bumpMap))>0 then(
									if o.material.bumpMap.map1 != undefined then(
										showTextureMap o.material o.material.bumpMap.map1 state
									)else if o.material.bumpMap.map2 != undefined then(
										showTextureMap o.material o.material.bumpMap.map2 state
									)
								)else(
									showTextureMap o.material o.material.bumpMap state
								)
							)
						)catch(
							print ("Could not update: " + o.name)
						)
					)else if (classof o.material) == VrayMtl then(
						try(
							if o.material.texmap_bump != undefined then(
								if finditem Matclasses (classof (o.material.texmap_bump))>0 then(
									if o.material.texmap_bump.map1 != undefined then(
										showTextureMap o.material o.material.texmap_bump.map1 state
									)else if o.material.texmap_bump.map2 != undefined then(
										showTextureMap o.material o.material.texmap_bump.map2 state
									)
								)else(
									showTextureMap o.material o.material.texmap_bump state
								)
							)
						)catch(
							print ("Could not update: " + o.name)
						)
					)else if (classof o.material) == Arch___Design__mi then(
						try(
							if o.material.bump_map  != undefined then(
								if finditem Matclasses (classof (o.material.bump_map))>0 then(
									if o.material.bump_map.map1 != undefined then(
										showTextureMap o.material o.material.bump_map.map1 state
									)else if o.material.bump_map.map2 != undefined then(
										showTextureMap o.material o.material.bump_map.map2 state
									)
								)else(
									showTextureMap o.material o.material.bump_map state
								)
							)
						)catch(
							print ("Could not update: " + o.name)
						)
					)else if (classof o.material == multiMaterial) then(
						for m in o.material do(
							if (classof m) == standardMaterial then(
								try(
									if m.bumpMap != undefined then(
										if finditem Matclasses (classof (m.bumpmap))>0 then(
											if m.bumpMap.map1 != undefined then(
												showTextureMap m m.bumpMap.map1 state
											)else if m.bumpMap.map2 != undefined then(
												showTextureMap m m.bumpMap.map2 state
											)
										)else(
											showTextureMap m m.bumpMap state
										)
									)
								)catch(
									print ("Could not update: " + o.name)
								)
							)else if (classof m) == Arch___Design__mi then(
								try(
									if m.bump_map != undefined then(
										if finditem Matclasses (classof (m.bump_map))>0 then(
											if m.bump_map.map1 != undefined then(
												showTextureMap m m.bump_map.map1 state
											)else if m.bump_map.map2 != undefined then(
												showTextureMap m m.bump_map.map2 state
											)
										)else(
											showTextureMap m m.bump_map state
										)
									)
								)catch(
									print ("Could not update: " + o.name)
								)
							)else if (classof m) == VrayMtl then(
								try(
									if m.texmap_bump != undefined then(
										if finditem Matclasses (classof (m.texmap_bump))>0 then(
											if m.texmap_bump.map1 != undefined then(
												showTextureMap m m.texmap_bump.map1 state
											)else if m.texmap_bump.map2 != undefined then(
												showTextureMap m m.texmap_bump.map2 state
											)
										)else(
											showTextureMap m m.texmap_bump state
										)
									)
								)catch(
									print ("Could not update: " + o.name)
								)
							)
						)
					)--end if 
				)
				calcPercent inc tot
			)
		)
		
		fn turnOnReflectionMaps state = (
			coll = collectingObj chk_selectedObj.state
			tot = coll.count
			inc = 0
			for o in coll do(
				inc +=1
				if o.material != undefiend then (
					if (classof o.material) == standardMaterial then(
						try(
							if o.material.reflectionMap != undefined then(
								if finditem Matclasses (classof (o.material.reflectionMap))>0 then(
									if o.material.reflectionMap.map1 != undefined then(
										showTextureMap o.material o.material.reflectionMap.map1 state
									)else if o.material.reflectionMap.map2 != undefined then(
										showTextureMap o.material o.material.reflectionMap.map2 state
									)
								)else(
									showTextureMap o.material o.material.reflectionMap state
								)
							)
						)catch(
							print ("Could not update: " + o.name)
						)
					)else if (classof o.material) == VrayMtl then(
						try(
							if o.material.texmap_reflection != undefined then(
								if finditem Matclasses (classof (o.material.texmap_reflection))>0 then(
									if o.material.texmap_reflection.map1 != undefined then(
										showTextureMap o.material o.material.texmap_reflection.map1 state
									)else if o.material.texmap_reflection.map2 != undefined then(
										showTextureMap o.material o.material.texmap_reflection.map2 state
									)
								)else(
									showTextureMap o.material o.material.texmap_reflection state
								)
							)
						)catch(
							print ("Could not update: " + o.name)
						)
					)else if (classof o.material) == Arch___Design__mi then(
						try(
							if o.material.refl_color_map != undefined then(
								if finditem Matclasses (classof (material.refl_color_map))>0 then(
									if o.material.refl_color_map.map1 != undefined then(
										showTextureMap o.material o.material.refl_color_map.map1 state
									)else if o.material.refl_color_map.map2 != undefined then(
										showTextureMap o.material o.material.refl_color_map.map2 state
									)
								)else(
									showTextureMap o.material o.material.refl_color_map state
								)
							)
						)catch(
							print ("Could not update: " + o.name)
						)
					)else if (classof o.material) == multiMaterial then(
						for m in o.material do(
							if (classof m) == standardMaterial then(
								try(
									if m.reflectionMap != undefined then(
										if finditem Matclasses (classof (m.reflectionMap))>0 then(
											if m.reflectionMap.map1 != undefined then(
												showTextureMap m m.reflectionMap.map1 state
											)else if m.reflectionMap.map2 != undefined then(
												showTextureMap m m.reflectionMap.map2 state
											)
										)else(
											showTextureMap m m.reflectionMap state
										)
									)
								)catch(
									print (getCurrentException())
									print ("Could not update: " + o.name)
								)
							)else if (classof m) == Arch___Design__mi then(
								try(
									if m.refl_color_map != undefined then(
										if finditem Matclasses (classof (m.refl_color_map))>0 then(
											if m.refl_color_map.map1 != undefined then(
												showTextureMap m m.refl_color_map.map1 state
											)else if m.refl_color_map.map2 != undefined then(
												showTextureMap ml m.refl_color_map.map2 state
											)
										)else(
											showTextureMap m m.refl_color_map state
										)
									)
								)catch(
									print ("Could not update: " + o.name)
								)
							)else if (classof m) == VrayMtl then(
								try(
									if m.texmap_reflection != undefined then(
										if finditem Matclasses (classof (m.texmap_reflection))>0 then(
											if m.texmap_reflection.map1 != undefined then(
												showTextureMap m m.texmap_reflection.map1 state
											)else if m.texmap_reflection.map2 != undefined then(
												showTextureMap m m.texmap_reflection.map2 state
											)
										)else(
											showTextureMap m m.texmap_reflection state
										)
									)
								)catch(
									print ("Could not update: " + o.name)
								)
							)
						)
					)
				calcPercent inc tot
				)
			)
		)
		
		fn turnOnDiffuseMaps state = (
			--controle de la selection (multiple, unique, vie)
			coll = collectingObj chk_selectedObj.state
			tot = coll.count
			inc = 0
			for o in coll do(
				inc +=1
				if o.material != undefined then (
					if (classof o.material) == standardMaterial then(
						try(
							if o.material.diffuseMap != undefined then(
								if finditem Matclasses (classof (o.material.diffuseMap))>0 then(
									if o.material.diffuseMap.map1 != undefined then(
										showTextureMap o.material o.material.diffuseMap.map1 state
									)else if o.material.diffuseMap.map2 != undefined then(
										showTextureMap o.material o.material.diffuseMap.map2 state
									)
								)else(
									showTextureMap o.material o.material.diffuseMap state
								)
							)
						)catch(
							print ("Could not update: " + o.name)
						)
					)else if (classof o.material) == VrayMtl then(
						try(
							if o.material.texmap_diffuse != undefined then(
								if finditem Matclasses (classof (o.material.texmap_diffuse))>0 then(
									if o.material.texmap_diffuse.map1 != undefined then(
										showTextureMap o.material o.material.texmap_diffuse.map1 state
									)else if o.material.texmap_diffuse.map2 != undefined then(
										showTextureMap o.material o.material.texmap_diffuse.map2 state
									)
								)else(
									showTextureMap o.material o.material.texmap_diffuse state
								)
							)
						)catch(
							print ("Could not update: " + o.name)
						)
					)else if (classof o.material) == Arch___Design__mi then(
						try(
							if o.material.diff_color_map != undefined then(
								if finditem Matclasses (classof (o.material.diff_color_map))>0 then(
									if o.material.diff_color_map.map1 != undefined then(
										showTextureMap o.material o.material.diff_color_map.map1 state
									)else if o.material.diff_color_map.map2 != undefined then(
										showTextureMap o.material o.material.diff_color_map.map2 state
									)
								)else(
									showTextureMap o.material o.material.diff_color_map state
								)
							)
						)catch(
							print ("Could not update: " + o.name)
						)
					)
					else if (classof o.material) == MultiMaterial then(
						for m in o.material do(
							if (classof m) == standardMaterial then(
								try(
									if m.diffuseMap != undefined then(
										if finditem Matclasses (classof (m.diffuseMap))>0 then(
											if m.diffuseMap.map1 != undefined then(
												showTextureMap m m.diffuseMap.map1 state
											)else if m.diffuseMap.map2 != undefined then(
												showTextureMap m m.diffuseMap.map2 state
											)
										)else(
											showTextureMap m m.diffuseMap state
										)
									)
								)catch(
									print (getCurrentException())
									print ("Could not update: " + o.name)
								)
							)else if (classof m) == Arch___Design__mi then(
								try(
									if m.diff_color_map != undefined then(
										if finditem Matclasses (classof (m.diff_color_map))>0 then(
											if m.diff_color_map.map1 != undefined then(
												showTextureMap m m.diff_color_map.map1 state
											)else if m.diff_color_map.map2 != undefined then(
												showTextureMap ml m.diff_color_map.map2 state
											)
										)else(
											showTextureMap m m.diff_color_map state
										)
									)
								)catch(
									print ("Could not update: " + o.name)
								)
							)else if (classof m) == VrayMtl then(
								try(
									if m.texmap_diffuse != undefined then(
										if finditem Matclasses (classof (m.texmap_diffuse))>0 then(
											if m.texmap_diffuse.map1 != undefined then(
												showTextureMap m m.texmap_diffuse.map1 state
											)else if m.texmap_diffuse.map2 != undefined then(
												showTextureMap m m.texmap_diffuse.map2 state
											)
										)else(
											showTextureMap m m.texmap_diffuse state
										)
									)
								)catch(
									print (getCurrentException())
									print ("Could not update: " + o.name)
								)
							)
						)
						
						
					)
				)
				calcPercent inc tot
			)
		)
		
		fn turnOnAmbientMaps state = (
			--controle de la selection (multiple, unique, vie)
			coll = collectingObj chk_selectedObj.state
			tot = coll.count
			inc = 0
			for o in coll do(
				inc +=1
				if o.material != undefined then (
					if (classof o.material) == standardMaterial then(
						try(
							if o.material.ambientMap != undefined then(
								if finditem Matclasses (classof (o.material.ambientMap))>0 then(
									if o.material.ambientMap.map1 != undefined then(
										showTextureMap o.material o.material.ambientMap.map1 state
									)else if o.material.diffuseMap.map2 != undefined then(
										showTextureMap o.material o.material.ambientMap.map2 state
									)
								)else(
									showTextureMap o.material o.material.ambientMap state
								)
							)
						)catch(
							print ("Could not update: " + o.name)
						)
					)else if (classof o.material) == MultiMaterial then(
						for m in o.material do(
							if (classof m) == standardMaterial then(
								try(
									if m.ambientMap != undefined then(
										if finditem Matclasses (classof (m.ambientMap))>0 then(
											if m.ambientMap.map1 != undefined then(
												showTextureMap m m.ambientMap.map1 state
											)else if m.ambientMap.map2 != undefined then(
												showTextureMap m m.ambientMap.map2 state
											)
										)else(
											showTextureMap m m.ambientMap state
										)
									)
								)catch(
									print (getCurrentException())
									print ("Could not update: " + o.name)
								)
							)
						)
					)
				)
				calcPercent inc tot
			)
		)
		
		fn turnOnSelfIlluMaps state = (
			--controle de la selection (multiple, unique, vie)
			coll = collectingObj chk_selectedObj.state
			tot = coll.count
			inc = 0
			for o in coll do(
				inc +=1
				if o.material != undefined then (
					if (classof o.material) == standardMaterial then(
						try(
							if o.material.selfillumMap != undefined then(
								if finditem Matclasses (classof (o.material.selfillumMap))>0 then(
									if o.material.selfillumMap.map1 != undefined then(
										showTextureMap o.material o.material.selfillumMap.map1 state
									)else if o.material.selfillumMap.map2 != undefined then(
										showTextureMap o.material o.material.selfillumMap.map2 state
									)
								)else(
									showTextureMap o.material o.material.selfillumMap state
								)
							)
						)catch(
							print ("Could not update: " + o.name)
						)
					)else if (classof o.material) == MultiMaterial then(
						for m in o.material do(
							if (classof m) == standardMaterial then(
								try(
									if m.selfillumMap != undefined then(
										-- si material de type contenu dans matClasses (mix, falloff, etc)
										if finditem Matclasses (classof (m.selfillumMap))>0 then(
											if m.selfillumMap.map1 != undefined then(
												showTextureMap m m.selfillumMap.map1 state
											)else if m.selfillumMap.map2 != undefined then(
												showTextureMap m m.selfillumMap.map2 state
											)
										)else(
											showTextureMap m m.selfillumMap state
										)
									)
								)catch(
									print (getCurrentException())
									print ("Could not update: " + o.name)
								)
							)
						)
					)
				)
				calcPercent inc tot
			)
		)
		
		fn turnOnOpacityMaps state = (
			--controle de la selection (multiple, unique, vie)
			coll = collectingObj chk_selectedObj.state
			tot = coll.count
			inc = 0
			for o in coll do(
				inc +=1
				if o.material != undefined then (
					if (classof o.material) == standardMaterial then(
						try(
							if o.material.OpacityMap != undefined then(
								if finditem Matclasses (classof (o.material.OpacityMap))>0 then(
									if o.material.OpacityMap.map1 != undefined then(
										showTextureMap o.material o.material.OpacityMap.map1 state
									)else if o.material.OpacityMap.map2 != undefined then(
										showTextureMap o.material o.material.OpacityMap.map2 state
									)
								)else(
									showTextureMap o.material o.material.OpacityMap state
								)
							)
						)catch(
							print ("Could not update: " + o.name)
						)
					)else if (classof o.material) == VrayMtl then(
						try(
							if o.material.texmap_opacity != undefined then(
								if finditem Matclasses (classof (o.material.texmap_opacity))>0 then(
									if o.material.texmap_opacity.map1 != undefined then(
										showTextureMap o.material o.material.texmap_opacity.map1 state
									)else if o.material.texmap_opacity.map2 != undefined then(
										showTextureMap o.material o.material.texmap_opacity.map2 state
									)
								)else(
									showTextureMap o.material o.material.texmap_opacity state
								)
							)
						)catch(
							print ("Could not update: " + o.name)
						)
					)else if (classof o.material) == MultiMaterial then(
						for m in o.material do(
							if (classof m) == standardMaterial then(
								try(
									if m.OpacityMap != undefined then(
										-- si material de type contenu dans matClasses (mix, falloff, etc)
										if finditem Matclasses (classof (m.OpacityMap))>0 then(
											if m.OpacityMap.map1 != undefined then(
												showTextureMap m m.OpacityMap.map1 state
											)else if m.OpacityMap.map2 != undefined then(
												showTextureMap m m.OpacityMap.map2 state
											)
										)else(
											showTextureMap m m.OpacityMap state
										)
									)
								)catch(
									print (getCurrentException())
									print ("Could not update: " + o.name)
								)
							)else if (classof m) == VrayMtl then(
								try(
									if m.texmap_opacity != undefined then(
										if finditem Matclasses (classof (m.texmap_opacity))>0 then(
											if m.texmap_opacity.map1 != undefined then(
												showTextureMap m m.texmap_opacity.map1 state
											)else if m.texmap_opacity.map2 != undefined then(
												showTextureMap m m.texmap_opacity.map2 state
											)
										)else(
											showTextureMap m m.texmap_opacity state
										)
									)
								)catch(
									print (getCurrentException())
									print ("Could not update: " + o.name)
								)
							)
						)
						
						
					)
				)
				calcPercent inc tot
			)
		)
			
		on chk_diffuse changed state do(
			if state == true then(
				chk_bump.state = false
				chk_reflection.state = false
				chk_ambient.state = false
				chk_selfillu.state = false
				chk_opacity.state = false
			)else(
				chk_diffuse.state = true
			)
		)
		
		on chk_bump changed state do(
			if state == true then(
				chk_diffuse.state = false
				chk_reflection.state = false
				chk_ambient.state = false
				chk_selfIllu.state = false
				chk_opacity.state = false
			)else(
				chk_bump.state = true
			)
		)
		
		on chk_reflection changed state do(
			if state == true then(
				chk_diffuse.state = false
				chk_bump.state = false
				chk_ambient.state = false
				chk_selfIllu.state = false
				chk_opacity.state = false
			)else(
				chk_reflection.state = true
			)
		)
		
		on chk_ambient changed state do(
			if state == true then(
				chk_bump.state = false
				chk_reflection.state = false
				chk_diffuse.state = false
				chk_selfillu.state = false
				chk_opacity.state = false
			)else(
				chk_ambient.state = true
			)
		)
		
		on chk_selfIllu changed state do(
			if state == true then(
				chk_diffuse.state = false
				chk_reflection.state = false
				chk_ambient.state = false
				chk_bump.state = false
				chk_opacity.state = false
			)else(
				chk_selfIllu.state = true
			)
		)
		
		on chk_opacity changed state do(
			if state == true then(
				chk_diffuse.state = false
				chk_bump.state = false
				chk_ambient.state = false
				chk_selfIllu.state = false
				chk_reflection.state = false
			)else(
				chk_opacity.state = true
			)
		)
		
		on btn_on pressed do(
			if chk_diffuse.state == true then(
				turnOnDiffuseMaps on
			)else if chk_bump.state == true then(
				turnOnBumpMaps on
				)else if chk_reflection.state == true then(
					turnOnReflectionMaps on
					)else if chk_ambient.state == true then(
						turnOnAmbientMaps on
						)else if chk_selfillu.state == true then(
							turnOnSelfIlluMaps on
							)else if chk_opacity.state == true then(
								turnOnOpacityMaps on
			)
		)
		on btn_off pressed do(
			if chk_diffuse.state == true then(
				turnOnDiffuseMaps off
			)else if chk_bump.state == true then(
				turnOnBumpMaps off
				)else if chk_reflection.state == true then(
					turnOnReflectionMaps off
					)else if chk_ambient.state == true then(
						turnOnAmbientMaps off
						)else if chk_selfillu.state == true then(
							turnOnSelfIlluMaps off
							)else if chk_opacity.state == true then(
								turnOnOpacityMaps off
			)
		)
	)
	createDialog turnMap_roll 300 180
	)
)
