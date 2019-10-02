-- render materials -- 

clearListener()
myVisible = for obj in objects where  obj.isHidden == false collect obj
clearSelection()
BG_Backup = backgroundColor

max hide inv
mySphere = Sphere radius:5 segs:128 pos:[0.0,0.0,0.0] isSelected:off
myCam = Freecamera fov:60.0 transform:(matrix3 [0.97437,0.224951,0] [-0.0601155,0.260389,0.96363] [0.21677,-0.938933,0.267238] [2.57345,-11.55,3.35864])
-- select myCam
backgroundColor = color 100 100 100




myPath = maxfilepath + @"MatRender\"
makeDir myPath

myFile = myPath + "test.jpg"

render camera:myCam outputSize:[512,512] outputfile:myFile vfb:false




backgroundColor = BG_Backup 
Hiddendoscommand ("explorer.exe /select, "+ "\"" + myFile + "\"")
delete myCam
delete mySphere
