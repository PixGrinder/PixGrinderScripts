 (
 
 --------------------------------------------------------
--===========   GEN TRAFIC   ===========================
--------------------------------------------------------




--BLOK CHOIX DES ESSENCES & CREATION
	try(destroyDialog creatTraf)catch()
rollout creatTraf "Traffic Generator"
(



	
group "Select Trajectories "
(
	button addTraj "Add Trajectories" width:100  pos:[15,30]
	listbox TrajLST "Trajectories:" items:  #()
)	
	
group "Select Vehicles"	
(
	button addCars "Add Vehicles" width:100 pos:[15,240]		
	listbox CarLST "Vehicles:" items:  #()
)	
	
group "Vehicles Parameters "	
(	
	spinner NB_cars "Vehicles Number:" range:[0,500,10] type:#integer  width:100
	spinner speed_cars "Vehicles Speed:" range:[0,140,40] type:#integer  width:100 
	spinner ecart "Vehicles Gap:" range:[50,99,70] type:#integer  width:100 
	radiobuttons copy_type labels:#( "copy" ,"instance","reference" )
)	

group "Animation Parameters "
(
	radiobuttons look_AT labels: #("X","Y","Z") 
	checkbox flip_axis "Flip Axis" checked: false align: #center

)	

group "NOVA"
(
	checkbox uncompress "Uncompressed Animation" value: false align:#center
)

group "Generation"
(
	button delet "Clean Objects" width:200
	button fliproad "Invert Direction"       width:200	
	edittext nameCar "Prefix Vehicles"  width:200
	button creation "GENERATION"       width:200 
	button changeCar "Change Vehicle SELECTION" width:200 visible: false
)
	
local trajObject , distSpline , EndFram   , SpeedCar , pik , oldNBcras
local	voiture = #()
local pik = false
local voitureCREAT = #()
local  oldcars = #()

local LSTSplines = #()
local LSTCars    = #()

local cop = copy
local inst = instance
local ref = reference
	

--------------------------  FONCTIONS ----------------------------------

fn addSelected  LSTobj  type  =
(
	-- type 1: spline  et type 2: editpoly
	for sel in 1 to selection.count do
		(
				if type == 1 do
						(
								if classof   selection[sel]  != line and classof   selection[sel]  != splineshape then
									(messagebox  (selection[sel].name + " not spline "))
								else
									(append LSTobj selection[sel].name)
						)
				if type == 2 do
						(
									if classof   selection[sel]  != box  and classof   selection[sel]  != Editable_Poly then
									(messagebox  (selection[sel].name + " not mesh object "))
								else
									(append LSTobj selection[sel].name)
						)
		)-- end for sel
		clearSelection()
	

	for i in 1 to selection.count do (append LSTobj selection[i].name)
	
)	
	
---------------------------- ACTIONS ------------------------------------
-- slection de la spline	
on addTraj  pressed  do
		(	
			-- ajout des splines dans la liste 
				addSelected LSTSplines 1
				TrajLST.items = LSTSplines

		)

---selection des voitures
on addCars pressed do
		(
				--ajout des voitures dans la liste
				addSelected LSTCars 2	
				CarLST.items = LSTCars
				
				-- on fait apparaitre le boutton "changer voiture SELECTION"
				changeCAR.visible = true
		)

-- Boutton Clear List of objects
on delet pressed do 
			(
			objList.items = #()
			voiture = #()
			print (speed_cars.value)
			changeCAR.visible = false
			)
	
on changeCar pressed  do
			(
				if  objList.items[1]  == ""  then ( messageBox "vous devez selectioner un vehicule dans la liste")
				
				else (
							carDEL  = selection[1]		

								if  copy_type.state == 1 then  carREPLACE = cop  voiture[objList.selection] 
								if  copy_type.state == 2 then  carREPLACE = inst  voiture[objList.selection] 
								if  copy_type.state == 3 then  carREPLACE = ref   voiture[objList.selection] 
							
							carREPLACE.name = carDEL.name 
							carREPLACE.wireColor = voiture[objList.selection].wireColor 
							--deleteItem oldcars oldcars[item.name]
							--append oldcars carREPLACE
							
							splineconstainCAR = path_constraint() 
							carREPLACE.position.controller = splineconstainCAR
							splineconstainCAR.path = carDEL.position.controller.path 
							splineconstainCAR.follow = true 	
							splineconstainCAR.percent  = carDEL.position.controller.percent 
							splineconstainCAR.axis = carDEL.position.controller.axis
							splineconstainCAR.axisFlip = carDEL.position.controller.axisFlip
				
							delete carDEL
						)
			)
			
-----------------------------------------------------------------------------------------------------------------------------------------
on CarLST doubleClicked itm do 

					(
						temp = CarLST.items 
						deleteItem temp itm
						CarLST.items = LSTCars  = temp 
					)

----------------------------------------------------------------------------------------------------------------------------------------------------
			
			
			
			
----------------------------------------------------------------------------------------------------------------------
---------------------------- FONCTION DU BOUTTON CREATION   -----------------------------------------
---------------------------------------------------------------------------------------------------------------------
			
			
on creation pressed  do 
	undo on
			(		
				oldNBcras = NB_cars.value

				-- CONDITION si tout est ok lancement du script
				if  LSTCars[1] != undefined and LSTSplines[1] !=undefined do
				(
					
					-- BOUCLE ASSIGN SPLINES
					for l  in 1 to LSTSplines.count do
					(
					--Calcul de la vitesse en fonction de la longueur de la spline
					distSpline =curvelength (getnodebyname(LSTSplines[l]))
					speeder =  ( speed_cars.value * 1000 )/108000 as float
					EndFram = (distSpline / speeder  ) as integer
					-- def de la spline
					path1 = getnodebyname(LSTSplines[l])
					
					
					
					-- BOUCLE CRETA VOITURES
					for i  in 1 to NB_cars.value do
						(
								local rand = random 1 LSTCars.count
								pourcentecart = ( distSpline/ NB_cars.value) / (distSpline/ 99)  as float
								pourcentageSpline = ( i  *  pourcentecart ) - random 0.5 ((ecart.value/NB_cars.value)- 0.5) 
								
								if  copy_type.state == 1 then  car = cop  (getnodebyname (LSTCars[rand])) 
								if  copy_type.state == 2 then  car = inst  (getnodebyname (LSTCars[rand])) 
								if  copy_type.state == 3 then  car = ref   (getnodebyname (LSTCars[rand])) 
								
								car.name = path1.name + ( i as string )
								car.wirecolor = (getnodebyname(LSTCars[rand])).wirecolor									
									
									
								animationRange = interval 0 EndFram 
									
								-- NOVA property	
								if uncompress.checked == true then  setuserprop car "fullAnim" 1
								setuserprop car "AnimStart"  0
								setuserprop car   "AnimEnd"  EndFram								
								
								
								splineconstain = path_constraint() 
								car.position.controller = splineconstain
								splineconstain.path = path1
								splineconstain.follow = true 	
								splineconstain.percent = pourcentageSpline 
								print("look_AT.state")	
								print(look_AT.state)
								splineconstain.axisFlip =  flip_axis.state
								splineconstain.axis = look_AT.state
								append voitureCREAT car
								
								/*
								for v in 1 to i do
											(
												if ( distance car  voitureCREAT[v] <= 2 ) then
														(
														--messagebox "ca crain"
														print(v)
														--select voitureCREAT[i]
														
														splineconstain.percent = pourcentageSpline - 3
														)
										
											)	
								*/
						) -- END BOUCLE CRETA VOITURES
					oldcars = voitureCREAT

					)
						
						
						
						
					messagebox "CA ROULE MA POULE !!!"
				)
				
			

			
			)-- end creation
			
			
					
			
on fliproad pressed  do
		(
			if classof selection[1] == line  or classof selection[1] == splineShape  then 
					(
							Splinetraj = selection[1]
						
						max modify mode
						subobjectLevel = 3
						max select all
						splineOps.reverse  Splinetraj
						subobjectLevel = 0
						--clearSelection()
					
					)
			else
					(
					messageBox "Vous devez selectioner une spline"
					)
		)
)-- end rollout creatTraf




rollout evalTraf "eval trafic"
(
	group "interaction"
	(
	pickbutton stop "<< choose stop object >>"  width: 200 height:15
	spinner dure "     durée: " visible:false	 width:67 align:#center range:[1,2000,10]
	spinner fps "frame Rate: " visible:false width:70 range:[1,160,30] align:#center type:#integer
	spinner timeEval " 0 à" visible:false width:70 range:[1,50000,100] align:#center type:#integer
	)
	button add "ADD" across:2
	button del  "DEL"  
	listbox allcars "voitures"
	
	button eval "evaluer le trafic"
-- ///////////////  VARIABLES \\\\\\\\\\\\\\\\\\
global LSTcarEval = #()
global lstVoiture = #()
global lstTime = #() 
	
--//////////////// FUNTIONS \\\\\\\\\\\\\\\\\\\
fn addSelected  LSTobj   =
(
	
	for i in 1 to selection.count do (append LSTobj selection[i].name)
	clearSelection()	
)		
	
	
	
--///////////////// ACTIONS \\\\\\\\\\\\\\\\\\\\\\\\\\	
on stop picked obj do
(
	stop.text = obj.name
	dure.visible   = fps.visible = timeEval.visible = true

)

on add pressed do 
	(
		addSelected LSTcarEval 
		allcars.items = LSTcarEval 
		)
		
on del pressed do 
	(
		LSTcarEval = #()  
		allcars.items = LSTcarEval 
	)		

on eval pressed do
(
	undo on
			-- evaluation des voiture quant elles entre en colision avec le "STOP"
			for i in 1 to timeEval.value do
			(
				sliderTime = i
				--oldpercent = $Line011.pos.controller.percent
				for v in 1 to LSTcarEval.count do 
						(
						if  intersects (getnodebyname (stop.text ))  (getnodebyname (LSTcarEval[v])) == true  do
								(
									if  appendIfUnique   lstVoiture    LSTcarEval[v] == true then
											(
												appendIfUnique   lstVoiture    LSTcarEval[v]
												append   lstTime    i
											)
									else (print(LSTcarEval[v] as string) )	
								)
						)--END for V
			)-- END for I	
				for k in 1 to  lstVoiture.count do
							(
								
								 animate on
								 (
									sliderTime =  lstTime[k]
									thecurrentCar = getnodebyname lstVoiture[K]
									oldprecent = thecurrentCar.pos.controller.percent
									newtime = lstTime[k] + dure.value
									at time lstTime[k]  thecurrentCar.pos.controller.percent = thecurrentCar.pos.controller.percent = oldprecent
									at time newtime 	thecurrentCar.pos.controller.percent = oldprecent
									)
							)			

) -- End eval
	
	
)-- end rollout  evalTraf


--SHUTDOWN DE LA FENETRE SI ELLE EST PRESENTE

-- if theNewFloatercreat != undefined do 
--             ( 
--             closerolloutfloater theNewFloatercreat 
--             )       

-- theNewFloatercreat = newRolloutFloater "GEN TRAFIC" 250 800

-- addRollout creatTraf  theNewFloatercreat
-- addRollout evalTraf  theNewFloatercreat

createdialog creatTraf  width:250 height:780 pos:[140,210] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)

)



