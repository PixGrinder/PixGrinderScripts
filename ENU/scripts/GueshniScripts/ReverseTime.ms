(
	try DestroyDialog reverseKeys catch()
	rollout reverseKeys "Reverse Time"
(	
	group "Animation Range"
	(
		spinner astr  "Start:" range:[0,20000,0] type:#integer width:70 across:2 align:#left
		spinner aend "End:" range:[0,20000,30] type:#integer width:70 align:#left
		button revKeys "Reverse Time" width:135
	)
	group "Help"
	(
		label inf1 "[1] Select object(s)" align:#left
		label inf2 "[2] Enter range" align:#left
		label inf3 "[3] Press button" align:#left
	)
	on revKeys pressed do
	(	
		if selection.count >= 1 then
		(
			for i in selection do
			(
				if i.controller != undefined and i.isAnimated then
					reversetime i.controller astr.value aend.value #incleft #incright
			)
		)
	)
)
createDialog reverseKeys pos:[140,210] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)
)