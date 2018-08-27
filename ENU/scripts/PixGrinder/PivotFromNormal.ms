-- Pivot from Normal -- 
-- PivotFromNormal.ms -- 
-- Align and center object's pivot from face selection --



(

	myCond = true


	if myCond == true then 

	(
		max modify mode
		myObj = selection[1]
		myParent = myObj.parent
		myObj.parent = undefined
		resetXForm myObj
		collapseStack myObj
		myTempMesh = snapshotAsMesh myObj
		myFaceNb = (getFaceSelection myTempMesh) as array -- tableau des faces selectionnées

		fn averageSelVertPosition obj =
		(
		    verts = obj.selectedVerts
		    --verts = meshop.getVertSelection obj
		    p = Point3 0 0 0
		    for v in verts do
		    (
		        p += v.pos
		    )
		    p = p/verts.count
		    return p
		)

		fn pda_RotatePivotOnly obj rotation= 
		( 
			local rotValInv=inverse (rotation as quat)
			animate off in coordsys local obj.rotation*=RotValInv
			obj.objectoffsetrot*=RotValInv
			obj.objectoffsetpos*=RotValInv
		)


---------- EN COURS -- 

		
		myDir = getFaceNormal myTempMesh myFaceNb[1] -- Direction = normal de la 1ere face de la selection
		subobjectlevel = 0
		pda_dum = point name:"Avirer" box:false constantscreensize:false axistripod:true size:0.1 isselected:false

		
		setVertSelection myTempMesh (meshop.getVertsUsingFace myTempMesh (getFaceSelection myTempMesh))
		pda_dum.pos = averageSelVertPosition myTempMesh
		pda_dum.dir = myDir

		myObj.pivot = pda_dum.pos
		pda_RotatePivotOnly myObj pda_dum.transform.rotation


-----------------


		delete myTempMesh
		delete pda_dum

		myObj.parent = myParent
		select myObj

		max scale
		toolMode.transformCenter()
		setRefCoordSys #local
		max move
		toolMode.transformCenter()
		setRefCoordSys #local
		max rotate
		toolMode.transformCenter()
		setRefCoordSys #local
		maxOps.pivotMode = #pivotOnly
	)


)
