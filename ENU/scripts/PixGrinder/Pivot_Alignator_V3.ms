-- PixGrinder --
-- Pivot Alignator --
-- v2 --



(
	clearListener()
	try (delete pda_dum) catch ()
	if selection[1] == undefined then 
	(
		messageBox "You must have a Geometry object selected..." title:"Warning of the Dead" beep:true
	) 
	else
	(
		
		pda_cur = selection[1]
		sZ = (distance pda_cur.max pda_cur.min)/5
		pda_dum = point name:"Avirer" box:true constantscreensize:false axistripod:true size:sZ isselected:true
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
				delete pda_dum
				pda_dum = undefined
				return #end
			)
		)
			
			
		if superclassof pda_cur ==  GeometryClass then
		(
			mouseTrack  on:pda_cur trackCallBack:get_normal_function_Ins
		) 
		
		if pda_dum != undefined do
		(
			pda_cur.parent = pda_dum
			select pda_dum
			max move
			setRefCoordSys #local
		)
	) 
)



