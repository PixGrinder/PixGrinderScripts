------------------------------------------------
-- Brouillon
------------------------------------------------


clearListener()
(
	global myError = #()
	global gem = #()
	for i = 1 to geometry.count do append gem geometry[i]
	
	for obj = 1 to gem.count do 
	(
		try
		(
			pda = geometry[obj]
			if classof pda.material == Multimaterial do
			(	
				pda_child = #()
				pda_ar = #()
				
				InstanceMgr.MakeObjectsUnique pda #individual
				
				if pda.children.count != 0 do
				(
					for i = 1 to pda.children.count do appendifunique pda_child pda.children[i]
				)
				
				
				for i = 1 to pda.material.count do
				(
					select pda
					max modify mode
					subobjectLevel = 4
					$.EditablePoly.selectByMaterial i
					x = polyop.getFaceSelection $
					polyop.detachFaces $  x asNode:true name:((pda.name)+"_sub_"+(i as string))
				)
				
				for i = 1 to pda.material.count do
				(
					if (execute("$"+(pda.name)+"_sub_"+(i as string))) != undefined do
						(
						select (execute("$"+(pda.name)+"_sub_"+(i as string)))
						$.material = pda.material[i]
						append pda_ar $
					)
				)
				subobjectLevel = 0
				myGroup = group pda_ar name:pda.name
				if myGroup.parent != undefined do
				(
					setGroupOpen myGroup true
					myGroup.pivot = pda.pivot
					myGroup.parent = pda.parent
				)
				setGroupOpen myGroup false
				if pda.children.count != 0 do
				(
					for i = 1 to pda_child.count do pda_child[i].parent = MyGroup
				)
				delete pda
			)
		) catch (print pda.name)
	)
)



----------------------------------


