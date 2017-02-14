


obj_temp = getCurrentSelection()


if obj_temp.count == 1 do (


	if gw.isPerspectiveView() == false then 
	(

		max vpt persp user

		macros.run "Lights and Cameras" "Camera_CreateFromView"

		cam_temp = getActiveCamera()

		obj_temp[1].position = cam_temp.position

		select obj_temp

		-- in coordsys cam_temp move $ [0,0,-250]

		max vpt iso user

		delete cam_temp

	) else (

		macros.run "Lights and Cameras" "Camera_CreateFromView"

		cam_temp = getActiveCamera()

		obj_temp[1].position = cam_temp.position

		select obj_temp

		in coordsys cam_temp move $ [0,0,-250]

		delete cam_temp

		
	)

)


