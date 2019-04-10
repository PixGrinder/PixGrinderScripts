

obj = selection[1]

macros.run "Lights and Cameras" "StandardCamera_CreateFromView"
mytempCam = cameras[cameras.count-1]
myCam = freeCamera fov:45 targetDistance:1.0 pos:mytempCam.pos
--Freecamera fov:90 targetDistance:1.13247 nearclip:1 farclip:1000 nearrange:0 farrange:1000 mpassEnabled:off mpassRenderPerPass:off pos:[13.3107,-58.9446,0] isSelected:on
myCam.transform = mytempCam.transform
delete mytempCam




x1 = openFile (@"E:\NH90VMT\Emulation\Panels\Integrations\BAYVIEWS\ExternalView\"+"myCam.txt") mode:"w"

seek x1 #eof
format "\r\r" to:x1
format "%%;%;%%\r" "<Set name=\"Eye\" value=\"" myCam.pos.x myCam.pos.y myCam.pos.z "\" />" to:x1 
format "%%;%;%%\r" "<Set name=\"Center\" value=\"" obj.center.x obj.center.y obj.center.z "\" />" to:x1 
format "<Set name=\"Up\" value=\"0.0;0.0;1.0\" />\r" to:x1
format "%%;%;%%\r" "<Set name=\"TrackballCenter\" value=\"" obj.center.x obj.center.y obj.center.z "\" />" to:x1 
format "%%%\r" "<Set name=\"Distance\" value=\"" (distance obj myCam) "\" />" to:x1
format "%%%\r" "<!--" myCam.name "-->" to:x1
filePos x1

close x1

delete myCam


Hiddendoscommand ("explorer.exe /select, " + (@"E:\NH90VMT\Emulation\Panels\Integrations\BAYVIEWS\ExternalView\" + "myCam.txt"))



/*



obj = selection[1]

macros.run "Lights and Cameras" "StandardCamera_CreateFromView"

myCam = cameras[1]


x1 = openFile (@"E:\NH90VMT\Emulation\Panels\Integrations\BAYVIEWS\ExternalView\"+"myCam.txt") mode:"a"

seek x1 #eof
format "\r\r" to:x1
format "<Par name=\"Index\" type=\"System.Int32\" value=\"4\" />\r" to:x1
format "<Par name=\"Identifier\" type=\"System.String\" value=\"Test\" />\r" to:x1
format "<Par name=\"AreaIndex\" type=\"System.Int32\" value=\"1\" />\r" to:x1
format "<Par name=\"AreaIdentifier\" type=\"System.String\" value=\"Stations\" />\r" to:x1
format "%%;%;%%\r" "<Par name=\"Eye\" type=\"System.String\" value=\"" myCam.pos.x myCam.pos.y myCam.pos.z "\" />" to:x1 
format "%%;%;%%\r" "<Par name=\"Center\" type=\"System.String\" value=\"" obj.pos.x obj.pos.y obj.pos.z "\" />" to:x1 
format "<Par name=\"Up\" type=\"System.String\" value=\"-0.07987452;-0.00239926;0.996802\" />\r" to:x1
format "%%;%;%%\r" "<Par name=\"TrackballCenter\" type=\"System.String\" value=\"" obj.pos.x obj.pos.y obj.pos.z "\" />" to:x1 
format "%%%" "<Par name=\"Distance\" type=\"System.Single\" value=\"" (distance obj myCam) "\" />" to:x1
filePos x1

close x1

*/