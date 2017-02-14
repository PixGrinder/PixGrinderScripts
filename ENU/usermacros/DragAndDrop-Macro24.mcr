macroScript Macro24
	category:"DragAndDrop"
	toolTip:""
(
	(
		(
			(
						global pda_cur = selection[1]
						pda_dum=dummy name:"Avirer" boxsize:[1,1,1] isselected:true
						
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
						
				if superclassof pda_cur ==  GeometryClass then
				(
					sZ = abs (distance pda_cur.max pda_cur.min) / 3
					pda_dum.boxsize = [sZ,sZ,sZ]
					mouseTrack  on:pda_cur trackCallBack:get_normal_function_Ins
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
	)
)
