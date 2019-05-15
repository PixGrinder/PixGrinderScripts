macroScript Veget category:"- Gueshni -" Icon:#("g9_veget", 1) tooltip:"Veget"
 (
	function altimetrize obj ground =
(
	lepoint = obj.pos 
	lepoint.z += 1000000
	r = ray lepoint [0, 0, -1]
	impact = intersectRay ground r
	if impact != undefined then 
	(
		obj.pos = impact.pos
	)

)

rollout Brosseasprite "Veget"
(
-- Variables ----------------------------------------------------------

global choix = false
global sol = false
global fils = false

-- Groupes IHM --------------------------------------------------------

	pickbutton source "Choose an object to be duplicated"
	pickbutton ground "Choose floor" across:2
	pickbutton pere "Choose parent"
	
	spinner rand_rota "Random rotation : " type:#integer range:[0,180,0]
	spinner rand_scale "Random scale : " type:#integer range:[0,100,0]
	button Go "Go"

	on source picked la_source do
	(
		source.text = la_source.name
		choix = true
	)
	
	on ground picked le_ground do
	(
		ground.text = le_ground.name
		sol = true
	)
	
	on pere picked le_pere do
	(
		pere.text = le_pere.name
		fils = true
	)

	
	on go pressed do
	(
		selection = #()
		go.text = "RightClick to finish"	
		if not choix then 
		(
			messagebox "Choose a source object"
		)
		else
		(
			escapeEnable = true
			quitter = false
			print "C'est parti"
			while not quitter do
			(
				print "pass"
				n = 1
				p=pickpoint()
				if (classof p == Point3) then
				(
					nom_source = source.object.name
					ma_node = getnodebyname nom_source
					print ma_node
					new_obj = copy ma_node
					new_obj.isSelected=true
					new_obj.wirecolor = [0,0,0]
					new_obj.name=nom_source+"_"+ n as string
					n+=1
					new_obj.pos=p
					if sol then altimetrize new_obj ground.object
					if fils then new_obj.parent = pere.object
					
					s = random -rand_scale.value rand_scale.value as float
					s = s /100.0 +1.0
					scale new_obj [1,1,s]
					r = random -rand_rota.value rand_rota.value
					rotate new_obj (eulerangles 0 0 r)
					--redrawViews()
				)
				if p==#rightClick then quitter=true
			)
			go.text="Go"
		)
	gc()
	)
)
Float_Brosseasprite = newrolloutfloater "VEGET" 200 160 5 80
addrollout Brosseasprite Float_Brosseasprite 
)