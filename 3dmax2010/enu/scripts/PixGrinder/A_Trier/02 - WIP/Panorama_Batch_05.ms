-- Set Resolution for each face of the cubeMap :
------------------------------------------------------
pda_res = 512
-----------------------------------------------------------

-- Rendered Frame Window affiché ou non : 
-- (true  = affiché; false=caché)
--------------------------------------------------

pda_vfb = false


pda1 = eulerangles 0 90 0
pda2 = eulerangles 90 0 0



--pda3 = eulerangles 180 0 0

for j = 1 to cameras.count do (

	pda_fov = cameras[j].fov
	cameras[j].fov = 90


	

	
	pda_fr = "d:\\test\\pano\\front_"+cameras[1].name+".jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_fr vfb:pda_vfb renderType: #normal
	in coordsys local rotate cameras[j] pda1
	
	pda_rt = "d:\\test\\pano\\right_"+cameras[j].name+".jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_rt vfb:pda_vfb renderType: #normal
	in coordsys local rotate cameras[j] pda1	
	
	pda_bk = "d:\\test\\pano\\back_"+cameras[j].name+".jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_bk vfb:pda_vfb renderType: #normal
	in coordsys local rotate cameras[j] pda1

	pda_lf = "d:\\test\\pano\\left_"+cameras[j].name+".jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_lf vfb:pda_vfb renderType: #normal
	
	in coordsys local rotate cameras[j] pda1

	in coordsys local rotate cameras[j] pda2
	
	pda_up = "d:\\test\\pano\\up_"+cameras[j].name+".jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_up vfb:pda_vfb renderType: #normal

	in coordsys local rotate cameras[j] pda2
	in coordsys local rotate cameras[j] pda2
	pda_dn = "d:\\test\\pano\\down_"+cameras[j].name+".jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_dn vfb:pda_vfb renderType: #normal

	in coordsys local rotate cameras[j] pda2
	

	Box lengthsegs:1 widthsegs:1 heightsegs:1 length:10 width:10 height:10 mapcoords:on isSelected:on  name:(cameras[j].name as string+"_box")
	$.center = cameras[j].pos
	modPanel.addModToSelection (NormalModifier ()) ui:on 
	$.modifiers[1].flip = on

	meditMaterials[1] = Multimaterial ()
	meditMaterials[1].numsubs = 6
	meditMaterials[1].name = (cameras[j].name+"_multimat")
		meditMaterials[1][1].name = (cameras[j].name+"_mat_up")
		meditMaterials[1][1].diffuseMap = Bitmaptexture filename:pda_up
	meditMaterials[1][2] = StandardMaterial ()
		meditMaterials[1][2].name = (cameras[j].name+"_mat_down")
		meditMaterials[1][2].diffuseMap = Bitmaptexture filename:pda_dn
	meditMaterials[1][3] = StandardMaterial ()
		meditMaterials[1][3].name = (cameras[j].name+"_mat_left")
		meditMaterials[1][3].diffuseMap = Bitmaptexture filename:pda_lf
	meditMaterials[1][4] = StandardMaterial ()
		meditMaterials[1][4].name = (cameras[j].name+"_mat_right")
		meditMaterials[1][4].diffuseMap = Bitmaptexture filename:pda_rt
	meditMaterials[1][5] = StandardMaterial ()
		meditMaterials[1][5].name = (cameras[j].name+"_mat_back")
		meditMaterials[1][5].diffuseMap = Bitmaptexture filename:pda_bk
	meditMaterials[1][6] = StandardMaterial ()
		meditMaterials[1][6].name = (cameras[j].name+"_mat_front")	
		meditMaterials[1][6].diffuseMap = Bitmaptexture filename:pda_fr

	
	$.material = meditMaterials[1]
	for pda_i=1 to 6 do (
		$.material[pda_i].showInViewport=true
		meditMaterials[1][pda_i].selfIllumAmount = 100
	)
	
	
	MatEditor.Close()
	MatEditor.Open()
		
	cameras[j].fov = pda_fov
	
	)

	
-- Brouillon : 
---------------	

	
	meditmaterials[1][1].diffuseMap.Bitmap.height = (pda_res - 2)
	meditmaterials[1][1].diffuseMap.Bitmap.width = (pda_res - 2)
	
	
	
	viewImage() 
	
	rendermap $.material.diffusemap
	renderMap meditmaterial[1].diffuseMap size:[1024,1024] filename:"d:\\youpla.jpg" filter:false display:true -- [time:<time>]
	