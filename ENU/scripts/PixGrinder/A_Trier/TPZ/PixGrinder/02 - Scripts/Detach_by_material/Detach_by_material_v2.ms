------------------------------------------------
-- Brouillon
------------------------------------------------
(
	pda = GetCurrentSelection()
	pda_ar = #()

			for i = 1 to pda[1].material.count do
			(
				select pda[1]
				max modify mode
				subobjectLevel = 4
				$.EditablePoly.selectByMaterial i
				x = polyop.getFaceSelection $
				polyop.detachFaces $  x asNode:true name:((pda[1].name)+"_sub_"+(i as string))
				
				--obj.material = pda[1].material[i]
				
			)

			
			--           i=10
			
			for i = 1 to pda[1].material.count do
			(
				if (execute("$"+(pda[1].name)+"_sub_"+(i as string))) != undefined do
					(
					select (execute("$"+(pda[1].name)+"_sub_"+(i as string)))
					(execute("$"+(pda[1].name)+"_sub_"+(i as string))).material = pda[1].material[i]
				)
			)
			
			subobjectLevel = 0
			delete pda[1]
)



