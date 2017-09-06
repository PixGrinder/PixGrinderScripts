-- ouverture fichier csv avec infos composants
x1 = openfile "D:/10 - Helicopters/H225CompLoc/MAX/DataH225 - Excel to max_v2.csv"

-- Ajout des infos dans un tableau --
myAr = #()
while eof x1 == false do append myAr (filterstring (readline x1) ";")
-- for obj in myAr do print obj

-- fermeture fichier csv
close x1

/*
-- Infos Hotspots --
x1 = openfile "D:/10 - Helicopters/H225CompLoc/MAX/Hotspots.csv"

-- Ajout des infos HotSpots dans un tableau --
myHot = #()
while eof x1 == false do append myHot (filterstring (readline x1) ";")
for obj in myHot do print obj

-- fermeture fichier Hotspots csv
close x1
*/

-- ajout du customAttribute sur 1 composant
myTemp = getNodeByName myAr[2][1] exact:true
custAttributes.add myTemp _cl.compLocCA BaseObject:true

-- creation de la camera du composant
myCam = TargetCamera target:(Targetobject transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] [0,0,0]))
myCam.name = myAr[2][1] + "_" + myAr[2][2]
myCam.FOV = myAr[2][4] as float
myCam.target.position = myTemp.center
theYoupla = filterstring myAr[2][3] ","
theYoupla = [theYoupla[1] as float,theYoupla[2] as float,theYoupla[3] as float]
myCam.pos = theYoupla

myFinalCam = Freecamera()
myFinalCam.transform = myCam.transform
myFinalCam.name = myCam.name
myFinalCam.FOV = myAr[2][4] as float
delete myCam
myTemp.compLoc.hotspot = myFinalCam
myTemp.compLoc.hotspot.FOV = myAr[2][4] as float

