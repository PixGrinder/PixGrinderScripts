toolMode.coordsys #local

pda1 = eulerangles 0 90 0
pda2 = eulerangles 90 0 0
--pda3 = eulerangles 180 0 0

for j = 1 to cameras.count do (

	pda_fov = cameras[j].fov
	cameras[j].fov = 90
	
	for i=1 to 4 do (
		

		-- select cameras[j]
		pda_nm = "d:\\test\\pano\\"+cameras[j].name+"test_"+i as string+".jpg"
		render camera:cameras[j] frame:400 outputsize:[2048,2048] outputfile:pda_nm vfb:true renderType: #normal
		rotate cameras[j] pda1
		
	)
cameras[j].fov = 90
rotate cameras[j] pda2
i=5
render camera:cameras[j] frame:400 outputsize:[2048,2048] outputfile:pda_nm vfb:true renderType: #normal
cameras[j].fov = pda_fov
	
	)


rotate $ pda1
	