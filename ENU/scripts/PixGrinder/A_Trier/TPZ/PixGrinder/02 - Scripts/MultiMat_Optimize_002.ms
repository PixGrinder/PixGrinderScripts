(
	clearListener()
	global mySelec = getCurrentSelection()
	for k = 1 to mySelec.count do 
	(
		pda = #()
		obj = mySelec[k]
		if classof obj.material == Multimaterial do
		(
			if obj.material.materialIDList[obj.material.count] != obj.material.count do
			(
				print (obj.name +" being processed")
				meditmaterials[1] = obj.material
				select obj
				max modify mode
				subobjectLevel = 4
				for i = 1 to obj.material.count do
				(
					$.EditablePoly.selectByMaterial i
					x = polyop.getFaceSelection $
					x = x as array
					if x.count != 0 do append pda i
				)
				meditmaterials[2] = Multimaterial()
				meditmaterials[2].name = meditmaterials[1].name + "_optim"
				meditmaterials[2].numsubs = pda.count
				for j = 1 to pda.count do 
				(
					meditmaterials[2][j] = obj.material[(pda[j])]
					$.EditablePoly.selectByMaterial (pda[j])
					youpla = polyop.getFaceSelection $
					polyop.setFaceMatID $ youpla j
				)
				subobjectLevel = 0
				obj.material = meditMaterials[2]
			)
		)
	)
)


