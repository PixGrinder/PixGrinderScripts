macroScript Macro17
	category:"DragAndDrop"
	toolTip:""
(
	(
				global pda_cur = getCurrentSelection()
				
				
				global pda_dum=dummy name:"Avirer" boxsize:[sZ,sZ,sZ] isselected:true
				
				
				fn get_normal_function_Ins msg ir obj faceNum shift ctrl alt =
				(
					if msg == #freeMove then
					(
						if ir != undefined then
						(
							pda_dum.pos = ir.pos 
							pda_dum.dir = ir.dir
							return #continue
						)
						else(return #continue)
					)
					
	-- 				if msg == #mousePoint then
	-- 				(
	-- 					return #end
	-- 				)
					
					
					if msg == #mouseAbort then 
					(
						return #end
					)
				)
				
		if pda_cur.count == 1 and superclassof pda_cur[1] ==  GeometryClass then
		(
			sZ = abs (pda_cur[1].max - pda_cur[1].min) / 3
			pda_dum.boxsize = [sZ,sZ,sZ]
			mouseTrack  on:pda_cur[1] trackCallBack:get_normal_function_Ins
		) 
		else 
		(
			messageBox "You must have a Geometry object selected..." title:"Warning of the Dead" beep:true
			delete pda_dum
		)
		
		pda_cur.parent = pda_dum
		select pda_dum
		max move
		setRefCoordSys #local
	)
)
