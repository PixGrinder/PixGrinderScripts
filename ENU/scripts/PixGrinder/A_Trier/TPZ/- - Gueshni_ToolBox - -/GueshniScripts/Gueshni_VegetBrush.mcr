macroScript VegetBrush category:"- Gueshni -" Icon:#("g9_vegetbrush", 1) tooltip:"Veget Brush"
 (
	 on execute do
	(
		rollout params "Param�tres" width:162 height:300
(
	fn getpos ir =
	(
		local found = false
		for o in geometry do
	 	(
			if not o.ishidden and not o.isselected and (findstring o.name "Objet_brosse" != 1) then
			(
			if classof o == Editable_Poly then (addModifier o (Edit_Mesh()))
		 	vp = (inverse(getviewTM())).row4
			if (viewport.gettype() == #view_iso_user) or (viewport.gettype() == #view_persp_user) or (viewport.gettype() == #view_camera) then p = intersectray o (ray vp (ir-vp))
		 	if viewport.gettype() == #view_top then p = intersectray o (ray (ir+[0,0,10E6]) [0,0,-1])
	
		 	if p != undefined  then (found = true ;return p.pos) 
			)
	 	)
	if not found then return ir
	)
	
	tool brush
	(
		local obj = selection [random 1 selection.count]
		local objfinal = mesh()
		local lastpos = [0,0,0]
		local randR = random -params.spn2.value params.spn2.value
		local randS = 1 + ( (random -params.spn3.value params.spn3.value)/100.0 )
		local time = timestamp ()
		local locked = false
		local rand90 = (random 0 3)*90
	
		
		on freemove do
		(
		objfinal.name = uniquename "Objet_brosse_"
		converttopoly objfinal 
		polyop.deleteverts objfinal #all
		lastpos = (getpos worldpoint) + [params.spn4.value,params.spn4.value,params.spn4.value] -- d�calage pour pouvoir cr�er le premi�re copie
		if selection.count == 0 then
			(
				messagebox "S�lection vide" ; delete objfinal ; params.ckb1.state = off; #stop
			)
			else
			(
			 	if shiftkey then
				(
				locked = true
				obj.pos = [0,0,0]
				obj.rotation = eulerToQuat (EulerAngles 0 0 0)
				obj.scale = [1,1,1]
				
				i = 1+(((viewpoint.x-30) / (-30+(getviewsize()).x) ) * selection.count) as integer
				if i > selection.count then i=selection.count
				if i < 1 then i = 1
				obj = selection [i]
				)
			
				if altkey then
				(
				locked = false
				)
				
				
			obj.pos = getpos worldpoint
			

			
			) -- end else
		 
		) -- end on freemove
		
		
		on mousemove click do
		(
		
		obj.pos = getpos worldpoint
		ang = if (lastpos-obj.pos).x> 0 then acos (dot [0,1,0] (normalize (lastpos-obj.pos))) else -acos (dot [0,1,0] (normalize (lastpos-obj.pos)))
		
		if shiftkey then
		(
		locked = true
		obj.pos = [0,0,0]
		obj.rotation = eulerToQuat (EulerAngles 0 0 0)
		obj.scale = [1,1,1]
		
		i = 1+(((viewpoint.x-30) / (-30+(getviewsize()).x) ) * selection.count) as integer
		if i > selection.count then i=selection.count
		if i < 1 then i = 1
		obj = selection [i]
		
		case params.rotType.state of 
				(
				1 : (in coordsys #local ( obj.rotation = eulerToQuat (eulerangles 0 0 randR) ) )
				2 : (in coordsys #local ( obj.rotation = eulerToQuat (eulerangles 0 0 (randR+ang)) ) )
				3 : (in coordsys #local ( obj.rotation = eulerToQuat (eulerangles 0 0 (randR+rand90)) ) )
				)
				
		obj.scale = [randS,randS,randS]
		obj.pos = getpos worldpoint
		)
		
		if altkey then
		(
		locked = false
		)
	
		
		if lbutton and (distance worldpoint lastpos) > params.spn4.value and ( timestamp() > time + params.spn5.value ) and not shiftkey then
			(
			lastpos = obj.pos
			
			obj2 = copy obj
			polyop.attach objfinal obj2
			
			randR = random -params.spn2.value params.spn2.value
			randS = 1+(random -params.spn3.value params.spn3.value)/100.0
			rand90 = (random 0 3)*90
			
			
			obj.pos = [0,0,0]
			obj.rotation = eulerToQuat (EulerAngles 0 0 0)
			obj.scale = [1,1,1]
			
			if not locked then obj = selection [random 1 selection.count]
			
			
				case params.rotType.state of 
				(
				1 : (in coordsys #local ( obj.rotation = eulerToQuat (eulerangles 0 0 randR) ) )
				2 : (in coordsys #local ( obj.rotation = eulerToQuat (eulerangles 0 0 (randR+ang)) ) )
				3 : (in coordsys #local ( obj.rotation = eulerToQuat (eulerangles 0 0 (randR+rand90)) ) )
				)
			
			obj.scale = [randS,randS,randS]
			
			time = timestamp()
			
			) -- end if
		) -- end on mousemove
		
		on mousepoint click do
		( 
		if distance (getpos worldpoint) lastpos > params.spn4.value then
			(
			ang = if (lastpos-obj.pos).x> 0 then acos (dot [0,1,0] (normalize (lastpos-obj.pos))) else -acos (dot [0,1,0] (normalize (lastpos-obj.pos)))
			lastpos = obj.pos
			
			obj2 = copy obj
			polyop.attach objfinal obj2
			
			randR = random -params.spn2.value params.spn2.value
			randS = 1+(random -params.spn3.value params.spn3.value)/100.0
			
			obj.pos = [0,0,0]
			obj.rotation = eulerToQuat (EulerAngles 0 0 0)
			obj.scale = [1,1,1]
			
			if not locked then obj = selection [random 1 selection.count]
			
				case params.rotType.state of 
				(
				1 : (in coordsys #local ( obj.rotation = eulerToQuat (eulerangles 0 0 randR) ) )
				2 : (in coordsys #local ( obj.rotation = eulerToQuat (eulerangles 0 0 (randR+ang)) ) )
				3 : (in coordsys #local ( obj.rotation = eulerToQuat (eulerangles 0 0 (randR+rand90)) ) )
				)
				
			obj.scale = [randS,randS,randS]
			) -- end if
		) -- en on mousepoint
		
		on mouseabort click do
		(
		objfinal.pivot = ( (objfinal.max + objfinal.min)/2 )
		objfinal.pivot.z = objfinal.min.z
		if objfinal.numverts == 0 then delete objfinal
		params.ckb1.state = off
		for obj in selection do
			(
			obj.pos = [0,0,0]
			obj.rotation = eulerToQuat (EulerAngles 0 0 0)
			obj.scale = [1,1,1]
			) -- end for obj
		--#stop
		) -- end on mouseabort
		
	) -- end tool
	
	-- IHM
	
	checkButton ckb1 "Dupliquer" pos:[35,331] width:92 height:28
	spinner spn2 "Rotation +/-" pos:[28,253] width:96 height:16 range:[0,180,10] type:#integer
	spinner spn3 "Echelle +/-" pos:[24,285] width:96 height:16 range:[0,99,10] type:#integer
	groupBox grp1 "Chaos" pos:[4,229] width:160 height:88
	groupBox grp2 "Espacement Minimal" pos:[4,65] width:150 height:88
	spinner spn4 "Distance" pos:[25,85] width:96 height:16 range:[0,1000,10] type:#worldunits
	spinner spn5 "Delai      " pos:[24,122] width:96 height:16 range:[0,10000,100]
	label lbl1 "ms" pos:[128,123] width:16 height:16
	radiobuttons rotType "Type Orientation" Labels:#("Constante","Selon Glisser","De 90�") pos:[6,160]
	label lbl2 "deg" pos:[130,254] width:22 height:17
	label lbl3 "%" pos:[127,288] width:14 height:11
	label lbl4 "S�lectionner plusieurs objets, cliquer sur \" Dupliquer \" puis brosser en maintenant le bouton gauche enfonc�." pos:[8,6] width:150 height:53
	groupBox grp3 "Contr�les clavier" pos:[4,370] width:150 height:110
	label lbl5 "Shift + Glisser pour changer manuellement d'objet. \n Alt + Glisser pour repasser en mode al�atoire." pos:[8,390] width:130 height:90
	
	-- Evenements 
	
	on ckb1 changed state do (if state then starttool brush)
	
) -- end rollout

rollout help "Remarques" 
(
label lbl6 "1- L'altim�trisation ne fonctionne pas en vue Utilisateur. Travailler en vue Perspective, Cam�ra ou Dessus.\n\n2- Si l'orientation est d�termin�e suivant le sens du gliss�, le premier objet cr�� est mal orient�." pos:[8,6] width:150 height:200
)

try (closerolloutfloater floatBRUSH) catch () 
floatBRUSH = newrolloutfloater "Veget Brush" 200 541 20 100
addrollout params floatBRUSH
addrollout help floatBRUSH rolledup:true
	)
)