-------------------------------------------------------------------------------
-- Felipe_MoveToView.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( ph_dassonville@yahoo.fr)
-- 2013/12/19
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript MoveToView
category:"Felipe Scripts"
toolTip:"Move selected object to current view"

(

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

)

