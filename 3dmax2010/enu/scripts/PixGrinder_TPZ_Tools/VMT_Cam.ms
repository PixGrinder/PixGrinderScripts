-- VMT_Cam v 1.0--


clearListener()


if selection.count == 0 then 
(
	messageBox ("Please select object to be targeted by camera")
) else (

	obj = selection[1]


	try (macros.run "Lights and Cameras" "StandardCamera_CreateFromView") catch ()
	try (macros.run "Lights and Cameras" "Camera_CreateFromView") catch ()
	mytempCam = cameras[cameras.count-1]
	myCam = freeCamera fov:45 targetDistance:1.0 pos:mytempCam.pos
	--Freecamera fov:90 targetDistance:1.13247 nearclip:1 farclip:1000 nearrange:0 farrange:1000 mpassEnabled:off mpassRenderPerPass:off pos:[13.3107,-58.9446,0] isSelected:on
	myCam.transform = mytempCam.transform
	delete mytempCam

	try (close x1) catch ()


	deleteFile @"E:\NH90VMT\Emulation\Panels\Integrations\BAYVIEWS\ExternalView\test.txt"
	copyFile @"E:\NH90VMT\Emulation\Panels\Integrations\BAYVIEWS\ExternalView\ExternalView.xml" @"E:\NH90VMT\Emulation\Panels\Integrations\BAYVIEWS\ExternalView\test.txt"
	x1 = openFile (@"E:\NH90VMT\Emulation\Panels\Integrations\BAYVIEWS\ExternalView\test.txt") mode:"r+"
	seek x1 750
	--skipToString x1 "Eye"
--	flush x1


	format "%%;%;%%\r" "<Set name=\"Eye\" value=\"" myCam.pos.x myCam.pos.y myCam.pos.z "\" />" to:x1 
	format "%%;%;%%\r" "<Set name=\"Center\" value=\"" obj.center.x obj.center.y obj.center.z "\" />" to:x1 
	format "<Set name=\"Up\" value=\"0.0;0.0;1.0\" />\r" to:x1
	format "%%;%;%%\r" "<Set name=\"TrackballCenter\" value=\"" obj.center.x obj.center.y obj.center.z "\" />" to:x1 
	format "%%%\r" "<Set name=\"Distance\" value=\"" (distance obj myCam) "\" />" to:x1
	format "          " to:x1
 	--format "%%%\r" "<!--" myCam.name "-->" to:x1
-- 	filePos x1

	close x1

	delete myCam

	deleteFile @"E:\NH90VMT\Emulation\Panels\Integrations\BAYVIEWS\ExternalView\ExternalView.xml"
	copyFile @"E:\NH90VMT\Emulation\Panels\Integrations\BAYVIEWS\ExternalView\test.txt" @"E:\NH90VMT\Emulation\Panels\Integrations\BAYVIEWS\ExternalView\ExternalView.xml" 


	--Hiddendoscommand ("explorer.exe /select, " + (@"E:\NH90VMT\Emulation\Panels\Integrations\BAYVIEWS\ExternalView\" + "myCam.txt"))
)



/*
actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener

copyFile @"E:\NH90VMT\Emulation\Panels\Integrations\BAYVIEWS\ExternalView\test.xml" @"E:\NH90VMT\Emulation\Panels\Integrations\BAYVIEWS\ExternalView\test.txt"

skipToString x1 "Eye"
readLine x1
filePos x1p

close x1
close myStream
*/