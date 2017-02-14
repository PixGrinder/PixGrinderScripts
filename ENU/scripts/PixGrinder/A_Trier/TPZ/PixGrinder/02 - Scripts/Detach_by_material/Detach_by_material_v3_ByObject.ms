------------------------------------------------
-- Brouillon
------------------------------------------------
(
	pda = GetCurrentSelection()
	pda = pda[1]
	-- select pda
	InstanceMgr.MakeObjectsUnique pda #individual
	--pda.parent
	pda_ar = #()

			for i = 1 to pda.material.count do
			(
				select pda
				max modify mode
				subobjectLevel = 4
				$.EditablePoly.selectByMaterial i
				x = polyop.getFaceSelection $
				polyop.detachFaces $  x asNode:true name:((pda.name)+"_sub_"+(i as string))
				
				--obj.material = pda.material[i]
				
			)

			
			--           i=10
			
			for i = 1 to pda.material.count do
			(
				if (execute("$"+(pda.name)+"_sub_"+(i as string))) != undefined do
					(
					select (execute("$"+(pda.name)+"_sub_"+(i as string)))
					$.material = pda.material[i]
					append pda_ar $
					--(execute("$"+(pda.name)+"_sub_"+(i as string))).material = pda.material[i]
				)
			)
			
			subobjectLevel = 0
			myGroup = group pda_ar name:pda.name
			setGroupOpen myGroup true
			myGroup.pivot = pda.pivot
			myGroup.parent = pda.parent
			select myGroup.parent
			delete pda
)





