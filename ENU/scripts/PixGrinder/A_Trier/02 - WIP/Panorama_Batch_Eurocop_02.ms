-- Set Resolution for each face of the cubeMap :
------------------------------------------------------
pda_res = 512
-----------------------------------------------------------

-- Rendered Frame Window affiché ou non : 
-- (true  = affiché; false=caché)
--------------------------------------------------

pda_vfb = false

-- NetRender ??
------------------

pda_netr=true

-- Output Folder
-------------------

pda_output = "\\\\NAS_TOULOUSE\\Projects\\RF-SBC-PLB3000-Turbo\\Echange\\CubeMaps\\test\\"

pda1 = eulerangles 0 90 0
pda2 = eulerangles 90 0 0



--pda3 = eulerangles 180 0 0

for j = 1 to cameras.count do (

	pda_fov = cameras[j].fov
	cameras[j].fov = 90


	

	
	pda_fr = pda_output+cameras[j].name+"_front.jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_fr vfb:pda_vfb renderType: #normal netrender:pda_netr
	in coordsys local rotate cameras[j] pda1
	
	pda_rt = pda_output+cameras[j].name+"_right.jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_rt vfb:pda_vfb renderType: #normal netrender:pda_netr
	in coordsys local rotate cameras[j] pda1	
	
	pda_bk = pda_output+cameras[j].name+"_back.jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_bk vfb:pda_vfb renderType: #normal netrender:pda_netr
	in coordsys local rotate cameras[j] pda1

	pda_lf = pda_output+cameras[j].name+"_left.jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_lf vfb:pda_vfb renderType: #normal netrender:pda_netr
	
	in coordsys local rotate cameras[j] pda1

	in coordsys local rotate cameras[j] pda2
	
	pda_up = pda_output+cameras[j].name+"_up.jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_up vfb:pda_vfb renderType: #normal netrender:pda_netr

	in coordsys local rotate cameras[j] pda2
	in coordsys local rotate cameras[j] pda2
	pda_dn = pda_output+cameras[j].name+"_down.jpg"
	render camera:cameras[j] frame:400 outputsize:[pda_res,pda_res] outputfile:pda_dn vfb:pda_vfb renderType: #normal netrender:pda_netr

	in coordsys local rotate cameras[j] pda2
	

	

	)
	
	

		
	cameras[j].fov = pda_fov
	
	)


	