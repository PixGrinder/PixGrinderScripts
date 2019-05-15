(
	global pda = getclassinstances bitmaptexture

	rollout resizor "Resizor !! "
	(
		label txt1 "Choose an option : " pos:[35,20]
		label txt2 "-----------------------" pos:[35,40]
		radiobuttons rad1  labels:#("Save Bitmaps","Overwrite Bitmaps") ---columns:2
		button mybutton "OK" width:50
		
		
		on mybutton pressed do
		(
			if rad1.state == 1 do
			(
				-- create folder to backup bitmaps
				if maxfilepath == "" then messagebox "Please save current scene to disk" else
				(
					myDir = ( "@\""+maxfilepath +"bitmap_backup\"")
					makeDir (execute myDir) all:false
				)
				-- copy bitmaps to backup folder
				for i = 1 to pda.count do
				(
					pda_nm = filenamefrompath pda[i].bitmap.filename 
					copyFile pda[i].bitmap.filename (maxfilepath+"bitmap_backup\\"+pda_nm)
				)
			)
			
			for i = 1 to pda.count do
			(
				mySizeX = pda[i].bitmap.width
				mySizeY = pda[i].bitmap.height
				myMap = renderMap pda[i] size:[512,512] filter:false fileName:(pda[i].bitmap.filename)
				display myMap
			)
			
			
			--print rad1.state
			destroyDialog resizor
		)
		
	)

	createDialog resizor height:150 --width:300 


)


------------------------

if maxfilepath == "" then messagebox "Please save current scene to disk" else
(
	myDir = ( "@\""+maxfilepath +"bitmap_backup\"")
	makeDir (execute myDir) all:false
)



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


$.material.diffusemap.bitmap



