 (
	try(destroyDialog SimplifyLine)catch()
	rollout SimplifyLine "Simplify Line"
(
-- VARIABLES

	global listPtToSup -- array of integer (list of vertices removed)


-- FUNCTIONS

	--					   ------>	
	-- retourne le vecteur pt1 pt2
	function toVect pt1 pt2 =
	(
		return(pt2-pt1)
	)
		
	-- retourne la distance au carre du point pt au segment [pt1 pt2]
	function getDistanceDrPt2 pt1 pt2 pt =
	(
		local A=(distance pt1 pt2) --float
		local B=(distance pt1 pt)  --float
		local C=(distance pt2 pt)  --float 
		local X=((C^2)+(A^2)-(B^2))/(2*A) --float
		
		return ((C^2)-(X^2))
	)	
		
	-- retourne le point milieu du segment [pt1 pt2]
	function midPoint pt1 pt2 =
	(
		return ( [(pt1.x+pt2.x)/2.0 , (pt1.y+pt2.y)/2.0 , (pt1.z+pt2.z)/2.0] )
	)
	
	-- supprime une liste de point lisPt de l'objet splineObject
	function supListPoint splineObject indexSplines listPt =
	(
		for i=1 to listPt.count by 1 do
			(deleteknot splineObject indexSplines listPt[i])
	)
	
	-- simplification locale
	function simplifyLocal splineObject indexSplines distMax2 ptToSup ptExt1 ptExt2 =
	(
		local i --integer							
		local dist,distAux --float
		local recursif=0 --integer
		local list1=#(),list2=#() --array of integer
		if ptToSup.count==0 then return 1
		dist=0.0
		for i=ptToSup.count to 1 by -1 do
		(
			distAux=getDistanceDrPt2 (getKnotPoint splineObject indexSplines ptExt1) (getKnotPoint splineObject indexSplines ptExt2) (getKnotPoint splineObject indexSplines ptToSup[i])
			if (distAux>distMax2) then 
				if (distAux>dist) then 
					(
					recursif=i
					dist=distAux
					)
		)
		
		if (recursif>0) then 
		(
			for i=1 to recursif-1 by 1 do
				list1[i]=ptToSup[i]
			for i=recursif+1 to ptToSup.count by 1 do			
				list2[i-recursif]=ptToSup[i]
			return ( (simplifyLocal splineObject indexSplines distMax2 list1 ptExt1 ptToSup[recursif]) + (simplifyLocal splineObject indexSplines distMax2 list2 ptToSup[recursif] ptExt2) )			
		)
		else 
		(
			for i=1 to ptToSup.count by 1 do
				listPtToSup[listPtToSup.count+1]=ptToSup[i]
		)	
		return 0
	)
		
	-- parcours des sommets
	function parcoursVertices distMax distEntrePoint =
	(
		local distMax2=distMax*distMax,myDistance,myDistEntrePoint --float
		local k,i,j,p,lastPtNotSup --integer
		local indexSplines=#() -- array of integer (index of splines in shape)
		local ptToSup=#(),ptToSupAux=#() --array of integer (index of vertices removed)
		local splineObject --the shape to modify 
		
		if selection.count==0 then 
		(
			print "Pas de selection !!"
			return()
		)
		undo on
		(
			for k=1 to selection.count by 1 do
			(	 
				if canconvertto selection[k] splineshape then
				(
					splineObject=selection[k]
					converttosplineshape splineObject
					indexSplines=numSplines splineObject
					for p=1 to indexSplines by 1 do
					(
						listPtToSup=#() --init var global
						ptToSup=#()
						if (numknots splineObject p)>2 then
						(
							lastPtNotSup=(numknots splineObject p)
							myDistEntrePoint=0.0
							for i=(numknots splineObject p)-1 to 2 by -1 do 		
							(
								myDistance=getDistanceDrPt2 (getKnotPoint splineObject p (i-1)) (getKnotPoint splineObject p (i+1)) (getKnotPoint splineObject p i)
								if (lastPtNotSup==(i+1)) then
									myDistEntrePoint= myDistEntrePoint + (distance (getKnotPoint splineObject p lastPtNotSup) (getKnotPoint splineObject p i))
								else
									myDistEntrePoint= myDistEntrePoint + (distance (getKnotPoint splineObject p (i+1)) (getKnotPoint splineObject p i))
								if (myDistance<=distMax2) then 
								(
									if (myDistEntrePoint<distEntrePoint) then 
										ptToSup[ptToSup.count+1]=i
									else 
									(
										lastPtNotSup=i
										myDistEntrePoint=0.0
									)
								)
								else
								(
									lastPtNotSup=i
									myDistEntrePoint=0.0
								)
							)
							j=1
							while j<=ptToSup.count do
							(
								ptToSupAux=#()
								ptToSupAux[1]=ptToSup[j]
								while (j<ptToSup.count) and ((ptToSup[j]-ptToSup[j+1])==1) do
								(
									ptToSupAux[ptToSupAux.count+1]=ptToSup[j+1]
									j=j+1
								)
								simplifyLocal splineObject p distMax2 ptToSupAux (ptToSupAux[1]+1) (ptToSupAux[ptToSupAux.count]-1)
								j=j+1
							)		
							supListPoint splineObject p listPtToSup
							updateshape splineObject
						)
					)
				)
				else print "selection ignorée"
			)
		)
	)

-- IHM

	button runSimplify "Simplify"
	spinner distMax "Decalage Max d'un point  " range:[0.0,100.0,0.0075] type:#float
	spinner distEntrePoint "Distance Max entre 2 points  " range:[0.0,100000.0,10.0] type:#float
	
	
-- EVENT

	on runSimplify pressed do
	(	
		parcoursVertices distMax.value distEntrePoint.value
	)	
)

createdialog SimplifyLine width:300 height:80 pos:[140,210] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)
)