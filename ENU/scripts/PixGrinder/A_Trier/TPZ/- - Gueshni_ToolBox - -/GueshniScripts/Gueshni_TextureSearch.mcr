macroScript TextureSearch category:"- Gueshni -" Icon:#("g9_texturesearch", 1) tooltip:"Texture Search"
	(
	rollout FindMapOccurRollout "Texture Search" width:162 height:60
(
	editText map_name "Filename" pos:[5,9] width:150 height:16
	button FindBTN "Find Occurrences" pos:[5,30] width:152 height:23
	
	on FindBTN pressed  do
	(
		_Mat = getclassinstances standardmaterial
		_index = 1
		for _Obj in _Mat do
		(
			if _Obj.diffusemap != undefined then
			(
				if (findString _Obj.diffusemap.filename map_name.text)!= undefined then
				(
					meditmaterials[_index]=_Obj
					_index = _index+1
				)
			)
		)
	)
)

createdialog FindMapOccurRollout
)