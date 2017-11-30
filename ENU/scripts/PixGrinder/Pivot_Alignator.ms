---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Pivot Alignator --
-- Pivot_Alignator.ms --
-- Align 1 object's pivot to one clicked normal --
-- V 5.0 --
-- Added Orientation as final step --
-- Removed  QueryBox for objects normals inversion --
-- Mail : pixgrinder@gmail.com --

---------------------------------------------------------------------

-- WARNING !! : May cause issues on animated objects !!! --
-- WARNING !! : May cause issues in animated hierarchies !!! --

---------------------------------------------------------------------



(
	-- clearListener()
	try (delete pda_dum) catch ()

	rollout myAngleRollout "Pivot Angle"
	(
		label myLbl "Pivot Angle :" offset:[0,10]
		spinner myAngleSpinner range:[-1.0,1.0,0.0] scale:0.01 type:#float align:#center fieldwidth:150 offset:[0,7]
		button myAngleOk "OK" width:75 offset:[0,7]

		on myAngleOk pressed do destroyDialog myAngleRollout
		on myAngleSpinner changed state do 
		(
			in coordsys local pda_dum.rotation.z = myAngleSpinner.value
			myAngleSpinner.value = 0.0
-- 			pda_dum.rotation = myAngleSpinner.value
		)
	)



	if selection[1] == undefined then 
	(
		messageBox "You must have a Geometry object selected..." title:"Warning of the Dead" beep:true
	) 
	else
	(
		
		pda_cur = selection[1]
		pda_par = pda_cur.parent
		pda_bkFace = pda_cur.backFaceCull
		if pda_cur.children.count !=0 then 
		(
			pda_chil = for ite in pda_cur.children collect ite
			for bla in pda_chil do bla.parent = undefined
		)
		sZ = (distance pda_cur.max pda_cur.min)/5
		pda_dum = point name:"Avirer" box:false constantscreensize:false axistripod:true size:sZ isselected:true
		fn get_normal_function_Ins msg ir obj faceNum shift ctrl alt =
		(
			if msg == #freeMove then
			(
				if ir != undefined then
				(
					pda_dum.pos = ir.pos 
					pda_dum.dir = ir.dir
					return #continue
				)
				else(return #continue)
			)
			
	-- 				if msg == #mousePoint then
	-- 				(
	-- 					return #end
	-- 				)
			
			
			if msg == #mouseAbort then 
			(
				delete pda_dum
				pda_dum = undefined
				return #end
			)
		)


		fn pda_RotatePivotOnly obj rotation= 
		( 
			local rotValInv=inverse (rotation as quat)
			animate off in coordsys local obj.rotation*=RotValInv
			obj.objectoffsetrot*=RotValInv
			obj.objectoffsetpos*=RotValInv
		)
			
			
		if superclassof pda_cur ==  GeometryClass then
		(
			mouseTrack  on:pda_cur trackCallBack:get_normal_function_Ins
		) 
		
		if pda_dum != undefined do
		(
			-- pda_cur.parent = pda_dum
			-- select pda_dum
			createDialog myAngleRollout 250 100 1000 250 modal:true
			pda_cur.parent = undefined
			pda_cur.pivot = pda_cur.center
			pda_cur.backFaceCull = true
			resetXForm pda_cur
			redrawViews()
-- 			if querybox("Invert Normals ?") == true then 
-- 			(
-- 				myMod = (Normalmodifier ())
-- 				myMod.flip = true
-- 				myMod.unify = true
-- 				addModifier pda_cur myMod
-- 			)
			pda_cur.pivot = pda_dum.transform.position
			pda_RotatePivotOnly pda_cur pda_dum.transform.rotation
			delete pda_dum
			pda_cur.parent = pda_par
			if pda_chil != undefined then for obj in pda_chil do obj.parent = pda_cur
			collapseStack pda_cur
			pda_cur.backFaceCull = pda_bkFace
			select pda_cur
			max rotate
			toolMode.transformCenter()
			setRefCoordSys #local
			max scale
			toolMode.transformCenter()
			setRefCoordSys #local
			max move
			toolMode.transformCenter()
			setRefCoordSys #local
		)
	) 
)

