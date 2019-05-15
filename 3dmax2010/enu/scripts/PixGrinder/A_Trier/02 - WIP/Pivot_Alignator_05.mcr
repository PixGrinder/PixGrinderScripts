
(
			global pda_cur = getCurrentSelection()
			select pda_cur
			mySize = $.max - $.min
			mySize = ((mySize[1]+mySize[2]+mySize[3])/3)/3
			
			global pda_dum=dummy name:"Avirer" boxsize:[mySize,mySize,mySize] isselected:true
			
			
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
		mouseTrack  on:pda_cur[1] trackCallBack:get_normal_function_Ins
	) 
	else 
	(
		messageBox "You must have a Geometry object selected..." title:"Warning of the Dead" beep:true
		delete pda_dum
	)
	
	obj = pda_cur[1]
	rot = pda_dum.transform.rotation
	rotValInv=inverse rot
	animate off in coordsys local obj.rotation*=RotValInv
	obj.objectoffsetrot*=RotValInv
	obj.objectoffsetpos*=RotValInv
	--pda_cur.parent = pda_dum
	--select pda_dum
	--delete pda_dum
	select pda_cur[1]
	max move
	setRefCoordSys #local
)

