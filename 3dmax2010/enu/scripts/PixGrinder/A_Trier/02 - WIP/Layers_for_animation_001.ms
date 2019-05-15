
(
	clearListener()

	zeroLayer = LayerManager.getLayer 0


	fn cleanLayers = 
	(
		l_ar = #()

		l0 = layermanager.getLayer 0
		l0.current = true

		for i = 1 to (layermanager.count-1) do 
		(
			x = layermanager.getLayer i
			append l_ar x.name
		)
		
		for i = 1 to l_ar.count do
		(
			LayerManager.deleteLayerHierarchy l_ar[i] forceDelete:false
		)
	)

	-- myObjects = objets hors layers zz et hotspots
	myObjects = for obj in objects where (matchpattern obj.layer.name pattern:"zz*" == false) and (matchpattern obj.layer.name pattern:"Hotspots*" == false) collect obj


	-- mettre tous les objets de myObjects dans le layer 0_default
	for obj in myObjects do zeroLayer.addNode obj
	cleanLayers()

	-- creation du layer "Structure" et ajout de tous les objets non animés dedans
	mainLayer = LayerManager.newLayerFromName "Static"
	for obj in myObjects where obj.isAnimated == false and obj.parent == undefined and obj.children.count == 0 do mainLayer.addNode obj

	-----
	myAnim = for obj in myObjects where obj.isAnimated == true collect obj

	myRoot = for obj in myAnim where obj.parent == undefined collect obj

	myOdd = for obj in myAnim where obj.parent != undefined collect obj

	for obj in myRoot do
	(
		x1 = LayerManager.newLayerFromName ("anim_"+obj.name)
		x1.addNode obj
		if obj.children.count > 0 do for bla in obj.children do x1.addNode bla
	)
	

)



