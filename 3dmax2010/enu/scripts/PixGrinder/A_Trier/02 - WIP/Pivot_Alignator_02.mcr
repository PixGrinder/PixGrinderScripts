



			pda_dum=dummy name:"Avirer" boxsize:[10,10,10]
			pda_cur = getCurrentSelection()
			
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
				if msg == #mouseAbort then 
				(
					return #end
				)
			)
			
			
			
			mouseTrack  on:pda_cur trackCallBack:get_normal_function_Ins
			
			pda_cur.parent = pda_dum
			
			select pda_dum
			
			setRefCoordSys #local
			
			
			
			messageBox "you must have an object selected" title:"Warning of the Dead" beep:true
