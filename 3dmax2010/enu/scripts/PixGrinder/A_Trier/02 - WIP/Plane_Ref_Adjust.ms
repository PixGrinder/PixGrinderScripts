-- adjust plane

(
	clearListener()
	fn adjust = 
	(
		if selection.count > 1 do 
		(
			messageBox ("please select only 1 plane")
			exit
		)



		if classof selection[1] != plane do
		(
			messageBox ("please select a plane primitive") 
			exit
		)
		
		if classof selection[1].material != standardMaterial do
		(
			messageBox ("assign a bitmap to the plane") 
			exit
		)
		
		if classof selection[1].material.diffusemap  != Bitmaptexture do
		(
			messageBox ("assign a bitmap to the plane") 
			exit
		)
		
		if classof selection[1].material.diffusemap.filename  == undefined do
		(
			messageBox ("assign a bitmap to the plane") 
			exit
		)
			
		myX = selection[1].material.diffusemap.bitmap.width as float
		myY= selection[1].material.diffusemap.bitmap.height as float
		myRatio = (myY/myX)
		
		selection[1].length = selection[1].width * myRatio
		
	)

	adjust()

)


