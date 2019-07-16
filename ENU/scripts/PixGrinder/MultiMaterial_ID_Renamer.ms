-- MultiMaterial renamer -- 
-- Adds names for multimaterial channels --
-- v1.0 --


(
	fn NameMatID mtl =
	(
		for i = 1 to mtl.count do 
		(
			if classof mtl[i] == Standardmaterial then
			(
				if mtl[i].diffuseMap != undefined and mtl[i].diffuseMap.bitmap != undefined then mtl.names[i] = getFilenameFile mtl[i].diffuseMap.bitmap.filename
				if mtl[i].diffuseMap == undefined then mtl.names[i] = ("color_") + (i as string)
			)

			if classof mtl[i] == PhysicalMaterial then
			(
				if mtl[i].base_color_map != undefined and mtl[i].base_color_map.bitmap != undefined then mtl.names[i] = getFilenameFile mtl[i].base_color_map.bitmap.filename
				if mtl[i].base_color_map == undefined then mtl.names[i] = ("color_") + (i as string)
			)
		)
	)

	myMats = for obj in selection where classof obj.material == Multimaterial collect obj.material

	for obj in myMats do NameMatID obj
)