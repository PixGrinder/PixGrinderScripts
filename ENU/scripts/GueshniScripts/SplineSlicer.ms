 (
	 global selShape, mySelection
	 
	--definition des coordonn�es cart�siennes du plan d'intersection
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
	fn intersectPlan _nPlan _P0 _P1 _V0 =
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
			--r�cup�ration des segments s�lectionn�s
			local SegNum = getSegSelection selShape cpt
			SegDelete[cpt] = #()
			knotDelete[cpt] = #()
			--check si segment(s) s�lectionn�(s) dans la spline
			if SegNum != undefined do
			(
				--pour chaque segment
				for i in SegNum do
				(
					--r�cup�ration des points du segments
					local V0, P0, P1, l_Plan, l_intersectKnot
					P0 = getKnotPoint selShape cpt i
					--Pour les splines ferm�es le suivant du dernier est le premier
					try P1 = getKnotPoint selShape cpt (i+1) catch P1 = getKnotPoint selShape cpt 1						
					--calcul du plan d'intersection
					l_Plan = SlicePlan _sp
					V0 = getKnotPoint _sp 1 1
					--d�termine d'abord si le plan et la droite ne sont pas parall�les
					if (isIntersecting l_Plan (P1-P0)) do
					(
						--calcul le point d'intersection
						l_intersectKnot = intersectPlan l_Plan P0 P1 V0
						if l_intersectKnot != undefined do
						(
							--ajout du point d'intersection sur le segment
							addknot selShape cpt #corner #line l_intersectKnot (i+1)
							append knotDelete[cpt] (i+1)
							--ajout d'un deuxieme point au m�me endroit puis r�cup�ration du num�ro du nouveau segment si on doit breaker les sommets
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
		
		--mise � jour de la shape dans le viewport
		updateShape selShape
		
		--breaker les sommets en supprimant l'arete centrale si demand�
		if _cutOn then
		(
			--selectionner les segments � supprimer
			for cpt=1 to nbSplines do
				(setSegSelection selShape cpt SegDelete[cpt] keep:false)
			--suppprimer les segments s�letionn�s
			splineops.delete selShape
		
			updateShape selShape
			
			--s�lectionner les sommets cr��s
			nbSplines = numSplines selShape
			for cpt=1 to nbSplines do
			(
				if knotDelete[cpt] == undefined do knotDelete[cpt]=#()
				setKnotSelection selShape cpt knotDelete[cpt] keep:false
			)
		)
		else
		(
			--s�lectionner les sommets et les ar�tes cr��s
			for cpt=1 to nbSplines do
			(
				setSegSelection selShape cpt SegDelete[cpt] keep:false
				setKnotSelection selShape cpt knotDelete[cpt] keep:false
			)
		)
		
		--supprime la ligne de cut mat�rialis�e
		delete _sp
		
		updateShape selShape
		
		--remplacer la spline s�lectionn�e par celle cut�e
		instanceReplace mySelection selShape
		if (InstanceMgr.CanMakeObjectsUnique mySelection) do InstanceMgr.MakeObjectsUnique mySelection #individual
		--suppression de la copie
		delete selShape
		
		select mySelection
		subObjectLevel = 2
		--lib�rer les variables globales
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
					--Si la touche Shift est enfonc�e, le flag pour le break des sommets est activ�
					if shiftKey do cutOn = true
					stopTool LineCreator
					SplineSlice sp cutOn
				)
			)
		)
		
		-- d�placement du deuxieme sommet sous la souris entre les deux clics
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
		--v�rifie si le script est d�j� entrain d'�tre ex�cut�
		if mySelection == undefined do
		(
			mySelection = selection[1]
			--v�rifie si une shape est s�lectionn�e
			if mySelection == undefined OR superclassof mySelection != shape then
			(
				selShape = mySelection = undefined
				globalVars.remove "selShape"
				globalVars.remove "mySelection"
				messageBox "WARNING\nAucune shape s�lectionn�e"
			)
			else
			(
				if subObjectLevel != 2 then --on pourrait aussi tester si la selection est nulle...
				(
					selShape = mySelection = undefined
					globalVars.remove "selShape"
					globalVars.remove "mySelection"
					messageBox "WARNING\nS�lectionnez des\nsegments de la spline"
				)
				else
				(
					undo "Spline Slicer" on
					(
						--r�cup�ration de la copie de la spline s�lectionn�e
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
)