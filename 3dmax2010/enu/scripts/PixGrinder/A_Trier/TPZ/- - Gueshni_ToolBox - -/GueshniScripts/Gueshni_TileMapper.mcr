macroScript TileMapper category:"- Gueshni -" Icon:#("g9_tilemapper", 1) tooltip:"Tile Mapper"
 (
	rollout TileMapper "Paramètres"
(
	---------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------
	
	-- VARIABLES GLOBALES
	
	global Long_U
	
	---------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------
	
	-- FONCTIONS
		
	---------------------------------------------------------------------------------------------------------------------------
	
	fn arete_ortho obj pt ar = -- Sur un poly formé de quads, en considerant les aretes d'un point situé en bordure (2 ou 3 aretes), renvoie l'arete non-ouverte ou l'arete qui n'est pas "ar"
	(
	ar_tab = polyop.getedgesusingvert obj pt as array
	aretes_ouvertes = polyop.getopenedges obj as array
	if ar_tab.count ==2 then (if ar == ar_tab[1] then return ar_tab[2] else return ar_tab[1])
	if ar_tab.count ==3 then 
		(
		for i = 3 to 1 by -1 do
			(
			a = ar_tab[i]	
			if ((finditem aretes_ouvertes a)!=0) then deleteitem ar_tab i 
			)
			return ar_tab[1]
		)
	if ar_tab.count <2 or ar_tab.count >3 then return undefined
	)
	
	---------------------------------------------------------------------------------------------------------------------------
	
	fn arete_opp obj pt ar = --  Sur un poly formé de quads, renvoie l'arret opposée à "ar", par rapport au point "pt"
	(
	ar_tab = polyop.getedgesusingvert obj pt as array
	aretes_ouvertes = polyop.getopenedges obj as array
	
	if ar_tab.count == 2 then -- dans un coin, renvoie l'arete qui n'est pas "ar"
		(
		--if ar == ar_tab[1] then return ar_tab[2] else return ar_tab[1]
		return undefined
		)	
	
	if ar_tab.count == 3 then -- sur une bordure alors...
		(
			if ((finditem aretes_ouvertes ar)==0) then return undefined -- si "ar" n'est pas ouverte, il n'y a pas d'arete opposée
			else -- si "ar" est ouverte, alors renvoie l'autre arete ouverte
			(
				for i = ar_tab.count to 1 by -1 do
					(
					a = ar_tab[i]	
					if a == ar then deleteitem ar_tab i
					if ((finditem aretes_ouvertes a)==0) then deleteitem ar_tab i
					)
				return ar_tab[1]
			)	-- end else
		)
		
	if ar_tab.count == 4 then -- sur un point à l'interieur de la surface, renvoie l'arete qui n'a aucune face en commun avec "ar"
		(
		for i = 4 to 1 by -1 do
			(
			faces_old = polyop.getfacesusingedge obj ar as array
			a = ar_tab[i]
			faces_test = polyop.getfacesusingedge obj a as array
			indic = true
			for j = 1 to 2 do
				(
				if  finditem faces_old faces_test[j] != 0 then indic= false 
				)
			if indic == false then deleteitem ar_tab i
			)
			return ar_tab[1]
		)
	)-- end fn
		
	---------------------------------------------------------------------------------------------------------------------------
	
	fn point_opp obj ar pt = -- etant donnés une arete et un point, si le point appartient à l'arete alors renvoie l'autre sommet de l'arete, sinon revoie "indefini"
	(
	pt_tab = polyop.getvertsusingedge obj ar as array
	if finditem pt_tab pt == 0 then
		(
		return undefined
		)
		else 
		(
		if finditem pt_tab pt == 1 then return pt_tab[2] else return pt_tab[1]
		)-- end else
		
	)
		
	---------------------------------------------------------------------------------------------------------------------------
	
	fn est_un_coin obj pt = -- determine si un sommet se trouve sur un coin d'une surface formée de quad
	(
	return (polyop.getfacesusingvert obj pt as array).count == 1 -- vrai si le sommet n'a qu'une seule face
	)
		
	---------------------------------------------------------------------------------------------------------------------------
	
	fn trouver_un_coin obj = -- parcours les sommets jusqu'a en trouver un qui verifie la condition "est_un_coin"
	(
	n = obj.numverts
	indic = false
	cpt = 0
	while indic == false and cpt < n do
		(
		cpt+=1	
		if est_un_coin obj cpt then indic = true	
		)
	if indic == true then return cpt else return undefined -- est-ce qu'on a trouvé un point (si oui, lequel?) ou pas?
	)
	
	---------------------------------------------------------------------------------------------------------------------------
	
	fn est_un_bord obj pt = -- determine si un point se truove en bordure de surface
	(
		return (polyop.getfacesusingvert obj pt as array).count == 2 -- vrai si le sommet n'appartient qu'à 2 faces
	)
	---------------------------------------------------------------------------------------------------------------------------

	fn trouver_un_bord obj = -- recherche un sommet placé en bordure de surface
	(
		n = obj.numverts
	indic = false
	cpt = 0
	while indic == false and cpt < n do
		(
		cpt+=1	
		if est_un_bord obj cpt then indic = true	
		)
	if indic == true then return cpt else return undefined -- est-ce qu'on a trouvé un point (si oui, lequel?) ou pas?
	)
	
	---------------------------------------------------------------------------------------------------------------------------

	fn ouvrir_surface obj = -- découpe une serie d'aretes pour transformer une surface bouclée en surface ouverte.
	(

	Local pt = trouver_un_bord obj -- on part d'un point sur un bord
	Local ar = arete_ortho obj pt (((polyop.getedgesusingvert obj pt) as array)[1]) -- on cherche son arete interieur, celle qui n'est pas ouverte
	Local ar_a_rompre = #()
	
	while ar != undefined do -- tant qu'on trouve une arete...
		(
		append ar_a_rompre ar -- ... on l'ajoute à la liste des aretes a rompre
		
		pt = point_opp obj ar pt
		ar = arete_opp obj pt ar -- On avance de points en arete opposées
	
		)
		
	polyop.splitedges obj ar_a_rompre -- On rompt toutes la aretes colectionées.
	
	)
	
	---------------------------------------------------------------------------------------------------------------------------
	
	fn normaliser_tab tab = -- divise tous les elements d'un tableau par la valeur maximale du tableau
	( 
		for i = 1 to tab.count do
			(
		
			p = tab[i]
			q = amax  tab
			tab[i] = p/q
			)
	)	
	---------------------------------------------------------------------------------------------------------------------------
	
	fn creer_coef_U obj crsp =
	(
	
	local Coef_U=#()
	local d=#()
	Local n = crsp.count
	Local Long_V = n/long_U

	d[1] = 0
	for i = 1 to long_V do
		(
		for j = 2 to long_U do
			(
			Local p1 = finditem crsp (((i-1)*long_U)+j-1) 
			Local p2 = finditem crsp (((i-1)*long_U)+j)
			d[j] = d[j-1] + distance (polyop.getvert obj p1) (polyop.getvert obj p2) -- ... on enregistre les longueurs cumulées de chaque arete
			)
			
		normaliser_tab d -- Puis on ramene tout sur 1
			for k = 1 to d.count do -- On ajoute Long_U éléments au tableau	coef_U
			(
			append Coef_U d[k] 
			)	
		d = #() -- preparation pour ligne suivante
		d[1] = 0
		)
		
	return Coef_U
	)
	
	---------------------------------------------------------------------------------------------------------------------------
	
	fn creer_coef_V obj crsp =
	(
	
	local Coef_V=#()
	local d=#()
	Local n = crsp.count
	Local Long_V = n/long_U
	

	d[1] = 0

	for i = 1 to long_U do
		(
		for j = 2 to long_V do
			(
			Local p1 = finditem crsp (((j-2)*long_U)+i) 
			Local p2 = finditem crsp (((j-1)*long_U)+i)
 
			d[j] = d[j-1] + distance (polyop.getvert obj p1) (polyop.getvert obj p2) -- ... on enregistre les longueurs cumulées de chaque arete
		
			)
		normaliser_tab d -- Puis on ramene tout sur 1
		for k = 1 to d.count do -- On ajoute Long_V éléments au tableau	coef_V
			(
			Coef_V[i+((k-1)*long_u)] = d[k] -- mais pas dans le même ordre que pour remplir le tableau coef_U
			)
		
		d = #() -- preparation pour ligne suivante
		d[1] = 0	
		)
	
		
	return Coef_V
	)
	

	---------------------------------------------------------------------------------------------------------------------------
	
	fn creer_tab_correspondances surface_quad = --cree un tableau linéaire qui associe à chaque sommet de la surface un indice de texture vertex
	(
	Local tab_corresp = #() -- initialisation
	Local pt_depart = trouver_un_coin surface_quad
	Local flag = false
	if pt_depart == undefined then -- si on ne trouve pas de coin, alors la selection est bouclée. Il faut l'ouvir en rompant des aretes.
	 (
	 ouvrir_surface surface_quad 
	 pt_depart = trouver_un_coin surface_quad -- maintenant que la selection est ouverte, on peut trouver un coin
	 flag = true
	 ) 	
	Local ar_depart = (polyop.getedgesusingvert surface_quad pt_depart as array)[1]
	Local ar_reserve = (polyop.getedgesusingvert surface_quad pt_depart as array)[2]
	Local pt_reserve = point_opp surface_quad ar_reserve pt_depart
	
	Local pt_courant = pt_depart -- etat initial
	Local ar_courante = ar_depart
	Local compt = 1
	Local indic = false
	
	while compt <= surface_quad.numverts do 
	(
	tab_corresp[pt_courant]=compt -- affect l'indice du TV au point courant
	compt += 1 -- l'indice des TV croit à chaque itération
	
	nv_pt = point_opp surface_quad ar_courante pt_courant -- avance d'un sommet en suivant l'arete courante
	nv_ar = arete_opp surface_quad nv_pt ar_courante -- prend l'arete suivante, s'il y en a une
	
	if nv_ar == undefined then -- S'il n'y a pas d'arete suivante, alors c'est qu'on arrive au bout d'une ligne
		(
		if indic == false then (long_U = compt;indic=true) -- à la fin de la première ligne, le nombre d'iterations atteint donne une des longueur en quads du maillage
		tab_corresp[nv_pt]=compt -- on fini la ligne en affectant l'indice du TV (déjà incrémenté) au nouveau point
		compt += 1 -- puisqu'on a créé un point, on compte une itération de plus
		nv_pt = pt_reserve -- on repart en debut de ligne suivante
		if ar_reserve != undefined and pt_reserve!=undefined then 
		(
		nv_ar = arete_ortho surface_quad pt_reserve ar_reserve
		nv_ar_reserve = arete_opp surface_quad nv_pt ar_reserve
		)
		else nv_ar = nv_pt = undefined
		if nv_ar_reserve != undefined then nv_pt_reserve = point_opp surface_quad nv_ar_reserve nv_pt
		pt_reserve = nv_pt_reserve
		ar_reserve = nv_ar_reserve		
		)
		pt_courant = nv_pt -- préparation pour l'itération suivante
		ar_courante = nv_ar
	)
	return #(tab_corresp,flag) -- renvoie le tableau linéaire de correspondances, et indique si la selection etait bouclée et a été ouverte.
	)-- end fn creer_tab_correspondances
	
	---------------------------------------------------------------------------------------------------------------------------
	
	fn creer_tv obj map_chann U V rot bu bv ru rv decalu decalv mt cu cv = -- crée les TV pour un carré idéal de U*V sommets
	(
	polyop.setmapsupport obj map_chann true
	ntv = obj.numverts
	polyop.setnummapverts obj map_chann ntv

	
	case mt of -- en fonction du type de plaquage, uniforme ou par quad
	(
		1:( -- plaquage uniforme
				for cnt_tv  = 1 to (U*V)  do
					(					
						p = decalv + ((cv[cnt_tv])*rv)
						q = decalu + ((cu[cnt_tv])*ru)
						
						if bv then p=-p -- bascule en V						
						if bu then q=-q -- bascule en U
											
							case rot of
							(
							 1:(polyop.setmapvert obj map_chann cnt_tv [p,q,0])
							 2:(polyop.setmapvert obj map_chann cnt_tv [q,-p,0])
							 3:(polyop.setmapvert obj map_chann cnt_tv [-p,-q,0])
							 4:(polyop.setmapvert obj map_chann cnt_tv [-q,p,0])
							)
						
					)
			)
		
		2:( -- plaquage par quads
				cnt_tv = 0
				for i = 1 to V  do
					(
					p = decalv + ((i-1 as float)/rv )	
					if bv then p=-p -- bascule en V
					
					for j = 1 to U  do
						(
				
						q = decalu + ((j-1 as float)/ru)		
						if bu then q=-q -- bascule en U
						
						cnt_tv += 1
						
							case rot of
							(
							 1:(polyop.setmapvert obj map_chann cnt_tv [p,q,0])
							 2:(polyop.setmapvert obj map_chann cnt_tv [q,-p,0])
							 3:(polyop.setmapvert obj map_chann cnt_tv [-p,-q,0])
							 4:(polyop.setmapvert obj map_chann cnt_tv [-q,p,0])
							)
						)
					)
			)
		)
	)
		

	---------------------------------------------------------------------------------------------------------------------------	
	
	fn plaquer_les_faces obj map_chann tab_corresp = -- Map chaque face en fonction du tableau des correspondances
	(
	polyop.setnummapfaces obj map_chann (polyop.getnumfaces obj) keep:false
	for f = 1 to (polyop.getnumfaces obj) do
		(
		vert_tab = (polyop.getfaceverts obj f) as array
		tv_tab = #()
		for v in vert_tab do
			(
			tv = tab_corresp[v]
			append tv_tab tv
			)
		polyop.setmapface obj map_chann f tv_tab
		)
	)
	
	---------------------------------------------------------------------------------------------------------------------------
	
	fn nom_unique = -- renvoie un nom d'objet unique dans la scène
	(
	nom = "toto"
	while getnodebyname nom != undefined do -- Tant qu'on trouve un objet appelé "nom"
	(
	nom  += random 1 10 as string -- alors on rajoute un chiffre aléatoire à la fin du nom.
	)
	return nom
	)
	
	fn souder obj = 
	(
	obj.weldthreshold = 0.001
	polyop.weldvertsbythreshold obj obj.verts
	)
	---------------------------------------------------------------------------------------------------------------------------	

	fn isoler_selection_faces obj = -- detache les faces selectionées, s'il y en a
	(
	a_decouper = (polyop.getfaceselection obj) as array
	if a_decouper.count == 0 then -- Si aucune face n'est selectionnée...
		(
		return obj -- ...on garde l'objet entier.
		)
 		else
		(
		lenom = nom_unique ()
		polyop.detachfaces obj a_decouper delete:true asnode:true name:lenom-- Pas moyen de recuperer le noeud...
		new_surf = getnodebyname lenom -- ...autrement que par son nom.
		return new_surf
		)
	)
	
	---------------------------------------------------------------------------------------------------------------------------	

	fn 	rattacher_selection obj1 obj2 =
	(
	polyop.attach obj1 obj2
	souder obj1
	)
	
	---------------------------------------------------------------------------------------------------------------------------	

	fn affecter_ID obj id =
	(
	polyop.setfacematID obj obj.faces id
	
	)
	
	---------------------------------------------------------------------------------------------------------------------------
	
	fn conversion_en_poly obj = -- Converti un objet en poly... 
	(
	if classof obj != Editable_Poly then -- ... si besoin est.
		(
		if subobjectlevel == 4 then -- Si la sélection de faces est active...
			(
			converttopoly obj
			subobjectlevel = 4 -- ... alors on réactive la sélection de faces après la conversion.
			)
		else
			(
			converttopoly obj
			)
		)	
	)
	---------------------------------------------------------------------------------------------------------------------------
	
	fn plaquage_topologique rota basu basv idyes idval repetu repetv decalu decalv maptype =
	(
		try
		(
			if (getcurrentselection()).count == 1  then -- s'il n'y a qu'un seul objet dans la selection.
			(
				conversion_en_poly $ -- converti un obj en poly en gardant la selection de face active si elle est active.
				surface_origine = $
				if subobjectlevel == 4 then surf_temp = isoler_selection_faces surface_origine else surf_temp = surface_origine -- detache la selection de faces si elle est active, sinon, on travaille sur l'objet initial.
			
				retour = creer_tab_correspondances surf_temp -- creé le tableau des correspondances entre les sommets réels et leur position topologique
				corresp = retour[1]
				souder_oui = retour[2] -- indique que,  si la selection était bouclée, il faudra ressouder les aretes qui ont été ouvertes.
				
				coef_U = creer_coef_u surf_temp corresp
				coef_V = creer_coef_V surf_temp corresp
				
				creer_tv surf_temp 1 (long_U) (surf_temp.numverts/long_U) rota basu basv repetu repetv decalu decalv maptype coef_U coef_V -- crée des coordonées de mapping pour un carré segmenté régulièrement
				plaquer_les_faces surf_temp 1 corresp -- mappe chaque face en fonction de sa topologie locale et du tableau de correspondance des sommets
				if idyes then affecter_ID surf_temp idval -- Affect les ID materiaux
			
				if surface_origine == surf_temp and souder_oui then souder surf_temp  -- si on a travaillé sur tout l'objet et que la surface était bouclée
				if surface_origine != surf_temp then rattacher_selection surface_origine surf_temp -- ratache la selection si elle a été détachée
				redrawViews ()
				gc()
			)
		)
		
		catch
		(
		if surface_origine != surf_temp then rattacher_selection surface_origine surf_temp -- rattache la selection si elle a été détachée
		redrawViews ()
		messagebox "Sélection invalide"
		)
	)
	
	---------------------------------------------------------------------------------------------------------------------------	
	---------------------------------------------------------------------------------------------------------------------------
	
	-- ELEMENTS IHM
	Group "Type de plaquage"
	(
	radiobuttons type_plaquage labels: #("Uniforme","Par Quad") default:1
	)
	Group "Rotation"
	(
	radiobuttons rotationtype labels: #("0°","90°","180°","270") default:1
	)
	Group "Basculer"
	(
	checkbox basc_U "Basculer U" across:2 align:#center
	checkbox basc_V "Basculer V" align:#center
	)
	Group "Répetition"
	(
	spinner repetu "U" range:[0,10000,1] type:#float across:3  align:#right fieldWidth:30 offset:[-5,0]
	spinner repetv "V" range:[0,10000,1] type:#float  align:#right fieldWidth:30 offset:[-5,0]
	button flipit "Inverser"  align:#right offset:[0,-3]
	)
	Group "Décalage"
	(
	spinner decalageu "decal_U" range:[-10000,10000,0] type:#float width:60 across:2 align:#right offset:[-5,0]
	spinner decalagev "decal_V" range:[-10000,10000,0] type:#float width:60  align:#right offset:[-5,0]
	)
	group "Matériaux"
	(
	checkbox idon "Affecter ID matériau" checked:false align:#center 
	spinner idmat "ID:"range:[1,1000,1] type:#integer align:#center width:40 enabled:false
	)
	button doit "Plaquer"
	
	---------------------------------------------------------------------------------------------------------------------------	
	---------------------------------------------------------------------------------------------------------------------------
	
	-- GESTIONAIRES D'EVENEMENTS
	
	on doit pressed do
		(
		plaquage_topologique rotationtype.state basc_U.checked basc_V.checked idon.checked idmat.value repetu.value	repetv.value decalageu.value decalagev.value type_plaquage.state
		)
		
	on idon changed state do
		(
		idmat.enabled = state
		)
		
	on basc_U changed state do
		(
		plaquage_topologique rotationtype.state basc_U.checked basc_V.checked idon.checked idmat.value repetu.value	repetv.value decalageu.value decalagev.value type_plaquage.state
		)
		
	on basc_V changed state do
		(
		plaquage_topologique rotationtype.state basc_U.checked basc_V.checked idon.checked idmat.value repetu.value	repetv.value decalageu.value decalagev.value type_plaquage.state
		)
		
	on flipit pressed do
		(
		a=repetu.value
		repetu.value=repetv.value
		repetv.value=a
		plaquage_topologique rotationtype.state basc_U.checked basc_V.checked idon.checked idmat.value repetu.value	repetv.value decalageu.value decalagev.value type_plaquage.state
		)
		
	on rotationtype changed state do
		(	
		plaquage_topologique rotationtype.state basc_U.checked basc_V.checked idon.checked idmat.value repetu.value	repetv.value decalageu.value decalagev.value type_plaquage.state
		)
		
	on type_plaquage changed state do
		(	
		plaquage_topologique rotationtype.state basc_U.checked basc_V.checked idon.checked idmat.value repetu.value	repetv.value decalageu.value decalagev.value type_plaquage.state
		)

	---------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------
	
) -- end rollout

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

Float_TileMapper = newrolloutfloater "Tile Mapper" 220 357 5 80
addrollout TileMapper Float_TileMapper
)