 (
try(destroyDialog Eclator)catch()
	 rollout Eclator "Eclator"
(	

	fn eclatation obj linkToDummy CenterPivot =
	(
		theName = obj.name
		if linkToDummy then myDum = dummy name:("F_"+theName) pos:obj.pos 
		cnt = 0
		
		while obj.numfaces > 0 do
			(
			cnt +=1
			elmt = polyop.getElementsUsingFace obj #(1)
			elmtName = "_exploded_"+TheName+"_"+cnt as string
			while getNodebyName elmtName != undefined do (elmtname += "#") -- nom unique
			polyop.detachFaces obj elmt delete:true asnode:true name:elmtName
			myNode = getNodeByName elmtName
			if centerPivot then myNode.pivot = myNode.center
			if linkToDummy then myNode.parent = myDum
			)
			
	delete obj
	return cnt
	) -- fin fn
	
	-----------------------------------------------------------------------------------------
	
	Group "Reglages"
	(
		checkbox centrerpivot "Centrer Pivots" checked:true
		checkbox lieradummy "Lier � Factice" checked:false
	)
	
	Group "Eclator"
	(
		button go "Go !"
	)
	
	-----------------------------------------------------------------------------------------
	on go pressed do
	(
		sel = getcurrentselection()
		compte_rendu = "" 
		if $ == undefined then compte_rendu += "Pas de selection !"
		else
		(
			for obj in sel do
				if superclassof obj == geometryclass then
				(
					converttopoly obj
					compte_rendu += (obj.name + " converti en poly\n")
	
					n = eclatation obj lieradummy.checked centrerpivot.checked
					compte_rendu += ( n as string + " objet(s) cr��(s)\n")
				) 
				else
				compte_rendu += ("\n" + obj.name + " non g�om�trique : non trait�.")
				
			format compte_rendu
		) 
	) -- fin on go pressed
	-----------------------------------------------------------------------------------------
) -- fin rollout

createDialog Eclator 200 120 pos:[140,210] bgcolor:(color 84 101 120)  fgcolor:(color 248 113 45)
)