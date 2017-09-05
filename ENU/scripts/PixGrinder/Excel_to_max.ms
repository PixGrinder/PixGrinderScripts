-- ouverture fichier csv avec infos composants
x1 = openfile "D:/10 - Helicopters/H225CompLoc/MAX/DataH225 - Excel to max.csv"

-- Ajout des infos dans un tableau --
myAr = #()
while eof x1 == false do append myAr (filterstring (readline x1) ";")
for obj in myAr do print obj

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
*//

-- ajout du customAttribute sur 1 composant
myTemp = getNodeByName myAr[2][1] exact:true
custAttributes.add myTemp _cl.compLocCA BaseObject:true

-- creation de la camera du composant
myCam = TargetCamera target:(Targetobject transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] [0,0,0]))
myCam.name = myAr[2][1] + "_" + myAr[2][2]
myCam.FOV = myAr[2][4] as integer
myCam.target.position = myTemp.center
myCam.pos.X = 
myCam.pos.Y = 
myCam.pos.Z = 

myCoords = for obj in myHot where obj[1] == myAr[2][2] collect obj

$.lookat