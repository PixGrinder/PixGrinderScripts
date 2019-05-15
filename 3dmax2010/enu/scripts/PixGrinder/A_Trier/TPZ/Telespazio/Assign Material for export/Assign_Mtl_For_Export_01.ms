
/*
faire un array des vrais materiaux + un array des noms de materiaux


*/



try(destroyDialog testRoll) catch()

rollout testRoll ""
(
	
	local mtls = #("Bark", "Grass", "Face")
	local currentMtl
	local visibleObjectsWithCurrentMtl = #()
	
	
	label currentMtlLbl "Current Material :"
	dropdownlist newMtlDdl ""
	button goBtn "Change Mtl"
	button selectBtn "Select"
	

	on testRoll open do 
	(
		-- get visible objects
		visibleObjects = for o in objects where o.isHiddenInVpt == false collect o

		-- get material of visible object that match the mtls array
		for i = 1 to visibleObjects.count do 
		(
			_name = visibleObjects[i].Material.name
			_index = findItem mtls _name
			if (_index != 0) then 
			(
				currentMtl = visibleObjects[i].Material
				append visibleObjectsWithCurrentMtl visibleObjects[i]
			)
		)
		currentMtlLbl.text = "Current Material : " + currentMtl.name
		
		
		-- get unassign material that match the mtls array and assign it to the dropdownlist
		local otherMtls =  #("Bark", "Grass", "Face")
		_index = finditem otherMtls currentMtl.name
		otherMtls = deleteItem otherMtls _index
		newMtlDdl.Items = otherMtls
	)
	
	
	on goBtn pressed do 
	(
		local newMtl
		for aMtlType in material.classes do 
		(
			for aMtl in (getClassInstances aMtlType processAllAnimatables:true) do
			(
				print aMtl.name
-- 				if aMtl.name == newMtlDdl.Selected do 
-- 				(
-- 					visibleObjectsWithCurrentMtl.material = aMtl
-- 					currentMtl = aMtl
-- 					currentMtlLbl.text = "Current Material : " + currentMtl.name
-- 					
-- 					local otherMtls =  #("Bark", "Grass", "Face")
-- 					_index = finditem otherMtls currentMtl.name
-- 					deleteItem otherMtls _index
-- 					newMtlDdl.Items = otherMtls
-- 				)
			)
		)
		
	)
	
	
	on selectBtn pressed do select visibleObjectsWithCurrentMtl
	
	
	


)
createDialog testRoll 300 100 style:#(#style_titlebar, #style_sysmenu, #style_toolwindow)