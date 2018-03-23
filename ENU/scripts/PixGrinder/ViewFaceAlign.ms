---------------------------------------------------------------------

-- PixGrinder Scripts --
-- View Face Align --
-- ViewFaceAlign.ms --
-- Select one face, and views align to it --
-- V 1.0 --
-- Mail : dassonphil@gmail.com --

---------------------------------------------------------------------

(
	myDist = distance selection[1].min selection[1].max
	myFaceNb = (polyop.getFaceSelection selection[1]) as array
	myCam = FreeCamera orthoProjection:true fov:0.5 pos:[0,0,0]
	myCam.dir = polyop.getFaceNormal selection[1] myFaceNb[1]
	myCam.pos = polyop.getFacecenter selection[1] myFaceNb[1]
	in CoordSys Local move myCam [0,0,myDist]
	viewport.setCamera myCam
	redrawViews()
	viewport.setType #view_iso_usera
	delete myCam
	max zoomext sel
	max pancamera
)