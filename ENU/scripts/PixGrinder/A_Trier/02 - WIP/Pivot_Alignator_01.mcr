			pda_dum=dummy name:"Avirer" boxsize:[10,10,10]
			pda_cur = getCurrentSelection()
			
			fn get_normal_function_Ins msg ir obj faceNum shift ctrl alt = -- Function to track the mouse and instance the clone object
			(

				if msg == #freeMove then
				(
					if ir != undefined then
					(
						pda_dum.pos = ir.pos 
						pda_dum.dir = ir.dir
						--global NormalDirection = ir.dir
						-- Addition by Martin Breidt
-- 						if ctrl then in coordsys local (rotate Obj_to_align (eulerangles 90 0 0))
-- 						if alt then in coordsys local (rotate Obj_to_align (eulerangles 0 90 0))
-- 						if shift then Obj_to_align.dir *= -1
						-- End Addition 
						return #continue
					)
					else(return #continue)
				)
				if msg == #mouseAbort then 
				(
-- 					Obj_to_align.transform = Obj_Initial_Pos 
-- 					print "Align Object To Face Aborted!\n" 
-- 					Clone_But.state = false
					return #end
				)
-- 				if msg == #mousePoint --then (return #continue)
-- 				then
-- 				(
-- 					maxops.clonenodes CloneObjNode newNodes:&newClonedObj cloneType:#instance
-- 					print "Align Object To Face Finished.\n" 
-- 					return #continue
-- 				)
-- 				if msg == #mouseMove then 
-- 				(
-- 					if NormalDirection[1] != 0 then rotate CloneObjNode (eulerangles NormalDirection[1] 0 0)
-- 					if NormalDirection[2] != 0 then rotate CloneObjNode (eulerangles 0 NormalDirection[2] 0)
-- 					if NormalDirection[3] != 0 then rotate CloneObjNode (eulerangles 0 0 NormalDirection[3])
-- 					return #continue
-- 				)
			)
			
			
			
			mouseTrack  on:pda_cur trackCallBack:get_normal_function_Ins
			
			pda_cur.parent = pda_dum
			
			select pda_dum
			
			setRefCoordSys #local
