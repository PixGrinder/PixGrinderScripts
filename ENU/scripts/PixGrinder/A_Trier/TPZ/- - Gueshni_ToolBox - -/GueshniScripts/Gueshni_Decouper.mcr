macroScript Decouper category:"- Gueshni -" Icon:#("g9_decouper", 1) tooltip:"Decouper"
 (
	 on execute do
	(
		try(DestroyDialog DcoupeR)catch()


rollout DcoupeR "DcoupeR"
(
--**************************** INTERFACE ****************************	
	group "Faces Check"(
		
		
		radiobuttons MinMax labels:#("<+>","<->") pos:[8,25]
		
		button sel "SELECT" width:50 height: 50 align:#right  pos:[90,12] 
		spinner nbfaces "" pos:[10,45] width:75 type:#integer  range:[1,500000,40000]
	)
		
group "DecoupeR"	(
spinner size "rayon: " range:[0.0001,50000,500]	width:142 align:#left
button proced "DEBITER" width:130 
)
	
--**************************** VARIABLES ****************************
global LSTfaces = #()
global LSTselect= #()
global LSTnew= #()
global base, tol , decalageX , decalageY , selectioned, obj



--*************************** FUNCTIONS ****************************
fn selectZone  =
	(
		base = [($.min.X + decalageX),($.min.Y + decalageY),0.0]
		for f in 1 to LSTfaces.count do
			(		
				if  LSTfaces[f][1] <= base[1] +tol and LSTfaces[f][1] >=  base[1] - tol  and  LSTfaces[f][2] <= base[2] + tol and LSTfaces[f][2] >=  base[2] - tol  then
						( append  LSTselect f)
				else  ()	
			)
	)
	
	
--**************************** HANDLERS ****************************

on sel pressed do
		(
			clearselection()
			case MinMax.state of
			(
				1:(selectioned = for obj in objects where Classof obj == Editable_Poly and (polyop.getNumFaces obj) >= nbfaces.value  collect obj ) 
				2:(selectioned = for obj in objects where Classof obj == Editable_Poly and (polyop.getNumFaces obj) <= nbfaces.value  collect obj )
				
			)

			--selectioned = for obj in objects where Classof obj == Editable_Poly and (polyop.getNumFaces obj) >= nbfaces.value  collect obj 
			if selectioned != undefined do select selectioned
			
						
		)


	
	on proced pressed do
			(
				if  $ == undefined do (MessageBox "Object empty")
				if Classof $ != Editable_Poly and $ != undefined   do 
					(
					if	queryBox "Object not -Editable_Poly- convertTo ?" title:"Bad Class Object" beep:true then ( convertTo $ (Editable_Poly))
						
					)
				if Classof $ == Editable_Poly do
				(
			------------------------------ init
				 LSTfaces = #()
				 LSTselect= #()
				 LSTnew= #()
				tol = size.value --5000
				decalageY = tol
				decalageX = tol

				divX = (((abs($.min.X - $.max.X))/(tol *2))+1) as integer
				divY = (((abs($.min.Y - $.max.Y))/(tol *2))+1) as integer
				
			--------------------------- traitement	
				-- BDD position des faces
				for faces in 1 to $.numfaces do  (append  LSTfaces (polyop.getFaceCenter $ faces))	
				-- Traitement BDD
					for DecY in 1 to divY do
						(
							for DecX in 1 to divX do
								(
									selectZone()
									append LSTnew LSTselect 
									LSTselect = #()
									decalageX +=(tol*2)
								)
						decalageX = tol		
						decalageY +=(tol*2)
						)
				-- On detache les faces
				for detach in 1 to LSTnew.count do
					(
						if  LSTnew[detach] != undefined or LSTnew[detach] !="" then
						(
							$. wirecolor = color  (random 0 255) (random 0 255) (random 0 255)
							polyop.detachFaces $ LSTnew[detach] delete:false  asNode:true name:( "veget_" +detach as string)
						)
						else(print "exeption LST empty")
					)
				delete $
				centerPivot $veget*
			)	
		)			
	)-- End rollout DecoupeR				

CreateDialog DcoupeR 150 140
	)
)