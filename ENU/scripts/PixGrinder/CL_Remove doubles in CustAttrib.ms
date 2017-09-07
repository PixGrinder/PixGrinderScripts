-- CL - Remove doubles in CustAttrib

-- Fonction pour trier le tableau "tempNames"
fn mySort v1 v2 =  
(
	if v1[1] > v2[1] then 1 else -1
)


select (for obj in objects where CustAttributes.count obj == 1 collect obj) -- selectionner tous les objets avec custom attributes

if selection.count != 0 then
(
	for cur in selection do
	(
		t1 = cur.compLoc.hidden.count as string -- nombre d'occurences AVANT
		if t1 as integer != 0 then
		(
			tempNames = for bla in cur.compLoc.hidden collect #(bla.node.name,bla,bla.node) -- collecte des infos des entrée dans le tableau tempNames
	
			qsort tempNames mySort -- tri des données de tempNames
			theYoupla = #(tempNames[1][2]) -- Création duu tableau theYoupla contenant le 1er composant de "hidden"
	
			-- ajout des composant dans 1 nouveau tableau si le composant est unique
			for i = 2 to tempNames.count do
			(
				if tempNames[i-1][1] != tempNames[i][1] then append theYoupla tempNames[i][2]
			)
	
			t2 = theYoupla.count as string -- nombre d'occurences APRES
	
			cur.compLoc.hidden = theYoupla -- la list hidden est remplacé par le résultat de la supression des doublons
		)
	)
)


/*
clearListener()
print("Before : "+t1)
print("After : "+t2)
*/

/*
blurf = "cur.compLoc.hidden"
execute (blurf+".count")
*/

-- for obj in tempNames do print obj[1]
