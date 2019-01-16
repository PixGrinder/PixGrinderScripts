-- Physical Defaults ! --

fn getPBR = 
(
	myAr = #()
	for obj in selection do 
	(
		if classof obj.material == PhysicalMaterial then appendifUnique myAr obj.material
		if classof obj.material == multiMaterial then 
		(
			for i = 1 to obj.material.count do
			(
				if classof obj.material[i] == PhysicalMaterial then appendifUnique myAr obj.material[i]
			)

		)
	)
	return myAr
)

rollout physControl "Phyical Material Control"
(
	label lbl1 "Base Color :  " offset:[20,15] across:4
	spinner myClr "" range:[0.0,1.0,1.0] type:#float scale:0.01 fieldwidth:30 offset:[15,15]
	colorpicker myClrRGB "" color:(color 255 255 255 255) alpha:false offset:[18,13]
	checkbox clrCheck "" checked:true offset:[10,15]
	label lbl2 "Transparency :  " offset:[20,5] across:4
	spinner myTrans "" range:[0.0,1.0,0.0] type:#float scale:0.01 fieldwidth:30 offset:[15,5]
	colorpicker myTransClr "" color:(color 255 255 255 255) alpha:false offset:[18,3]
	checkbox transCheck "" checked:true offset:[10,5]
	label lbl3 "Emission :  " offset:[20,5] across:4
	spinner myEmit "" range:[0.0,1.0,0.0] type:#float scale:0.01 fieldwidth:30 offset:[15,5]
	colorpicker myEmitClr "" color:(color 0 0 0 255) alpha:false offset:[18,2]
	checkbox emitCheck "" checked:true offset:[10,5]
	spinner myRough "Roughness :  " range:[0.0,1.0,0.3] type:#float scale:0.01 fieldwidth:30 offset:[-50,5]
	spinner myMet "Metalness :  " range:[0.0,1.0,0.0] type:#float scale:0.01 fieldwidth:30 offset:[-50,5]
	spinner myBump "Bump :  " range:[0.0,1.0,0.0] type:#float scale:0.01 fieldwidth:30 offset:[-60,5]
	button mySel "Select All" offset:[0,20] across:3
	button myOk "OK" offset:[0,20]
	button myReset "Reset" offset:[0,20]

	on myOk pressed do
	(
		lastMat = meditmaterials[24]
		x1 = getPBR()
		for obj in x1 do 
		(
			meditmaterials[24] = obj
			if clrCheck.checked then meditmaterials[24].base_color = myClrRGB.color
			meditmaterials[24].base_weight = myClr.value
			meditmaterials[24].roughness = myRough.value
			meditmaterials[24].metalness = myMet.value
			meditmaterials[24].transparency = myTrans.value
			if transCheck.checked then meditmaterials[24].trans_color = myTransClr.color
			meditmaterials[24].emission = myEmit.value
			if emitCheck.checked then meditmaterials[24].emit_color = myEmitClr.color
			meditmaterials[24].bump_map_amt = myEmit.value
			meditmaterials[24].roughness_inv = on
		)
		meditmaterials[24] = lastMat
	)


	on myReset pressed do
	(
		myClr.value = 1.0
		myClrRGB.color = (color 255 255 255 255)
		clrCheck.checked = true
		myTrans.value = 0.0
		myTransClr.color = (color 255 255 255 255)
		transCheck.checked = true
		myEmit.value = 0.0
		myEmitClr.color = (color 0 0 0 255)
		emitCheck.checked = true
		myRough.value = 0.3
		myMet.value = 0.0
		myBump.value = 0.0
	)

	on mySel pressed do select geometry

)

createDialog physControl 250 270 800 300