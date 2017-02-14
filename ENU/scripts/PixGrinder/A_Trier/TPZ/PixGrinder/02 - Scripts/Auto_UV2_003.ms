-- Auto UV 2

(
	clearListener()
	select geometry[1]
	myMod = unwrap_UVW()
	myMod.setMapChannel 2
	myMod.name = "FelipeUnwrap"
	myProg = 0
	i=1
	max modify mode
	progressStart "Unwrapping UVs 2..."
	for obj in geometry do
	(
		if (100*(i as float)/geometry.count > (myProg as float)) do  --then print "youpi" else print ((obj as float)/gem.count) as string
		(
			myProg = myProg+1
			progressUpdate myProg
		)
		convertToPoly obj
		addmodifier obj myMod
		--modPanel.addModToSelection myMod
		select obj
		subobjectlevel = 3
		max select all
		obj.modifiers[1].flattenMap 66.0 #() 0.01 true 0 true true
		subobjectlevel = 0
		collapseStack obj
		i = i+1
	)
	
-- 	for i = 1 to geometry.count do
-- 	(
-- 		select geometry[i]
-- 		convertToPoly selection[1]
-- 		addmodifier selection[1] myMod
-- 		selection[1].modifiers[1].setMapChannel 2
-- 		subobjectlevel = 0
-- 		subobjectlevel = 3
-- 		max select all
-- 		selection[1].modifiers[1].flattenMap 66.0 #() 0.01 true 0 true true
-- 		subobjectlevel = 0
-- 		collapseStack selection[1]

-- 	)
	progressEnd()
)