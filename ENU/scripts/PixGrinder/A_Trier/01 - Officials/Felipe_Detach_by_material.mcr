-------------------------------------------------------------------------------
-- Felipe_Detach_by_material.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2014/06/23
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------


macroScript Detach_by_material
category:"Felipe Scripts"
toolTip:"Detach polygon object by material"
buttonText:"Detach by Mat"
--icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true


(
	pda = GetCurrentSelection()
	pda_ar = #()
	if pda.count ==1 do
	(
		if classof pda[1].material == Multimaterial do
		(
			for i = 1 to pda[1].material.count do
			(
				select pda[1]
				max modify mode
				subobjectLevel = 4
				$.EditablePoly.selectByMaterial i
				x = polyop.getFaceSelection $
				polyop.detachFaces $  x asNode:true name:((pda[1].name)+"_sub_"+(i as string))
			)
			
			for j = 1 to ((pda[1].material.count)) do
			(
				y = (execute("$"+(pda[1].name)+"_sub_"+(j as string)))
				if y != undefined do 
				(
					select y
					meditmaterials[1] = pda[1].material[j]
					y.material = meditmaterials[1]
					max modify mode
					subobjectLevel = 4
					max select all
					z = polyop.getFaceSelection $
					polyop.setFaceMatID y z 1
					setSelectionLevel $ #object
				)
			)
			delete pda[1]
		)
	)
)



