------------------------------------------------
-- Brouillon
------------------------------------------------

(
clearListener()
	(
		global myError = #()
		global gem = #()
		for i = 1 to geometry.count do append gem geometry[i]
		
		for obj = 1 to gem.count do 
		(
				pda = gem[obj]  -- pda = objet couran de la boucle
				
				if classof pda.material == Multimaterial do   -- si pda a un multimateriau, sauvegarde sa hierarchy et rends l'objet unique
				(
					pda_child = #()
					pda_ar = #()
					
					InstanceMgr.MakeObjectsUnique pda #individual
					
					if pda.children.count != 0 do
					(
						for i = 1 to pda.children.count do appendifunique pda_child pda.children[i]
					)
					
					---------------------------------------------
					-- Problème ci-dessous : 
					----------------------------------------------
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
					
					
					
	-- 				
	-- 				if pda_ar.count > 1 then 
	-- 				(
	-- 				myGroup = group pda_ar name:pda.name
	-- 				) else (
	-- 					pda_ar[1].name = pda.name
	-- 					myGroup = pda
	-- 				)
	-- 				if myGroup.parent != undefined do
	-- 				(
	-- 					try (setGroupOpen myGroup true) catch ()
	-- 					myGroup.pivot = pda.pivot
	-- 					myGroup.parent = pda.parent
	-- 				)
	-- 				try (setGroupOpen myGroup false) catch ()
	-- 				if pda.children.count != 0 do
	-- 				(
	-- 					for i = 1 to pda_child.count do pda_child[i].parent = MyGroup
	-- 				)
	-- 				delete pda
				)
		)
	)
)



----------------------------------


