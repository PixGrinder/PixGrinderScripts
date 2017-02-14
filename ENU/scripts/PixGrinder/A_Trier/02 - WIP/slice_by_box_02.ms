(
	
	pda01 = getCurrentSelection()
	if pda01.count < 1 then messagebox "Please select one or more objects" else
	(
		pdac = $.center
		pda_ar = #()
		x = abs($.max[1]-$.min[1])
		y = abs($.max[2]-$.min[2])
		z = abs($.max[3]-$.min[3])

		global pda_dum = dummy isselected:true
		pda_dum.pos = pdac
		pda_dum.boxSize = [x,y,z]

		rollout boxslice "Box Slicer" 
		(
			spinner x1 "X" range:[-99999,999999,pda_dum.boxSize[1]] type:#float
			spinner y1 "Y" range:[-99999,999999,pda_dum.boxSize[2]] type:#float
			spinner z1 "Z" range:[-99999,999999,pda_dum.boxSize[3]] type:#float
			button btn1 "Slice !"

			
			on x1 changed state do pda_dum.boxSize = [x1.value,pda_dum.boxSize[2],pda_dum.boxSize[3]]
			on y1 changed state do pda_dum.boxSize = [pda_dum.boxSize[1],y1.value,pda_dum.boxSize[3]]
			on z1 changed state do pda_dum.boxSize = [pda_dum.boxSize[1],pda_dum.boxSize[2],z1.value]
			
			on btn1 pressed do 
			(
				pda_origin = copy pda_dum
				pda_origin.name = "original_bbox"
				hide pda_origin
				
				for obj in geometry do 
				(
					if intersects pda_origin obj == true do append pda_ar obj
				)
				select pda_ar	
				resetXForm $
				
				
				
				destroydialog boxslice
				messagebox "youpla"
			)
			
		)


		createDialog boxslice

		--delete pda_origin
	)
	

)
-----------------------------

for obj in geometry do 
(
	if intersects pda_origin obj == true do append pda_ar obj
)
select pda_ar	

modPanel.addModToSelection (SliceModifier ()) ui:on
$.modifiers[#slice].slice_plane.position = pda01.pos
$[1].modifiers[#slice].name = "bottom"
select $
	
	

$.pivot = $.center


	

