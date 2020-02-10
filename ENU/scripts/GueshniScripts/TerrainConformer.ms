/*
Terrain_conformer version 1.1
problème d'offset et de coordonnées systèmes corrigées
*/
	try(destroyDialog terrain_conformer)catch()
	rollout terrain_conformer "Terrain Conformer" -- width:147 height:204
(
	fn isPoly obj = classof obj == editable_poly
	
	pickbutton PRoad "Pick Road" pos:[13,15] width:120 height:25 filter:isPoly
	pickbutton PTerrain "Pick Terrain" pos:[13,48] width:120 height:25 filter:isPoly
	spinner BDist "" pos:[19,104] width:113 height:16 range:[0,1000,10] type:#worldunits
	button CTerr "Conform Terrain" pos:[13,131] width:120 height:25
	button UndoC "Undo Conform" pos:[13,163] width:120 height:25
	label lbl1 "Blend distance :" pos:[19,84] width:112 height:16
	
	global road_original, road_copy, terrain_original, terrain_copy
	/*
	fn roadPos rd tr =
	(
		rd.pos.z = tr.max.z*2
		start = polyop.getvert rd 1
		rdown = ray start (start - [0,0,1000000000])
		arr = intersectray tr rdown
		dist = (arr.pos.z-start)+0.1
		move rd [0,0,dist.z]
	)
	*/
	fn resetObj obj =
	(
		resetxform obj
		collapsestack obj
	)
	
	on terrain_copyonformer closed do
	(
		gc()
		clearUndoBuffer()
	)
	on PRoad picked obj do
	(
		PRoad.caption = obj.name
		if (polyop.getFaceNormal obj 1)[3] < 0 then 
		(
			select obj
			max modify mode
			subobjectlevel = 4
			polyop.setfaceselection $ #all
			$.flipNormals 1
			subobjectlevel = 0
			max create mode
			polyop.setfaceselection $ #none
		)
	)
	on PTerrain picked obj do
	(
		PTerrain.caption = obj.name
		if (polyop.getFaceNormal obj 1)[3] < 0 then 
		(
			select obj
			max modify mode
			subobjectlevel = 4
			polyop.setfaceselection $ #all
			$.flipNormals 1
			subobjectlevel = 0
			max create mode
			polyop.setfaceselection $ #none
		)
	)
	on CTerr pressed do
	(
		blend_dist = BDist.value
		road_original = PRoad.object
		terrain_original = PTerrain.object
		if isvalidobj road_original and isvalidobj terrain_original then
		(
			road_pivot = road_original.pivot
			terr_pivot  = terrain_original.pivot
			max create mode
			
			resetObj terrain_original 
			resetObj road_original
			road_copy    = copy road_original
			terrain_copy = copy terrain_original
			road_copy.wirecolor    = road_original.wirecolor
			terrain_copy.wirecolor = terrain_original.wirecolor
			road_copy.MakePlanarIn #z selLevel:#object
			terrain_copy.MakePlanarIn #z selLevel:#object
			
			trp = terrain_copy.pivot 
			trp = [trp.x, trp.y, terrain_copy.center.z]
			terrain_copy.pivot = trp
			
			road_copy.pos.z -= 0.1
			terrain_copy.pos.z = road_copy.center.z + 0.1
			terrain_copy.pivot = terrain_original.pivot
						
			resetObj terrain_copy
			resetObj road_copy
				
			addmodifier terrain_copy (morpher())
			addmodifier road_copy (morpher())
			when select terrain_copy changes id:#terc handleAt:#redrawViews do
			(
				deleteAllChangeHandlers id:#terc
				WM3_MC_BuildFromNode terrain_copy.modifiers[1] 1 terrain_original 
			)
			when select road_copy changes id:#roadc handleAt:#redrawViews do
			(
				deleteAllChangeHandlers id:#roadc
				WM3_MC_BuildFromNode road_copy.modifiers[1] 1 road_original
			)
			grp = #(terrain_copy,road_copy)
			select grp
			redrawViews()
			addmodifier terrain_copy (Skin_wrap())
			terrain_copy.modifiers["Skin Wrap"].falloff = 10
			terrain_copy.modifiers["Skin Wrap"].blend = true
			terrain_copy.modifiers["Skin Wrap"].blendDistance = blend_dist
			terrain_copy.modifiers["Skin Wrap"].threshold = blend_dist
			terrain_copy.modifiers["Skin Wrap"].engine = 0
			terrain_copy.modifiers["Skin Wrap"].meshlist = #(road_copy)
			when select terrain_copy changes handleAt:#redrawViews do
			(
				deleteAllChangeHandlers()
				WM3_MC_SetValue  road_copy.modifiers["Morpher"] 1 100.0
				WM3_MC_SetValue  terrain_copy.modifiers["Morpher"] 1 100.0
				collapsestack terrain_copy
				collapsestack road_copy
				terrain_copy.pivot = terrain_original.pivot
				road_copy.pivot = road_original.pivot
				resetObj road_copy
				resetObj terrain_copy
				road_copy.pos.z += 0.1
				--roadPos road_copy terrain_copy
			)
			select terrain_copy
			redrawViews()
			update terrain_copy
			grp = #(road_original, terrain_original)
			hide grp
			gc()
			clearUndoBuffer()
			select road_copy
			
		)
		else print "Not valid"
	)
	on UndoC pressed do
	(
		delete #(terrain_copy,road_copy)
		unhide #(road_original, terrain_original)
		redrawViews()
	)
)
-- createdialog terrain_conformer
createdialog terrain_conformer  width:147 height:204 pos:[140,210] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)
