---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Selected To File --
-- ListSelectedToFile.ms --
-- Outputs selected objects names to external text file --
-- V 1.0 --

---------------------------------------------------------------------



(
	clearListener()

	fn mySort v1 v2 =
	(
		if v1.name > v2.name then 1 else -1
	)

	x1 = getClassInstances standardMaterial
	WithMaps = #()
	for obj in x1 where obj.diffuseMap != undefined do appendIfUnique WithMaps obj
	NoMaps = #()
	for obj in x1 where obj.diffuseMap == undefined do appendIfUnique NoMaps obj

	qsort WithMaps mySort
	qsort NoMaps mySort

	allMats = WithMaps + NoMaps


	myFile = (substituteString (maxFilePath+maxFileName) ".max" "")+"_materials.htm"

	if doesFileExist myFile == true then
	(
		messageBox("Text File already exists. Please back it up or rename it before re-using this script")
		Hiddendoscommand ("explorer.exe /select, "+ "\"" +myFile+"\"")
	) else (
		theFile = createFile myFile
		format "<TABLE BORDER=\"1\">\r<CAPTION>MyTable</CAPTION>\r" to:theFile
		format "<TR> <td>Material Name</td> <td style=\"width: 96px;\">Type</td> <td style=\"width: 137px;\">Map</td> <td style=\"width: 56px;\">Common</td> <td style=\"width: 128px;\">Sample</td> <td style=\"width: 522px;\">Photo</td> </TR>" to:theFile
		for i = 1 to allMats.count do
		(
			if allMats[i].diffuseMap != undefined then 
			(
				format "<TR> <TD>%</TD> <TD></TD> <TD>%</TD> <TD></TD> <TD><img src=% height=\"128\" width=\"128\"></TD> <TD> </TD></TR> \r" allMats[i].name (filenameFromPath allMats[i].diffuseMap.bitmap.filename) ("D:/Work/AS365CompLoc/Thumbs/0"+ i as string + "_" + allMats[i].name+".png") to:theFile
			) else (
				format "<TR> <TD>%</TD> <TD></TD> <TD>%</TD> <TD></TD> <TD><img src=% height=\"128\" width=\"128\"></TD> <TD></TD> </TR>\r" allMats[i].name allMats[i].diffuse ("D:/Work/AS365CompLoc/Thumbs/0"+ i as string + "_" + allMats[i].name+".png") to:theFile
			)
			$Sphere001.material = allMats[i]
			myMap = bitmap 128 128 filename:("D:/Work/AS365CompLoc/Thumbs/0"+ i as string + "_" + allMats[i].name+".png")
			render to:myMap vfb:true
			save myMap
			close myMap
		)

		close theFile
		Hiddendoscommand ("explorer.exe /select, "+ myFile)
	
	)

	
)



----------------------

/*

(
	clearListener()
	myTempAr = #()
	myTempAr = for obj in selection collect obj.name
	sort myTempAr
	myFile = (substituteString (maxFilePath+maxFileName) ".max" "")+"_objectsList.txt"
	if doesFileExist myFile == true then
	(
		messageBox("Text File already exists. Please back it up or rename it before re-using this script")
		Hiddendoscommand ("explorer.exe /select, "+ "\"" +myFile+"\"")
	) else (
		theFile = createFile myFile
		for obj in myTempAr do format "%\r" obj to:theFile
		close theFile
		Hiddendoscommand ("explorer.exe /select, "+ "\"" +myFile+"\"")
	)
)


--------------------------------------------
-- MAts.ms

clearListener()

fn mySort v1 v2 =
(
	if v1.name > v2.name then 1 else -1
)



x1 = getClassInstances standardMaterial
WithMaps = for obj in x1 where obj.diffuseMap != undefined collect obj
NoMaps = for obj in x1 where obj.diffuseMap == undefined collect obj

qsort WithMaps mySort
qsort NoMaps mySort

allMats = WithMaps + NoMaps

actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener


for obj in WithMaps do format "%;%\r" obj.name (filenameFromPath obj.diffuseMap.bitmap.filename)
for obj in NoMaps do format "%;%\r" obj.name obj.diffuse


-- Materials Render --

for i = 1 to allMats.count do 
(
	$Sphere001.material = allMats[i]
	myMap = bitmap 256 256 filename:("D:/Work/AS365CompLoc/Thumbs/0"+ i as string + "_" + allMats[i].name+".png")
	render to:myMap vfb:true
	save myMap
	close myMap
)

myString = "AS365_TranspColor_1"
x1 = getclassinstances standardmaterial
x2 = for obj in x1 where obj.name == myString collect obj
x2.count
meditmaterials[1] = x2[1]

*/
