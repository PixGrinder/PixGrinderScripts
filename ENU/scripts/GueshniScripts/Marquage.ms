(
	--tableau en conivence avec la liste de presets: [longueur, intervalle, largeur] -> Chaque preset correspond à celui qui à la meme place dans la liste de preset 
	PresetVoirieArray=#([0,0,0.22], [0,0,0.5], [3,10,0.22], [1.5,5,0.22], [6,6.5,0.45], [3,3.5,0.22], [0.5,0.5,0.5], [0.5,0.5,0.15], [3,1.33,0.22], [20,6,0.22], [39,13,0.22], [0.5,0.5,0.1], [0.5,0.5,2.5])
	
try(destroyDialog LIGNES_params)catch()
	Rollout LIGNES_params "Marquage"
	(
		group "Presets"
		(
			--liste des presets: ajouter à la suite ou supprimer un élément -> AJOUTER ou SUPPRIMER ses valeurs dans le tableau PresetVoirieArray (8e ligne du code)
			dropDownList ddl1 "Normes voiries" width:250 items:#("Ligne continue", "STOP", "T1: Ligne discontinue sur voie rapide", "T'1: Ligne discontinue en zone urbaine", "T2: Voie d'insertion / de décélération", "T2: Ligne de rive", "T'2: Cédez le passage", "T'2: Cédez le passage sur feu", "T3: Ligne de dissuasion", "T'3: B.A.U. Bretelles", "T4: B.A.U.", "Pointillé parking", "Passage piéton")
		)
		
		fn dilate_pl plo ecart =
		(
			local ns = splineshape()
			for spl = 1 to plo.numsplines do
				(
				local nk = numknots plo spl 
				addnewspline ns
				local old_vec = [0,0,0]
				for i = 1 to nk-1 do
				(
				local a = getknotpoint plo spl i
				local b = getknotpoint plo spl (i+1)
				local ab = b-a
				local nv = normalize (cross [0,0,1] ab)
				local new_vec = nv
				local pointA = a+(old_vec*ecart)
				local pointB = a+(new_vec*ecart)
				local AB = distance pointA pointB
				nv = normalize (nv + old_vec)
				if i == 1 or AB == (2*abs(ecart))  then local L = ecart else local L = (ecart/abs(ecart))*((2*(ecart^2))/sqrt((4*(ecart^2))-(AB^2)))
				local np = a+(nv*L)
				old_vec = new_vec
				addknot ns spl #corner #line  np
				)
				local a = getknotpoint plo spl nk
				local np = a +(old_vec*ecart)
				addknot ns spl #corner #line  np
				)
			updateshape ns
			return ns
		)
		fn faireMarquage Sp =
		(
			for splineNb = 1 to numsplines Sp do
			(
			if isclosed Sp splineNb then
			(
 			open Sp splineNb
			addknot Sp splineNb #corner #line (getknotpoint Sp splineNb 1)
			updateshape Sp
			)
			local SpOrg = getseglengths Sp splineNb byvertex:true cum:true
			local NvOrg = numknots Sp splineNb 
			local Vtab = #()
			for i = (NvOrg+1) to (NvOrg*2) do append Vtab SpOrg[i]
			SpOrg = undefined
			local Gint = getuserprop Sp "LIGNES_Intervalle"
			local Glong = getuserprop Sp "LIGNES_Longueur"
			if Gint == 0 then Glong = curvelength Sp SplineNb
			local newMarq = splineShape ()
			LIGNES_params.lab2.text = "Spline Courante  : Modélisation"
			local pk = 0
			local n = 1
			local nSp = 1
				while pk < (CurveLength Sp splineNb) do
				(
				LIGNES_params.pg2.value = (pk*100.0)/(CurveLength Sp splineNb )
				addnewspline newMarq
				addknot newmarq nSp #corner #line (interpCurve3D Sp splineNb  ((pk)/(CurveLength Sp splineNb )))
					while  n < vtab.count and vTab[n]<(pk+Glong) do
					(
					if vTab[n]>pk then addknot newmarq nSp #corner #line (interpCurve3D Sp splineNb  ((vTab[n])/(CurveLength Sp splineNb )))
					n+=1
					)
				addknot newmarq nSp #corner #line (interpCurve3D Sp splineNb  ((pk+Glong)/(CurveLength Sp splineNb )))
				pk += (Glong+Gint)
				nSp += 1
				updateshape newmarq
				)
				LIGNES_params.pg2.value = 100
			local Mark = dilate_pl newmarq ((getuserprop Sp "LIGNES_Largeur")/2)
			local borddroit = dilate_pl newmarq (-(getuserprop Sp "LIGNES_Largeur")/2)
			addandweld Mark borddroit 0.01
			nsp = Mark.numsplines/2
			n=0
			for i = 1 to nsp do
				(
					For j = 1 to (numknots Mark i) do
					(
					n += 1
					addnewspline Mark
					addknot Mark ((nSp*2)+n) #corner #line (getknotpoint Mark i j)
					addknot Mark ((nSp*2)+n) #corner #line (getknotpoint Mark (i+nsp) j)
					updateshape Mark 
					)	
				)
			addmodifier Mark (surface threshold:0 steps:0 flipnormals:true)
			addmodifier Mark (normalModifier flip:on)
			converttopoly Mark
			if Gint ==0 then Mark.name = "Marquage Continu" else Mark.name = "Marquage "+gLong as string+"m/"+Gint as string+"m"
			LIGNES_params.lab2.text = "Spline Courante : Texturation"
			local mapchann = 1
			polyop.setmapsupport Mark mapchann true
			polyop.setnummapverts Mark mapchann Mark.numverts
			local face = 1	
				for elmt = 1 to newmarq.numsplines do
				(
				local knotTab = getseglengths newmarq elmt byverts:true cum:true
				local UVTab = #()
				append UVtab 0
				for i = (((knotTab.count as float-1)/2)+1) to (knotTab.count-1) do append UVTab (knotTab[i]/getuserprop Sp "LIGNES_kU")
				local ftab = (polyop.getelementsusingface Mark face) as array
				local verts = #()
					for f in ftab do
					(
						for ver in polyop.getfaceverts Mark f do
						(
						if finditem verts ver == 0 then append verts ver
						)
					)
				sort verts
				for i in verts do
						(	
						local v = if i <= (Mark.numverts/2) then 0 else 1
						local j = (i - (amin verts))+1
						local u = if i <= (Mark.numverts/2) then UVTab[j] else UVTab[j-(Mark.numverts/2)]
						polyop.setmapvert Mark mapchann i [u,v,0]
						)
				LIGNES_params.pg2.value = (face*100.0)/(polyop.getnumfaces Mark)
				LIGNES_params.lab2.text = "Spline Courante"
				face = amax ftab
				face += 1
				)
			delete newmarq
			LIGNES_params.pg2.value = 0	
			LIGNES_params.pg3.value = (SplineNb*100.0)/(numsplines Sp)
			)
			LIGNES_params.pg3.value = 0
		)
		
		group "Assignation"
		(
		Spinner Glongueur "Longueur" range:[0,100,10] type:#float
		Spinner Ginterval "Intervalle" range:[0,100,3] type:#float
		Spinner Glargeur "Largeur" range:[0,500,0.22] type:#float
		Spinner Gku "Longueur Texture (m)" range:[0,100,2] type:#float
		Button Gassigne "Assigner"
		)
		group "Génération"
		(
		Button Ggener "Générer"
		)
		group "Progression"
		(
		label lab1 "Ensemble"
		progressbar PG1
		label lab3 "Objet Courant"
		progressbar PG3 
		label lab2 "Spline Courante"
		progressbar PG2 
		)
		
		on ddl1 selected sel do
		(
			Glongueur.value = PresetVoirieArray[sel].x
			Ginterval.value = PresetVoirieArray[sel].y
			Glargeur.value = PresetVoirieArray[sel].z
		)
		
		on Gassigne pressed do
		(
		for obj in selection do
			(
				if superclassof obj == shape then
				(
				setuserprop obj "LIGNES_Longueur" Glongueur.value
				setuserprop obj "LIGNES_Intervalle" Ginterval.value
				setuserprop obj "LIGNES_Largeur" Glargeur.value
				setuserprop obj "LIGNES_kU" Gku.value
				)
				else messagebox (obj.name + " n'est pas un axe valide")
			)
		)
		on Ggener pressed do 
		(
			local objCount = 0
			local YesCount = 0
			local NoCount = 0
			for obj in selection do 
			(
			objCount += 1
			if getuserprop obj "LIGNES_Longueur" == undefined or getuserprop obj "LIGNES_Intervalle" == undefined or getuserprop obj "LIGNES_Largeur" == undefined or getuserprop obj "LIGNES_kU" == undefined then 
				(
				messagebox ("Erreur d'assignation sur objet : "+obj.name+"\n \n Effectuez une nouvelle assignation")
				Nocount += 1
				)
				else
				(
				try (faireMarquage obj ; YesCount += numsplines obj) catch (messagebox ("Erreur lors du traitement de : "+ obj.name); Nocount += 1)
				)
			pg1.value = (objCount*100.0)/selection.count
			)
			pg1.value = 0
			messageBox ("Traitement terminé. \n \n" + YesCount as string +" objet(s) générés. \n \n" + NoCount as string +" objets non traités.")
		)
	)
-- 	try (closerolloutfloater floatLIGNES) catch () 
-- 	floatLIGNES = newrolloutfloater "LIGNES" 300 430 10 10
-- 	addrollout LIGNES_params floatLIGNES
createDialog LIGNES_params 300 430 pos:[140,210] -- bgcolor:(color 84 101 120)  fgcolor:(color 248 113 45)
) 