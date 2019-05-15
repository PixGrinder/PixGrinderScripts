rollout pdaroll "Path"
(
	label lbl1 "New Path :"
	edittext txt1 fieldWidth:500
	button btn1 "OK"
	
	on btn1 pressed do
	(
		pda = getclassInstances bitmaptexture
		for i = 1 to pda.count do
		(
			if pda[i].filename != undefined do pda[i].filename = (txt1.text + "\\"+filenamefrompath pda[i].filename)
		)
		--print (txt1.text + "\\"+filenamefrompath pda[1].filename)
		destroyDialog pdaroll
	)
	

	
)

createDialog pdaroll width:540



---------------------------------------------

pda = getclassInstances bitmaptexture

filenamefrompath pda[1].filename

pda[18].filename
pda.count
meditmaterials[1] = pda[18]