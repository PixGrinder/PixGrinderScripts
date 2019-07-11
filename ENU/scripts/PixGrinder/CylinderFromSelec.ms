-- Pivot from Normal -- 
-- PivotFromNormal.ms -- 
-- Align and center object's pivot from face selection --
-- v 2.1 --



(

	myCond = true


	if myCond == true then 

	(
		

		fn pda_RotatePivotOnly obj rotation= 
		( 
			local rotValInv=inverse (rotation as quat)
			animate off in coordsys local obj.rotation*=RotValInv
			obj.objectoffsetrot*=RotValInv
			obj.objectoffsetpos*=RotValInv
		)


		max modify mode
		--convertToPoly myObj
		myObj = selection[1]---------------
		selection[1].layer.current = true
		polyop.detachFaces myObj (getFaceSelection myObj) delete:false asNode:true name:"myYouplaTemp"
		subobjectlevel = 0
		select (getNodeByName "myYouplaTemp")
		addModifier selection[1] (Smooth())
		collapseStack selection[1]
		myObj = selection[1]---------------
		resetXForm myObj
		collapseStack myObj
		selection[1].pivot = selection[1].center


---------- EN COURS -- 

		myFaceNb = (getFaceSelection myObj) as array -- tableau des faces selectionnées
		
		myDir = polyop.getFaceNormal myObj 1 -- Direction = normal de la 1ere face de la selection

		myCyl = Cylinder name:"MyNewCylinder" height:-0.1 pos:myObj.pos dir:myDir isSelected:true sides:12
		
		myObj.rotation = (quat 0 0 0 1)
		pda_RotatePivotOnly myObj myCyl.rotation
		ResetXForm myObj
		myRad1 = abs(myObj.max.x - myObj.min.x ) * 0.5
		myRad2 = abs(myObj.max.y - myObj.min.y ) * 0.5
		if myRad2 > myRad1 then myCyl.radius = myRad2 else myCyl.radius = myRad1

		delete myObj



-----------------

/*

		max scale
		toolMode.transformCenter()
		setRefCoordSys #local
		max move
		toolMode.transformCenter()
		setRefCoordSys #local
		max rotate
		toolMode.transformCenter()
		setRefCoordSys #local
		--maxOps.pivotMode = #pivotOnly

*/
	)


)
