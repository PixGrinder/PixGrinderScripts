(	
	
	myCount = 0
	pda = for obj in geometry where classof obj != Targetobject and obj.numfaces >0 collect obj
	megArray = #()
	myStatus = 1
	myNames = #()
	myRes = 2048
	myMod = Normalmodifier flip:on
	clearListener()
	
	if maxFilePath.count == 0 do 
	(
		messagebox ("Please, save Max File before launching this script")
		myStatus = 0
	)
	
	
	if myStatus == 1 do
	(
		fn compareFN v1 v2 =
		(
			if v1[1] < v2[1] then -1 else 1
		)
		
		for obj in pda do 
		(
			setFaceSelection obj #{1..obj.numfaces}
			myTempFaces = getFaceSelection obj
			x1Temp = (meshop.getFaceArea (snapshotAsMesh obj) myTempFaces)
			if x1Temp > 5.9 then 
			append megArray #(x1Temp, obj)
		)

	
		qSort megArray compareFN -- arr:megArray -- On obtient la liste des objets, trié par surface
		
		for i = 1 to megArray.count do print (megArray[i][1] as string + " : " + megArray[i][2] as string)
	)
	actionMan.executeAction 0 "40472"


	-- set Mental Ray as renderer
	renderers.current = mental_ray_renderer()

	clearSelection()



	myMult = 1.2

	
	for obj in megArray do
	(
		clearSelection()
		max hide inv
		obj[2].isHidden = false
		myBox = box length:(myMult*(abs(obj[2].max.y - obj[2].min.y))) transform:obj[2].transform width:(myMult*(abs (obj[2].max.x - obj[2].min.x))) height:(myMult*(abs (obj[2].max.z - obj[2].min.z)))
		addModifier myBox myMod
		collapseStack myBox




		MyWarp = unwrap_UVW()
		setFaceSelection $ #{1..$.numfaces}
		addModifier $ MyWarp
		MyWarp.setMapChannel 3
		MyWarp.flattenMap 66.0 #() 0.005 true 0 true true


	)

max unhide all




)

----------------------------


/*

05 à 15 -> 256
15 à 60 -> 512
60 à 200 -> 1024
200 ++   -> 2048


obj = selection[1]
setFaceSelection obj #{1..obj.numfaces}
myTempFaces = getFaceSelection obj
x1Temp = (meshop.getFaceArea (snapshotAsMesh obj) myTempFaces)




$.numfaces
x1 = getFaceSelection obj as array


(meshop.getFaceArea (snapshotAsMesh obj) #{1..(getNumFaces obj)})




*/



