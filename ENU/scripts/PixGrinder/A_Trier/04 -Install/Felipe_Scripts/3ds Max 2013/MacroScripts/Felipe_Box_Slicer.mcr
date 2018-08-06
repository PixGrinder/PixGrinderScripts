

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
		max scale

		rollout boxslice "Box Slicer" 
		(
			label cadre "" style_sunkenedge:true  width:250 height:80 pos:[10,10]
			label cadre2 "" style_sunkenedge:true  width:250 height:20 pos:[10,117]
			label txt1 "Place the volume"  pos:[100,25]
			label txt2 "on what you want to keep" 
			label txt3 "using 3dsmax Move and Scale tool." 
			label txt5 "And then, press the Slice Button :" pos:[60,120]
			button btn1 "Slice !" width:100 pos:[85,160]
			
			
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
				pda_tmp = point pos:[pda_origin.center[1],pda_origin.center[2],pda_origin.min[3]] name:"point_a_virer"
				pda_tmp.rotation = pda_origin.rotation
				hide pda_tmp
				
				-- slice bottom
				modPanel.addModToSelection (SliceModifier ()) ui:on
				pda_ar[1].modifiers[#slice].name = "bottom"
				pda_ar[1].modifiers["bottom"].enabled = false
				pda_ar[1].modifiers["bottom"].slice_plane.rotation = pda_tmp.rotation
				pda_ar[1].modifiers["bottom"].slice_plane.position = pda_tmp.position-$.center
				pda_ar[1].modifiers["bottom"].Slice_Type = 3
				select $
					
				-- slice top
				pda_tmp.pos = [pda_origin.center[1],pda_origin.center[2],pda_origin.max[3]]
				modPanel.addModToSelection (SliceModifier ()) ui:on
				pda_ar[1].modifiers[#slice].name = "top"
				pda_ar[1].modifiers["top"].enabled = false
				pda_ar[1].modifiers["top"].slice_plane.position = pda_tmp.position-$.center
				pda_ar[1].modifiers["top"].Slice_Type = 2
				select $
					
				-- slice left
				pda_tmp.pos = [pda_origin.min[1],pda_origin.center[2],pda_origin.center[3]]
				modPanel.addModToSelection (SliceModifier ()) ui:on
				pda_ar[1].modifiers[#slice].name = "left"
				pda_ar[1].modifiers["left"].enabled = false
				in coordsys world pda_ar[1].modifiers["left"].slice_plane.rotation =  (eulerAngles 0 90 0 )
				pda_ar[1].modifiers["left"].slice_plane.position = pda_tmp.position-$.center
				pda_ar[1].modifiers["left"].Slice_Type = 2
				select $
					
					
				-- slice right
				pda_tmp.pos = [pda_origin.max[1],pda_origin.center[2],pda_origin.center[3]]
				modPanel.addModToSelection (SliceModifier ()) ui:on
				pda_ar[1].modifiers[#slice].name = "right"
				pda_ar[1].modifiers["right"].enabled = false
				in coordsys world pda_ar[1].modifiers["right"].slice_plane.rotation =  (eulerAngles 0 90 0 )
				pda_ar[1].modifiers["right"].slice_plane.position = pda_tmp.position-$.center
				pda_ar[1].modifiers["right"].Slice_Type = 3
				select $
					
					
				-- slice front
				pda_tmp.pos = [pda_origin.center[1],pda_origin.min[2],pda_origin.center[3]]
				modPanel.addModToSelection (SliceModifier ()) ui:on
				pda_ar[1].modifiers[#slice].name = "front"
				pda_ar[1].modifiers["front"].enabled = false
				in coordsys world pda_ar[1].modifiers["front"].slice_plane.rotation =  (eulerAngles 90 0 0 )
				pda_ar[1].modifiers["front"].slice_plane.position = pda_tmp.position-$.center
				pda_ar[1].modifiers["front"].Slice_Type = 3
				select $
					
					
				-- slice back
				pda_tmp.pos = [pda_origin.center[1],pda_origin.max[2],pda_origin.center[3]]
				modPanel.addModToSelection (SliceModifier ()) ui:on
				pda_ar[1].modifiers[#slice].name = "back"
				pda_ar[1].modifiers["back"].enabled = false
				in coordsys world pda_ar[1].modifiers["back"].slice_plane.rotation =  (eulerAngles 90 0 0 )
				pda_ar[1].modifiers["back"].slice_plane.position = pda_tmp.position-$.center
				pda_ar[1].modifiers["back"].Slice_Type = 2
				select $
				
				for i = 1 to 6 do pda_ar[1].modifiers[i].enabled = true
				
				for i = 1 to pda_ar.count do collapseStack pda_ar[i]
				
				destroydialog boxslice
				
				for obj in geometry do
				(
					if obj.faces.count == 0 do delete obj
				)
				delete pda_origin
				delete pda_tmp
				delete pda_dum
				select pda_ar
				
			)
		)
		createDialog boxslice width:270 height:200 --escapeEnable:false
		
	)
)


