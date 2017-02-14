------------------------------------------------
-- Brouillon
------------------------------------------------

(
clearListener()
	(
		global myError = #()
		global gem = #()
		for i = 1 to geometry.count do 
		(
			if classof geometry[i].material ==  Multimaterial do appendifunique gem geometry[i]
		)
		
		for obj = 1 to gem.count do 
		(
			pda = gem[obj]  -- pda = objet couran de la boucle
			pda_child = #()
			pda_ar = #()
			global pda_ids = #()
			
			InstanceMgr.MakeObjectsUnique pda #individual
			
			if pda.children.count != 0 do
			(
				for i = 1 to pda.children.count do appendifunique pda_child pda.children[i]
			)
			
			---------------------------------------------
			-- Problème ci-dessous : 
			----------------------------------------------
			select pda
			max modify mode
			subobjectLevel = 4
				
			-- identification des id materiaux utilisés : 
			
			for i = 1 to pda.material.count do
			(
				$.EditablePoly.selectByMaterial i
				x = polyop.getFaceSelection $
				x = x as array
				if x.count != 0 do append pda_ids i
			)
			
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
				
				
-- 			if pda_ar.count > 1 then 
-- 			(
-- 			myGroup = group pda_ar name:pda.name
-- 			) else (
-- 				pda_ar[1].name = pda.name
-- 				myGroup = pda
-- 			)
-- 			if myGroup.parent != undefined do
-- 			(
-- 				try (setGroupOpen myGroup true) catch ()
-- 				myGroup.pivot = pda.pivot
-- 				myGroup.parent = pda.parent
-- 			)
-- 			try (setGroupOpen myGroup false) catch ()
-- 			if pda.children.count != 0 do
-- 			(
-- 				for i = 1 to pda_child.count do pda_child[i].parent = MyGroup
-- 				delete pda
-- 			)
		)
	)

)











----------------------------------
-- Backup :

				for i = 1 to pda.material.count do   ---  Pour chaque sub-material de l'objet en cours : 
				(
					if pda.material[i] != undefined do
					(
						myString = ((pda.name)+"_sub_"+(i as string))
						select pda
						max modify mode
						subobjectLevel = 4
						$.EditablePoly.selectByMaterial i					
						x = polyop.getFaceSelection $
						polyop.detachFaces $  x asNode:true name:myString
						subobjectLevel = 0
						for t in geometry do if t.name == myString do select t
						$.material = pda.material[i]
						append pda_ar $
					)
					
				)
				
				
