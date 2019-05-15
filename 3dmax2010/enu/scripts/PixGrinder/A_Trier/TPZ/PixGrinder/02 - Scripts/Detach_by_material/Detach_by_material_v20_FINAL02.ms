------------------------------------------------
-- Brouillon
------------------------------------------------

(
clearListener()
	(
		global myError = #()
		global gem = #()
		global useless = #()
		for i = 1 to geometry.count do 
		(
			if classof geometry[i].material ==  Multimaterial do appendifunique gem geometry[i]
		)
		
		progressStart "Working..."
		--myPad = 100.0/gem.count
		global myProg = 0
		
		for obj = 1 to gem.count do 
		(
				global pda = gem[obj]  -- pda = objet couran de la boucle
				select pda
				InstanceMgr.MakeObjectsUnique pda #individual
				convertToPoly(pda)
				if polyop.getNumFaces pda != 0 then
				(
					print pda.name -- debug
					global pda_child = #()
					global pda_ar = #()
					global pda_ids = #()
					
					
					
					if pda.children.count != 0 do
					(
						for i = 1 to pda.children.count do appendifunique pda_child pda.children[i]
					)
					
					---------------------------------------------
					-- Problème ci-dessous : 
					----------------------------------------------
					select pda
					print (pda.name+" is selected" )
					max modify mode
					select pda
					subobjectLevel = 4
						
					-- identification des id materiaux utilisés : 
					--------------------------------
					--------------------------------
					--------------------------------
					--------------------------------
					myCount = polyop.getNumFaces pda
					myAr = #()
					select pda
					max modify mode
					subobjectLevel = 4
					for i = 1 to myCount do 
					(
						x = polyop.getFaceMatID pda i
						appendifunique myAr x
					)
					sort myAr
					
					--------------------------------
					--------------------------------
					--------------------------------
					--------------------------------
					
-- 					for i = 1 to pda.material.count do
-- 					(
-- 						$.EditablePoly.selectByMaterial i
-- 						x = polyop.getFaceSelection $
-- 						x = x as array
-- 						if x.count != 0 do append pda_ids i
-- 					)
					
					-- détacher objets par id materiau utilisé : 
					
					for i = 1 to pda_ids.count do
					(
						select pda
						max modify mode
						subobjectLevel = 4
						myVar = pda_ids[i]
						myString = ((pda.name)+"_sub_"+(myVar as string))
						$.EditablePoly.selectByMaterial myVar
						x = polyop.getFaceSelection $
						polyop.detachFaces $  x asNode:true name:myString
						subobjectLevel = 0
						for t in geometry do if t.name == myString do select t
						$.material = pda.material[myVar]
						append pda_ar $
					)
						
						
					myGroup = group pda_ar name:pda.name
					
					if pda.parent != undefined do
					(
						try (setGroupOpen myGroup true) catch ()
						-- try added below
						try (myGroup.parent = pda.parent) catch( print ("hierarchy error on "+pda.name))
					)
					try (setGroupOpen myGroup true) catch ()
					myGroup.pivot = pda.pivot
					try (setGroupOpen myGroup false) catch ()
					if pda.children.count != 0 do
					(
						for i = 1 to pda_child.count do pda_child[i].parent = MyGroup
					)
					delete pda
				) else (print "Warning : "+ (pda.name)+" has no faces !")
				
				if (100*(obj as float)/gem.count) > (myProg as float) do
				(
					myProg = myProg+1
					progressUpdate myProg
				)
				test = myProg as string
				if findstring test "0" != undefined do sleep 1
		
		)
		progressEnd()
	)
)





