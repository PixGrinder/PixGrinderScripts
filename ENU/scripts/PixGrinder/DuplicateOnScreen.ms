-- DuplicateOnScreen --
-- DuplicateOnScreen.ms --
-- Replace "Ctrl + V" Command --



myObj = copy selection[1]




macros.run "Lights and Cameras" "StandardCamera_CreateFromView"
cam_temp = getActiveCamera()
cam_temp.type = #free
cam_temp.parent = myObj
select myObj
max move
toolMode.coordsys #screen

rollout DelCam "Delete cam"
(
	button myBtn "Del Cam"

	on myBtn pressed do 
	(
		delete cam_temp
		destroyDialog DelCam
	)
)


createDialog DelCam




/*
camTransform = Inverse(viewport.getTM())

c = Freecamera  targetDistance:1.0 isSelected:off
c.orthoProjection = false
c.Transform = camTransform
viewport.setcamera c

7890UIOPè_çàuiop

*/