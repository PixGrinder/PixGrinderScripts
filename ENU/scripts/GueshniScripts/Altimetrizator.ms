 (
	try(destroyDialog altimetrizator)catch()
	rollout altimetrizator "Altimetrizator"
-- Altimetrise une spline sur un maillage
-- Passque c'est important d'altimetriser des splines, on ne le repetera jamais assez.

-- Si des points de la splines dépassent du maillage, ils restent là où ils sont. Na.

(

-- Fonctions ----------------------------------------------------------
fn est_un_mesh obj = 
	(
	return superclassof obj == GeometryClass
	) --fin est_un_mesh
fn est_une_spline obj = 
	(
	return superclassof obj == shape
	) --fin est_une_spline

-- Variables ----------------------------------------------------------
global terrainchoisi = false
global altichoisie = false
-- Groupes IHM --------------------------------------------------------
	
Group "Terrain"
	(
	pickbutton ground "Pick a mesh ground object" filter:est_un_mesh 
	) --fin groupe terrain
Group "Mesh or Spline to altimetrize"
	(
	pickbutton line "Pick an object to Altimetrize" 
	checkbox useselection "Use Selection" checked:false align:#center
	) -- fin groupe spline
Group "Options"
	(
	spinner decalage "Z offset :" range:[-10000,10000,0] type:#float align:#center
	checkbox duplicatespline "Keep original object" checked:false
	) -- fin options
Group "Altimetrize it !"
	(
	button go "Go for it" 
	) -- fin groupe spline

-- préparation des données  --------------------------------------------
on ground picked leterrain do
	(
	ground.text = leterrain.name
	terrainchoisi = true
	) -- fin ground picked
on line picked lalti do
	(
		line.text = lalti.name
		altichoisie = true
	) -- fin line picked
on useselection	changed etat do
	(
	line.enabled = not etat
	if etat then altichoisie = ($ != undefined) 
	if (etat == false) and (line.object == undefined) then altichoisie = false
	)

-- Corps du script  (et spiritus scripti...)----------------------------
on go pressed do
(
	if terrainchoisi and altichoisie then
	(
	if useselection.checked then laselection = $ else laselection = line.object
	for obj in laselection do 
	(
	progressstart obj.name
	print ("\nAltimetrisation de " + obj.name as string +"\n")
	if superclassof obj == shape then
	(
		print "Type : SHAPE\n"
		zispline = obj
		converttosplineshape zispline
		ziground = ground.object
		-- dupliquer la spline si option choisie
		if duplicatespline.checked then 
			(
			bkpspline = copy zispline
			bkpspline.name = (zispline.name)
			zispline.name = (zispline.name + "_altimetrized")
			) -- fin dupliquer
		
		converttosplineshape zispline 
		
		nsp = numSplines zispline
		for sp = 1 to nsp do
			(
			progressupdate ((sp/nsp)*100)
			nk = numKnots zispline sp
			for i = 1 to nk do
				(
				progressupdate ((i/nk)*100)
				lepoint = getKnotPoint zispline sp i
				lepoint.z += 100000
				r = ray lepoint [0, 0, -1]
				impact = intersectRay ziground r
				if impact != undefined then
					(
					impact.pos.z += decalage.value
					setKnotPoint zispline sp i impact.pos
					)
				)
			updateshape zispline
			redrawViews ()
			) 
		print "Altimetrisation OK\n"
		) -- fin if superclass = shape
		else
		( -- class = Geometryclass
		print "Type : Geometry\n"
		ziobj = obj
		converttopoly ziobj
		ziground = ground.object
		-- dupliquer la spline si option choisie
		if duplicatespline.checked then 
			(
			bkpobj = copy ziobj
			bkpobj.name = (ziobj.name)
			ziobj.name = (ziobj.name + "_altimetrized")
			) -- fin dupliquer

			npoint = ziobj.numverts
			tabverif = polyOp.getVertSelection ziobj
			for i = 1 to npoint do
				if (finditem tabverif i) != 0 then
				(
				lepoint = polyop.getVert ziobj i
				lepoint.z += 100000
				r = ray lepoint [0, 0, -1]
				impact = intersectRay ziground r
				if impact != undefined then 
					(
					impact.pos.z += decalage.value
					polyop.setVert ziobj i impact.pos
					)
				progressupdate ((100*i) / npoint) 
				)
			redrawViews ()
			) -- fin if superclass = mesh
		print "Altimetrisation " + obj.name + "OK"
		progressend ()
		)
	) -- fin if deux opérandes choisies
	else
	messagebox "Choose your ground and object(s) to altimetrize !!!" beep:true
) -- fin on go pressed

) -- fin du rollout
 
createdialog altimetrizator  width:200 height:277 pos:[140,210] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)
)