(
	clearlistener()
	global x=1
	while x != 100 do 
	(
		pda1 =  pickObject()
		if pda1 == undefined then exit
		
		clearlistener()
		-- global pda = getcurrentSelection()
		global test = #()
		pda = pda1
		convertToPoly(pda)
		for i = 1 to geometry.count do 
		(
			if classof geometry[i].material == standardmaterial and geometry[i].material.diffusemap != undefined and pda.material.diffusemap != undefined  do
			(
				gemFile = filenamefrompath geometry[i].material.diffusemap.bitmap.filename
				pdaFile = filenamefrompath pda.material.diffusemap.bitmap.filename
				if gemFile == pdaFile do
				(
					--polyop.attach pda geometry[i]
					append test geometry[i]
				)
			)
		)
		if test.count > 1 do
		(
			myMat = pda.material
			print test.count
			--select test
			convertToPoly(test[1])
			select test[1]
			for k = 2 to test.count do polyop.attach $ test[k]
			$.material = myMat
			hide $
		)	
		try (hide pda) catch()
		x = x+1
	) 
)


