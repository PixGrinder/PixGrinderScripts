
(
try(destroyDialog testRoll) catch()
	
	
local myMtlsName = #("nh90_NFH", "nh90_TTH", "nh90_NNLN2", "nh90_NNWN")	
local currentMtl 
local visibleObjs = for o in objects where o.isHiddenInVpt == false collect o
local myMtls = #()
	
	
-- get all Materials	
fn getAllMtls = 
(
	aMtls = #()
	for aMtlType in material.classes do 
	(
		for aMtl in (getClassInstances aMtlType processAllAnimatables:true) do
		(
			append aMtls aMtl
			
		)
		
	)
	
	return aMtls
	
)


-- find the material we need in visibles objects
fn getMtl objArray =
(
		for obj in objArray do 
		(
			if(obj.Material != undefined) and (findItem myMtlsName obj.Material.Name != 0) then return obj.Material
			
		)
		
)


rollout testRoll ""
(
	
	label currentMtlLbl "Current Material : "
	dropdownlist MtlListDdl 
-- 	button goBtn "Go"
	
	-- update the dropdownlist
	fn updateDdl = 
	(
		tempArray = #()
		for i = 1 to myMtls.count do 
		(
			tempArray[i] = myMtls[i].Name
			
		)
		
		MtlListDdl.items = tempArray
		
	)
	
	
	on testRoll open do 
	(
		-- collect visible objects materials, find the one we need and set its name to the label
		currentMtl = getMtl visibleObjs
		currentMtlLbl.text =  "Current Material : " + currentMtl.Name
		
		-- get all materials
		local aMtls = getAllMtls()
		
		-- get only needed materials
		for i = 1 to aMtls.Count do 
		(
			if (findItem myMtlsName aMtls[i].name != 0 and aMtls[i] != currentMtl)  do 
			(
				append myMtls aMtls[i]
				
			)
			
		)
		
		updateDdl()
		
	)
	
	on MtlListDdl  selected arg do 
	(
		-- get objects that use currentMtl and are visible in viewport and assign the choosen material
		objs = for o in objects where o.Material == currentMtl  and o.isHiddenInVpt == false collect o
		objs.Material = myMtls[arg]
		
		-- update materials array, label and dropdownlist
		deleteItem myMtls (findItem myMtls myMtls[arg])
		append myMtls currentMtl 
		
		currentMtl = objs[1].Material
		currentMtlLbl.text =  "Current Material : " + currentMtl.Name
		updateDdl()

	)
	



)
createDialog testRoll 300 50 style:#(#style_titlebar, #style_sysmenu, #style_toolwindow)
)