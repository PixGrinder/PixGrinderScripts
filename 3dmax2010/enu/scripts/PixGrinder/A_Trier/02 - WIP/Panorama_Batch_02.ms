-- Set Resolution for each face of the cubeMap :
------------------------------------------------------
pda_res = 128
-----------------------------------------------------------

-- Rendered Frame Window affiché ou non : 
-- (true  = affiché; false=caché)
--------------------------------------------------

pda_vfb = true


pda1 = eulerangles 0 90 0
pda2 = eulerangles 90 0 0



--pda3 = eulerangles 180 0 0

for j = 1 to cameras.count do (

	pda_fov = cameras[j].fov
	cameras[j].fov = 90
		
	pda_nm = "d:\\test\\pano\\front_"+cameras[j].name+".jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_nm vfb:pda_vfb renderType: #normal
	in coordsys local rotate cameras[j] pda1
	
	pda_nm = "d:\\test\\pano\\right"+cameras[j].name+".jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_nm vfb:pda_vfb renderType: #normal
	in coordsys local rotate cameras[j] pda1	
	
	pda_nm = "d:\\test\\pano\\back"+cameras[j].name+".jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_nm vfb:pda_vfb renderType: #normal
	in coordsys local rotate cameras[j] pda1

	pda_nm = "d:\\test\\pano\\left"+cameras[j].name+".jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_nm vfb:pda_vfb renderType: #normal
	
	in coordsys local rotate cameras[j] pda1

	in coordsys local rotate cameras[j] pda2
	
	pda_nm = "d:\\test\\pano\\up"+cameras[j].name+".jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_nm vfb:pda_vfb renderType: #normal

	in coordsys local rotate cameras[j] pda2
	in coordsys local rotate cameras[j] pda2
	pda_nm = "d:\\test\\pano\\down"+cameras[j].name+".jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_nm vfb:pda_vfb renderType: #normal

	in coordsys local rotate cameras[j] pda2
	
	Box lengthsegs:1 widthsegs:1 heightsegs:1 length:10 width:10 height:10 mapcoords:on isSelected:on  name:(cameras[j].name as string+"_box")
	$.center = cameras[j].pos
	modPanel.addModToSelection (NormalModifier ()) ui:on 
	$.modifiers[1].flip = on
		
		
		
	cameras[j].fov = pda_fov
	
	)

	
-- Brouillon : 
---------------	
	
j=1
meditMaterials[1] = Multimaterial ()
meditMaterials[1].numsubs = 6
meditMaterials[1].name = (cameras[j].name+"_multimat")
meditMaterials[1][1].name = (cameras[j].name+"_mat_front")
meditMaterials[1][2].name = (cameras[j].name+"_mat_right")
meditMaterials[1][3].name = (cameras[j].name+"_mat_back")
meditMaterials[1][4].name = (cameras[j].name+"_mat_left")
meditMaterials[1][5].name = (cameras[j].name+"_mat_up")
meditMaterials[1][6].name = (cameras[j].name+"_mat_down")	
MatEditor.Close()
MatEditor.Open()
	
	--medit.UpdateMtlEditorBrackets()
	
VFB_Interface

	
	