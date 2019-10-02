-- render materials -- 
-- v 1.0 --

if classof meditmaterials[1] == multimaterial then 
(
	rollout myRol "Rendering"
	(
		label txt1 "Rendering Materials..."
	)
	createDialog  myRol

	clearListener()
	myVisible = for obj in objects where  obj.isHidden == false collect obj
	clearSelection()
	BG_Backup = backgroundColor

	max hide inv

	myLay = LayerManager.getLayer 0
	myLay.isHidden = false
	myLay.current = true
	myLay.nodes &theNodes
	theNodes.ishidden = true


	mySphere = Sphere radius:5 segs:128 pos:[0.0,0.0,0.0] isSelected:off
	myCam = Freecamera fov:60.0 transform:(matrix3 [0.97437,0.224951,0] [-0.0601155,0.260389,0.96363] [0.21677,-0.938933,0.267238] [2.57345,-11.55,3.35864])
	-- select myCam
	backgroundColor = color 100 100 100

	myMat = MeditMaterials[1]



	myPath = maxfilepath + myMat.name
	makeDir myPath

	myAr = myMat.materialIDList

	for id in myAr do
	(
		myFormatNumer = formattedPrint id format:"03d"
		myFile = myPath + @"\" + myFormatNumer + "   -   " + myMat[id].name + ".jpg"
		mySphere.material = myMat[id]
		render camera:myCam outputSize:[512,512] outputfile:myFile vfb:false
	)


	backgroundColor = BG_Backup 
	finalPath = (getFiles (myPath+@"\*.jpg"))[1]
	Hiddendoscommand ("explorer.exe /select, "+ "\"" + finalPath + "\"")
	delete myCam
	delete mySphere
	myVisible.isHidden = false
	destroyDialog  myRol
) else (messageBox ("Please insert a multimaterial in the 1st material editor slot"))


-----------

