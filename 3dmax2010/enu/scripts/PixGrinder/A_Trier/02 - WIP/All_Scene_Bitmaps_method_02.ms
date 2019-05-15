


(
	global pda_ar = #()
	global bitmapName = getClassInstances BitmapTexture
	
	for i = 1 to bitmapName.count do
	(
		
		if bitmapName[i].bitmap != undefined do
		(
			appendifunique pda_ar bitmapName[i].bitmap.filename
			x1 = bitmapName[i].bitmap.width
			y1 = bitmapName[i].bitmap.height
			--print bitmapName[i].bitmap.filename
		)
	)
	
	--pda_ar
)


bitmapName[15].bitmap.filename

bitmapName[i].bitmap.width



i = 563
meditmaterials[1] = bitmapName[i]


x = 256
x = x/2
log 2
pow 2 8
x= 4096.0
x = x/2

------------------------

-- nearest power of 2 function
(
	--global pda_origin = 4000
	
	fn powoftwo n1=
	(
		x=n1
		pda_origin = n1
		y=0
		while x > 1 do
		(
			x = x/2
			print ("x = "+(x as string))
			y+=1
		)

		print ("y = "+(y as string))

		x1 = pow 2 y
		x2 = pow 2 (y+1)
			
		pda_moy = (x1+x2)/2
			
		if pda_origin > pda_moy then print ("ARRONDI SUPERIEUR : " + (x2 as string)) else print ("arrondi inferieur : " + (x1 as string))
	)


rollout chooseNum "Number Chooser"
(
	label txt1 "Choose Number" pos:[40,10]
	spinner field1 "" type:#integer pos:[45,35] range:[16,100000,4000] --width:100 height:20 
	button okbtn "OK" pos:[60,65]
	
	on okbtn pressed do
	(
		
		powoftwo(field1.value)
		
		destroydialog chooseNum
	)
)

CreateDialog chooseNum 150 100

)
	


	
	
	
	
	
	
	
	
	