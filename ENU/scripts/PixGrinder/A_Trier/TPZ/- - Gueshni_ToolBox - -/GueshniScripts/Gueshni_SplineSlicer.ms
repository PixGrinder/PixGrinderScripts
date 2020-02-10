
 
	 global selShape, mySelection
	 
	--definition des coordonnées cartésiennes du plan d'intersection
	fn SlicePlan _Spline =
	(
		local vect_AB = getKnotPoint _Spline 1 2 - getKnotPoint _Spline 1 1
		local vect_AC = (getKnotPoint _Spline 1 1 + [0.0,0.0,10.0]) - getKnotPoint _Spline 1 1
		local l_nPlan = normalize (cross vect_AB vect_AC)
		l_nPlan
	)

	--Determine si la droite intersecte le plan de coupe
	fn isIntersecting _Plan _Vect =
	(
		if (dot _Plan _Vect) == 0 then return false else return true
	)
	
	--Calcul du point d'intersection entre le plan issu de la ligne de slice et un segment
	fn intersectPlan _nPlan _P0 _P1 _V0 =é
	(
		local w = _V0-_P0
		local u = _P1-_P0
		local l_Intersection = (dot _nPlan w) / (dot _nPlan u)
		if l_Intersection>=0.0 AND l_Intersection <= 1.0 then
			return (_P0 + l_Intersection*(_P1-_P0))
		else return undefined
	)
	
	--fonction qui slice les segments
	fn SplineSlice _sp _cutOn =
	(
		local knotDelete = #()
		local segDelete = #()
		local nbSplines = numSplines selShape
		--pour chaque splines de la shape
		for cpt=1 to nbSplines do
		(
			--récupération des segments sélectionnés
			local SegNum = getSegSelection selShape cpt
			SegDelete[cpt] = #()
			knotDelete[cpt] = #()
			--check si segment(s) sélectionné(s) dans la spline
			if SegNum != undefined do
			(
				--pour chaque segment
				for i in SegNum do
				(
					--récupération des points du segments
					local V0, P0, P1, l_Plan, l_intersectKnot
					P0 = getKnotPoint selShape cpt i
					--Pour les splines fermées le suivant du dernier est le premier
					try P1 = getKnotPoint selShape cpt (i+1) catch P1 = getKnotPoint selShape cpt 1						
					--calcul du plan d'intersection
					l_Plan = SlicePlan _sp
					V0 = getKnotPoint _sp 1 1
					--détermine d'abord si le plan et la droite ne sont pas parallèles
					if (isIntersecting l_Plan (P1-P0)) do
					(
						--calcul le point d'intersection
						l_intersectKnot = intersectPlan l_Plan P0 P1 V0
						if l_intersectKnot != undefined do
						(
							--ajout du point d'intersection sur le segment
							addknot selShape cpt #corner #line l_intersectKnot (i+1)
							append knotDelete[cpt] (i+1)
							--ajout d'un deuxieme point au même endroit puis récupération du numéro du nouveau segment si on doit breaker les sommets
							if _cutOn do
							(
								addknot selShape cpt #corner #line l_intersectKnot (i+1)
								knotDelete[cpt+nbSplines] = #()
								append knotDelete[cpt+nbSplines] 1
								append SegDelete[cpt] (i+1)
							)
						)
					)
				)
			)
		)
		
		--mise à jour de la shape dans le viewport
		updateShape selShape
		
		--breaker les sommets en supprimant l'arete centrale si demandé
		if _cutOn then
		(
			--selectionner les segments à supprimer
			for cpt=1 to nbSplines do
				(setSegSelection selShape cpt SegDelete[cpt] keep:false)
			--suppprimer les segments séletionnés
			splineops.delete selShape
		
			updateShape selShape
			
			--sélectionner les sommets créés
			nbSplines = numSplines selShape
			for cpt=1 to nbSplines do
			(
				if knotDelete[cpt] == undefined do knotDelete[cpt]=#()
				setKnotSelection selShape cpt knotDelete[cpt] keep:false
			)
		)
		else
		(
			--sélectionner les sommets et les arêtes créés
			for cpt=1 to nbSplines do
			(
				setSegSelection selShape cpt SegDelete[cpt] keep:false
				setKnotSelection selShape cpt knotDelete[cpt] keep:false
			)
		)
		
		--supprime la ligne de cut matérialisée
		delete _sp
		
		updateShape selShape
		
		--remplacer la spline sélectionnée par celle cutée
		instanceReplace mySelection selShape
		if (InstanceMgr.CanMakeObjectsUnique mySelection) do InstanceMgr.MakeObjectsUnique mySelection #individual
		--suppression de la copie
		delete selShape
		
		select mySelection
		subObjectLevel = 2
		--libérer les variables globales
		mySelection = selShape = undefined
		globalVars.remove "selShape"
		globalVars.remove "mySelection"
	)
	
	-- Creation de la ligne de slice
	tool LineCreator
	(
		local sp, p, createPoint, l_knot
		local firstClick=true
		
		--Creation de la ligne permettant le slice
		fn createSpline = 
		(
			sp = splineShape()
			addnewspline sp
			sp.wireColor = color 7 246 255
		)

		--Creation des points de la ligne
		fn createPoint = 
		(
			local _knot = addknot sp 1 #corner #line worldPoint
			_knot
		)
		
		--Definition des clicks de la souris
		on mousePoint clickno do
		(
			case clickno of
			(
				--1e Click
				1: 
				(
					createSpline()
					l_knot = createPoint()
					l_knot = createPoint()
				)
				--2e Click
				3:
				(
					local cutOn = false
					--Si la touche Shift est enfoncée, le flag pour le break des sommets est activé
					if shiftKey do cutOn = true
					stopTool LineCreator
					SplineSlice sp cutOn
				)
			)
		)
		
		-- déplacement du deuxieme sommet sous la souris entre les deux clics
		on mouseMove clickno do
		(
			setknotPoint sp 1 l_knot worldPoint
			updateshape sp
		)
		
		on mouseAbort clickno do
		(
			if sp != undefined do
				delete sp
			--suppression de la copie
			delete selShape
			mySelection = selShape = undefined
			globalVars.remove "selShape"
			globalVars.remove "mySelection"
		)
	)
	
	on execute do
	(
		--vérifie si le script est déjà entrain d'être exécuté
		if mySelection == undefined do
		(
			mySelection = selection[1]
			--vérifie si une shape est sélectionnée
			if mySelection == undefined OR superclassof mySelection != shape then
			(
				selShape = mySelection = undefined
				globalVars.remove "selShape"
				globalVars.remove "mySelection"
				messageBox "WARNING\nAucune shape sélectionnée"
			)
			else
			(
				if subObjectLevel != 2 then --on pourrait aussi tester si la selection est nulle...
				(
					selShape = mySelection = undefined
					globalVars.remove "selShape"
					globalVars.remove "mySelection"
					messageBox "WARNING\nSélectionnez des\nsegments de la spline"
				)
				else
				(
					undo "Spline Slicer" on
					(
						--récupération de la copie de la spline sélectionnée
						selShape = copy mySelection
						selShape.name = mySelection.name + "TMP_COPY"
						local tmp_layer = LayerManager.getLayerFromName "z_TMP_shapes"
						if tmp_layer == undefined do
							tmp_layer = layermanager.newLayerFromName "z_TMP_shapes"
						tmp_layer.addNode selShape
						hide selShape
						--lancer le tool de slice
						startTool LineCreator
					)
				)
			)
		)
	)
